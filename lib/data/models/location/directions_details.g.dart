// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'directions_details.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$DirectionDetailsInfoImpl _$$DirectionDetailsInfoImplFromJson(
        Map<String, dynamic> json) =>
    _$DirectionDetailsInfoImpl(
      distanceValue: (json['distance_value'] as num?)?.toInt(),
      durationValue: (json['duration_value'] as num?)?.toInt(),
      ePoints: json['e_points'] as String?,
      distanceText: json['distance_text'] as String?,
      durationText: json['duration_text'] as String?,
    );

Map<String, dynamic> _$$DirectionDetailsInfoImplToJson(
        _$DirectionDetailsInfoImpl instance) =>
    <String, dynamic>{
      'distance_value': instance.distanceValue,
      'duration_value': instance.durationValue,
      'e_points': instance.ePoints,
      'distance_text': instance.distanceText,
      'duration_text': instance.durationText,
    };
