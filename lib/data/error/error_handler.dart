import 'package:dio/dio.dart';

import 'failure.dart';

class ErrorHandler {
  final DioException error;

  ErrorHandler(this.error);

  Failure handle() {
    if (error.response?.statusCode == 302) {
      return Failure(error: "Check your internet connection/bundle balance");
    } else if (error.response?.data['message'] != null) {
      return Failure(
          error: error.response!.data['message'],
          precondition: error.response!.data["precondition"],
          description: error.response!.data["description"],
          value: error.response!.data["value"]);
    } else {
      switch (error.type) {
        case DioExceptionType.connectionTimeout:
          return Failure(error: "Connection timeout!");
        case DioExceptionType.sendTimeout:
          return Failure(error: "Send timeout!");
        case DioExceptionType.receiveTimeout:
          return Failure(error: "Request timeout!");
        case DioExceptionType.cancel:
          return Failure(error: 'Request canceled');
        case DioExceptionType.badResponse:
          final statusCode = error.response!.statusCode;
          switch (statusCode) {
            case 400:
              return Failure(
                error: error.response?.data["msg"] ?? 'Something went wrong',
              );
            case 401:
              return Failure(error: 'Unauthorized');
            case 403:
              return Failure(error: 'Forbidden');
            case 402:
              return Failure(
                  error: error.response?.data["msg"] ?? 'Something went wrong');
            case 404:
              return Failure(
                  error: error.response?.data["msg"] ?? 'Resource not found');
            case 409:
              return Failure(
                  error: error.response?.data["msg"] ?? 'Validation error');
            case 422:
              return Failure(
                  error: error.response?.data["msg"] ?? 'Validation error');
            case 500:
              return Failure(
                error: 'An error occured! Our team is resolving this!',
              );
            case 502:
              return Failure(
                error: error.response?.data["msg"] ??
                    'An error occured! Our team is resolving this!',
              );

            case 412:
              return Failure(
                error: error.response!.data["msg"],
                precondition: error.response!.data["precondition"],
                description: error.response!.data["description"],
                value: error.response!.data["value"],
              );

            default:
              return Failure(error: 'Error: $statusCode');
          }
        default:
          return Failure(error: 'Network error');
      }
    }
  }
}
