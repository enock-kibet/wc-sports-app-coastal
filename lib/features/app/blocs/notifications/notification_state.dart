part of 'notification_bloc.dart';

enum NotificationStatus {
  initial,
  loading,
  success,
  failure,
  ;


  bool get isInitial => this == NotificationStatus.initial;
  bool get isLoading => this == NotificationStatus.loading;
  bool get isSuccess => this == NotificationStatus.success;
  bool get isFailure => this == NotificationStatus.failure;
}

@freezed
class NotificationState with _$NotificationState {
  const factory NotificationState({
    @Default(NotificationStatus.initial) NotificationStatus status,
    Failure? failure,
    String? authorizationUrl,
    String? message,
    @Default([]) List<Notifications> notifications,
  }) = _NotificationState;
}
