part of 'service.dart';

class RequestInterceptor extends Interceptor {
  SharedPreferencesAsync get asyncPrefs => SharedPreferencesAsync();
  @override
  // Future onRequest(
  //     RequestOptions options, RequestInterceptorHandler handler) async {
  //   options.headers['Accept'] = 'application/json';
  //   options.headers['Content-Type'] = 'application/json';
  //   // Get current token
  //   final _authRepository = service<AuthRepository>();
  //   final _prefs = service<AppPreferencesManager>();
  //   final userData = await asyncPrefs.getStringList("USERDATA");
  //   final token = userData != null && userData.length >= 5 ? userData[4] : null;

  //   if (token != null) {
  //     options.headers['Authorization'] = 'Bearer $token';
  //   }

  //   super.onRequest(options, handler);
  // }

  @override
  Future onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    options.headers['Accept'] = 'application/json';
    options.headers['Content-Type'] = 'application/json';

    final prefs = service<AppPreferencesManager>();
    final authRepo = service<AuthRepository>();
    final asyncPrefs = SharedPreferencesAsync();

    final userData = await asyncPrefs.getStringList("USERDATA");
    String? accessToken =
        userData != null && userData.length >= 5 ? userData[4] : null;

    // Skip refresh for refresh endpoint itself
    if (options.path.contains("User/refresh") ||
        options.path.contains("/User/emaillogin") ||
        options.path.contains("/User/googlelogin")) {
      if (accessToken != null && accessToken.isNotEmpty) {
        options.headers['Authorization'] = 'Bearer $accessToken';
      }
      return handler.next(options);
    }

    // Decode expiry
    final expiryMillis = _decodeJwtExpiry(accessToken!);
    final now = DateTime.now().millisecondsSinceEpoch;

    // Refresh 20 minutes before expiry
    const refreshBefore = 10 * 60 * 1000;

    final needsRefresh = now >= (expiryMillis - refreshBefore);

    if (needsRefresh) {
      print("🔄 Token almost expired → Refreshing...");

      final refreshSuccess = await authRepo.refreshToken();

      if (refreshSuccess) {
        // ⬅️ Reload NEW token from prefs
        final newUserData = await asyncPrefs.getStringList("USERDATA");
        accessToken = newUserData != null && newUserData.length >= 5
            ? newUserData[4]
            : null;

        print("✅ Token refreshed");
      } else {
        print("❌ Refresh failed → continue with old token");
      }
    }

    // Attach token
    if (accessToken != null && accessToken.isNotEmpty) {
      options.headers['Authorization'] = 'Bearer $accessToken';
    }

    return handler.next(options);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    if (err.response?.statusCode == 401 &&
        !err.response!.realUri.path.contains("v1/login")) {}
    super.onError(err, handler);
  }
}

///[Deserializer] takes in data and transform it to desired type[X]
typedef Deserializer<X> = X Function(dynamic data);
typedef HttpResult<X> = Future<MultipleResult<X>>;
final cookieJar = CookieJar();

class Http {
  static final dio = Dio(BaseOptions(
    //baseUrl: BASE_URL,
    receiveDataWhenStatusError: true,
    connectTimeout: const Duration(milliseconds: TIMEOUT),
    sendTimeout: const Duration(milliseconds: TIMEOUT),
    receiveTimeout: const Duration(milliseconds: TIMEOUT),
  ))
    ..interceptors.addAll([
      // HttpFormatter(),
      CookieManager(cookieJar),
      RequestInterceptor(),
      if (kDebugMode)
        TalkerDioLogger(
          talker: service<Talker>(),
          settings: const TalkerDioLoggerSettings(
            printRequestHeaders: true,
          ),
        ),
      // LogInterceptor(requestBody: true, responseBody: true),
    ]);

