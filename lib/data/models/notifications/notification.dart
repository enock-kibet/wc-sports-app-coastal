import 'package:freezed_annotation/freezed_annotation.dart';

part 'notification.freezed.dart';
part 'notification.g.dart';

@freezed
class Notifications with _$Notifications {
  const factory Notifications({
    required int id,
    required String userId,
    String? cartId,
    required String notificationType,
    required String channel,
    String? campaignId,
    String? attributionWindow,
    required String notificationKey,
    required String createdUtc,
    required String updatedUtc,
    String? notificationText,
  }) = _Notifications;

  factory Notifications.fromJson(Map<String, dynamic> json) =>
      _$NotificationsFromJson(json);
}
