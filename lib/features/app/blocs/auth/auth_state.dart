part of 'auth_bloc.dart';

enum AuthStatus {
  initial,
  loading,
  uploading,
  uploadSuccess,
  success,
  failure;

  bool get isInitial => this == AuthStatus.initial;
  bool get isLoading => this == AuthStatus.loading;
  bool get isSuccess => this == AuthStatus.success;
  bool get isFailure => this == AuthStatus.failure;
}

@freezed
class AuthState with _$AuthState {
  const factory AuthState({
    @Default(AuthStatus.initial) AuthStatus status,
    Failure? failure,
    dynamic data,
    dynamic pdata,
  }) = _AuthState;
}
