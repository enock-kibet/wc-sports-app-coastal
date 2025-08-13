import 'package:freezed_annotation/freezed_annotation.dart';

part 'notification.freezed.dart';
part 'notification.g.dart';

@freezed
class Notifications with _$Notifications {
  const factory Notifications(
      {required String id,
        required String message,
        required String time,
      }) = _Notifications;

  factory Notifications.fromJson(Map<String, dynamic> json) => _$NotificationsFromJson(json);
}