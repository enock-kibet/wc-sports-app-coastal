import 'package:dio/dio.dart';

import 'failure.dart';

class ErrorHandler {
  final DioException error;

  ErrorHandler(this.error);

  static String humanizeMessage(dynamic rawMessage, {String? fallback}) {
    final fallbackMessage =
        fallback ?? 'Something went wrong. Please try again.';
    final message = rawMessage
            ?.toString()
            .trim()
            .replaceFirst(RegExp(r'^(FormatException|Exception):\s*'), '')
            .replaceFirst(RegExp(r'^Format(?=[A-Z])'), '') ??
        '';

    if (message.isEmpty) {
      return fallbackMessage;
    }

    final normalized = message.toLowerCase();

    if (normalized.contains('formatuser with email address') &&
        normalized.contains('not found')) {
      return 'We could not find an account for that email address.';
    }

    if (normalized.contains('otp') && normalized.contains('invalid')) {
      return 'The verification code you entered is invalid. Please try again.';
    }

    if (normalized.contains('otp') && normalized.contains('expired')) {
      return 'That verification code has expired. Please request a new one.';
    }

    if (normalized.contains('email already exists') ||
        normalized.contains('user already exists') ||
        normalized.contains('email is already taken')) {
      return 'An account with that email already exists. Please sign in instead.';
    }

    if (normalized.contains('invalid credentials') ||
        normalized.contains('invalid email or password') ||
        normalized.contains('incorrect password')) {
      return 'Incorrect email or password. Please try again.';
    }

    if (normalized.contains('new user created')) {
      return 'Your account has been created successfully.';
    }

    return message;
  }

  Failure handle() {
    if (error.response?.statusCode == 302) {
      return Failure(error: "Check your internet connection/bundle balance");
    } else {
      switch (error.type) {
        case DioExceptionType.connectionTimeout:
          return Failure(error: 'The connection timed out. Please try again.');
        case DioExceptionType.sendTimeout:
          return Failure(
              error: 'Sending the request took too long. Please try again.');
        case DioExceptionType.receiveTimeout:
          return Failure(
              error: 'The server took too long to respond. Please try again.');
        case DioExceptionType.cancel:
          return Failure(error: 'The request was canceled.');
        case DioExceptionType.badResponse:
          final statusCode = error.response!.statusCode;
          switch (statusCode) {
            case 400:
              return Failure(
                error: humanizeMessage(
                  _extractResponseMessage(error.response?.data),
                ),
              );
            case 401:
              return Failure(
                error: humanizeMessage(
                  _extractResponseMessage(error.response?.data),
                  fallback: 'Your session has expired. Please sign in again.',
                ),
              );
            case 403:
              return Failure(
                error: 'You do not have permission to perform this action.',
              );
            case 402:
              return Failure(
                error: humanizeMessage(_extractResponseMessage(error.response?.data)),
              );
            case 404:
              return Failure(
                error: humanizeMessage(
                  _extractResponseMessage(error.response?.data),
                  fallback: 'We could not find what you were looking for.',
                ),
              );
            case 409:
              return Failure(
                error: humanizeMessage(
                  _extractResponseMessage(error.response?.data),
                  fallback: 'This request could not be completed.',
                ),
              );
            case 422:
              return Failure(
                error: humanizeMessage(
                  _extractResponseMessage(error.response?.data),
                  fallback: 'Please check your details and try again.',
                ),
              );
            case 500:
              return Failure(
                error: humanizeMessage(
                  _extractResponseMessage(error.response?.data),
                  fallback:
                      'Something went wrong on our side. Please try again shortly.',
                ),
              );
            case 502:
              return Failure(
                error: humanizeMessage(
                  _extractResponseMessage(error.response?.data),
                  fallback:
                      'The service is temporarily unavailable. Please try again shortly.',
                ),
              );

            case 412:
              return Failure(
                error: humanizeMessage(_extractResponseMessage(error.response!.data)),
                precondition: error.response!.data["precondition"],
                description: error.response!.data["description"],
                value: error.response!.data["value"],
              );

            default:
              return Failure(
                error: 'Something went wrong. Please try again.',
              );
          }
        default:
          return Failure(
            error: 'Something went wrong. Please try again.',
          );
      }
    }
  }
}

dynamic _extractResponseMessage(dynamic responseData) {
  if (responseData is! Map) {
    return responseData;
  }

  final map = responseData;
  if (map['msg'] != null) return map['msg'];
  if (map['message'] != null) return map['message'];

  final messages = map['messages'];
  if (messages is List && messages.isNotEmpty) {
    return messages.first;
  }

  final errors = map['errors'];
  if (errors is Map) {
    for (final value in errors.values) {
      if (value is List && value.isNotEmpty) {
        return value.first;
      }
      if (value != null) {
        return value;
      }
    }
  }

  return null;
}
