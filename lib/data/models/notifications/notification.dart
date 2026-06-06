import 'package:freezed_annotation/freezed_annotation.dart';

part 'notification.freezed.dart';
part 'notification.g.dart';

@freezed
class Notifications with _$Notifications {
  const factory Notifications({
    @JsonKey(defaultValue: 0) required int id,
    @JsonKey(defaultValue: '') required String userId,
    String? cartId,
    @JsonKey(defaultValue: '') required String notificationType,
    @JsonKey(defaultValue: '') required String channel,
    String? campaignId,
    String? attributionWindow,
    @JsonKey(defaultValue: '') required String notificationKey,
    @JsonKey(defaultValue: '') required String createdUtc,
    @JsonKey(defaultValue: '') required String updatedUtc,
    @JsonKey(defaultValue: '') required String notificationText,
  }) = _Notifications;

  factory Notifications.fromJson(Map<String, dynamic> json) =>
      _$NotificationsFromJson(json);
}
