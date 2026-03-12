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

    final useAuthToken = options.extra[_useAuthTokenKey] as bool? ?? true;
    if (!useAuthToken) {
      options.headers.remove('Authorization');
      return handler.next(options);
    }

    final authRepo = service<AuthRepository>();
    final asyncPrefs = SharedPreferencesAsync();

    final userData = await asyncPrefs.getStringList("USERDATA");
    String? accessToken =
        userData != null && userData.length >= 5 ? userData[4] : null;

    if (accessToken == null || accessToken.isEmpty) {
      return handler.next(options);
    }

    if (_isRefreshExemptPath(options.path)) {
      options.headers['Authorization'] = 'Bearer $accessToken';
      return handler.next(options);
    }

    final expiryMillis = _decodeJwtExpiry(accessToken);
    final now = DateTime.now().millisecondsSinceEpoch;

    const refreshBefore = 10 * 60 * 1000;
    final needsRefresh =
        expiryMillis != null && now >= (expiryMillis - refreshBefore);

    if (needsRefresh) {
      print("🔄 Token almost expired → Refreshing...");

      final refreshSuccess = await authRepo.refreshToken();

      if (refreshSuccess) {
        final newUserData = await asyncPrefs.getStringList("USERDATA");
        accessToken = newUserData != null && newUserData.length >= 5
            ? newUserData[4]
            : null;

        print("✅ Token refreshed");
      } else {
        print("❌ Refresh failed → continue with old token");
      }
    }

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
const _useAuthTokenKey = 'useAuthToken';

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
    bool useAuthToken = true,
    Deserializer<T>? deserializer,
    Map<String, dynamic>? queryParams,
    ProgressCallback? progressCallback,
  }) async {
    try {
      final res = await dio.get(
        url,
        data: data,
        options: _withAuthOption(options, useAuthToken),
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
    bool useAuthToken = true,
    Deserializer<T>? deserializer,
    Map<String, dynamic>? queryParams,
    ProgressCallback? progressCallback,
    Map<String, String>? headers,
  }) async {
    try {
      final res = await dio.post(
        url,
        data: data,
        options: _withAuthOption(options, useAuthToken, headers: headers),
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
    bool useAuthToken = true,
    Deserializer<T>? deserializer,
    ProgressCallback? progressCallback,
  }) async {
    try {
      final res = await dio.put(
        url,
        data: data,
        options: _withAuthOption(options, useAuthToken),
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
    bool useAuthToken = true,
    Deserializer<T>? deserializer,
  }) async {
    try {
      final res = await dio.patch(
        url,
        data: data,
        options: _withAuthOption(options, useAuthToken),
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

  ///[delete] Reusable DELETE request utilizing dio capabilities
  static HttpResult<T> delete<T>(
    String url, {
    Options? options,
    bool useAuthToken = true,
    Deserializer<T>? deserializer,
  }) async {
    try {
      final res = await dio.delete(
        url,
        options: _withAuthOption(options, useAuthToken),
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

  static Options _withAuthOption(
    Options? options,
    bool useAuthToken, {
    Map<String, String>? headers,
  }) {
    final mergedExtra = <String, dynamic>{
      ...?options?.extra,
      _useAuthTokenKey: useAuthToken,
    };

    final mergedHeaders = <String, dynamic>{
      ...?options?.headers,
      ...?headers,
    };

    return (options ?? Options()).copyWith(
      extra: mergedExtra,
      headers: mergedHeaders.isEmpty ? null : mergedHeaders,
    );
  }
}

bool _isRefreshExemptPath(String path) {
  const exemptPaths = <String>[
    "User/refresh",
    "/User/emaillogin",
    "/User/googlelogin",
    "/User/applelogin",
  ];

  return exemptPaths.any(path.contains);
}

int? _decodeJwtExpiry(String token) {
  final parts = token.split('.');
  if (parts.length != 3) return null;
  try {
    final payload =
        utf8.decode(base64Url.decode(base64Url.normalize(parts[1])));
    final Map<String, dynamic> payloadMap = jsonDecode(payload);
    final exp = payloadMap['exp'];
    if (exp is int) return exp * 1000;
    if (exp is String) {
      final parsed = int.tryParse(exp);
      return parsed != null ? parsed * 1000 : null;
    }
    return null;
  } catch (_) {
    return null;
  }
}
