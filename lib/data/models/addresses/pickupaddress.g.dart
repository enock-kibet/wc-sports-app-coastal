// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pickupaddress.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$PickupAddressImpl _$$PickupAddressImplFromJson(Map<String, dynamic> json) =>
    _$PickupAddressImpl(
      id: json['id'] as String,
      name: json['name'] as String,
      locality: json['locality'] as String,
      city: json['city'] as String,
      country: json['country'] as String,
      phone: json['phone'] as String,
      latitude: (json['latitude'] as num?)?.toDouble(),
      longitude: (json['longitude'] as num?)?.toDouble(),
      isDefault: json['isDefault'] as bool?,
    );

Map<String, dynamic> _$$PickupAddressImplToJson(_$PickupAddressImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'locality': instance.locality,
      'city': instance.city,
      'country': instance.country,
      'phone': instance.phone,
      'latitude': instance.latitude,
      'longitude': instance.longitude,
      'isDefault': instance.isDefault,
    };
