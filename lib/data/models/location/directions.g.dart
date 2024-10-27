// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'directions.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$DirectionsImpl _$$DirectionsImplFromJson(Map<String, dynamic> json) =>
    _$DirectionsImpl(
      locationName: json['locationName'] as String?,
      locationId: json['locationId'] as String?,
      locationLatitude: (json['locationLatitude'] as num?)?.toDouble(),
      locationLongitude: (json['locationLongitude'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$$DirectionsImplToJson(_$DirectionsImpl instance) =>
    <String, dynamic>{
      'locationName': instance.locationName,
      'locationId': instance.locationId,
      'locationLatitude': instance.locationLatitude,
      'locationLongitude': instance.locationLongitude,
    };