  ///[get] Reusable GET request utilizing dio capabilities
  static HttpResult<T> get<T>(
    String url, {
    dynamic data,
    Options? options,
    Deserializer<T>? deserializer,
    Map<String, dynamic>? queryParams,
    ProgressCallback? progressCallback,
  }) async {
    try {
      final res = await dio.get(
        url,
        data: data,
        options: options,
        queryParameters: queryParams,
        onReceiveProgress: progressCallback,
      );
      return MultipleResult.onSuccess(
        data: deserializer != null ? deserializer(res.data) : res.data,
      );
    } on DioException catch (error) {
      debugPrint("DIO Error: $error");
      return MultipleResult.onError(
        error: ErrorHandler(error).handle(),
      );
    } catch (error) {
      debugPrint(error.toString());
      return MultipleResult.onError(
        error: Failure(error: "Unexpected error occurred"),
      );
    }
  }

  ///[post] Reusable POST request utilizing dio capabilities
  static HttpResult<T> post<T>(
    String url,
    dynamic data, {
    Options? options,
    Deserializer<T>? deserializer,
    Map<String, dynamic>? queryParams,
    ProgressCallback? progressCallback,
    Map<String, String> headers = const {},
  }) async {
    try {
      final res = await dio.post(
        url,
        data: data,
        options: options,
        queryParameters: queryParams,
        onSendProgress: progressCallback,
      );
      return MultipleResult.onSuccess(
        data: deserializer != null ? deserializer(res.data) : res.data,
      );
    } on DioException catch (error) {
      debugPrint("dio exception: ${error.error.toString()}");
      return MultipleResult.onError(
        error: ErrorHandler(error).handle(),
      );
    } on Exception catch (error) {
      debugPrint(" some exception: ${error.toString()}");
      return MultipleResult.onError(
        error: Failure(error: "Unexpected error occurred"),
      );
    }
  }

  ///[put] Reusable PUT request utilizing dio capabilities
  static HttpResult<T> put<T>(
    String url,
    dynamic data, {
    Options? options,
    Deserializer<T>? deserializer,
    ProgressCallback? progressCallback,
  }) async {
    try {
      final res = await dio.put(
        url,
        data: data,
        options: options,
        onSendProgress: progressCallback,
      );
      return MultipleResult.onSuccess(
        data: deserializer != null ? deserializer(res.data) : res.data,
      );
    } on DioException catch (error) {
      return MultipleResult.onError(
        error: ErrorHandler(error).handle(),
      );
    } on Exception catch (_) {
      return MultipleResult.onError(
        error: Failure(error: "Unexpected error occurred"),
      );
    }
  }

  ///[patch] Reusable PATCH request utilizing dio capabilities
  static HttpResult<T> patch<T>(
    String url,
    dynamic data, {
    Options? options,
    Deserializer<T>? deserializer,
  }) async {
    try {
      final res = await dio.patch(url, data: data, options: options);
      return MultipleResult.onSuccess(
        data: deserializer != null ? deserializer(res.data) : res.data,
      );
    } on DioException catch (error) {
      return MultipleResult.onError(
        error: ErrorHandler(error).handle(),
      );
    } on Exception catch (_) {
      return MultipleResult.onError(
        error: Failure(error: "Unexpected error occurred"),
      );
    }
  }

  ///[delete] Reusable DELETE request utilizing dio capabilities
  static HttpResult<T> delete<T>(
    String url, {
    Options? options,
    Deserializer<T>? deserializer,
  }) async {
    try {
      final res = await dio.delete(
        url,
        options: options,
      );
      return MultipleResult.onSuccess(
        data: deserializer != null ? deserializer(res.data) : res.data,
      );
    } on DioException catch (error) {
      return MultipleResult.onError(
        error: ErrorHandler(error).handle(),
      );
    } on Exception catch (_) {
      return MultipleResult.onError(
        error: Failure(error: "Unexpected error occurred"),
      );
    }
  }
}

int _decodeJwtExpiry(String token) {
  final parts = token.split('.');
  if (parts.length != 3) throw Exception('Invalid JWT format');
  final payload = utf8.decode(base64Url.decode(base64Url.normalize(parts[1])));
  final Map<String, dynamic> payloadMap = jsonDecode(payload);
  return payloadMap['exp'] * 1000; // Convert to milliseconds
}
