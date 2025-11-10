// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$NotificationsImpl _$$NotificationsImplFromJson(Map<String, dynamic> json) =>
    _$NotificationsImpl(
      id: (json['id'] as num).toInt(),
      userId: json['userId'] as String,
      cartId: json['cartId'] as String?,
      notificationType: json['notificationType'] as String,
      channel: json['channel'] as String,
      campaignId: json['campaignId'] as String?,
      attributionWindow: json['attributionWindow'] as String?,
      notificationKey: json['notificationKey'] as String,
      createdUtc: json['createdUtc'] as String,
      updatedUtc: json['updatedUtc'] as String,
      notificationText: json['notificationText'] as String?,
    );

Map<String, dynamic> _$$NotificationsImplToJson(_$NotificationsImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'cartId': instance.cartId,
      'notificationType': instance.notificationType,
      'channel': instance.channel,
      'campaignId': instance.campaignId,
      'attributionWindow': instance.attributionWindow,
      'notificationKey': instance.notificationKey,
      'createdUtc': instance.createdUtc,
      'updatedUtc': instance.updatedUtc,
      'notificationText': instance.notificationText,
    };
