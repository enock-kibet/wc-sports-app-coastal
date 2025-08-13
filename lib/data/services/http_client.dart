part of 'service.dart';

class RequestInterceptor extends Interceptor {
  @override
  FutureOr<dynamic> onRequest(
      RequestOptions options, RequestInterceptorHandler handler) {
        options.headers['Accept'] = 'application/json';
    options.headers['Content-Type'] = 'application/json';
    options.headers['Authorization'] =
        'Bearer ${service<AppPreferencesManager>().currentUserValue?.token}';
    
    super.onRequest(options, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    if (err.response?.statusCode == 401 &&
        !err.response!.realUri.path.contains("v1/login")) {
          }
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
        ProgressCallback? progressCallback, Map<String, String> headers = const {},
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
