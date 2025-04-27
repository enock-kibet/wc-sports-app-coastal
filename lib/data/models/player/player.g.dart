// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'player.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$PlayerProfileDataImpl _$$PlayerProfileDataImplFromJson(
        Map<String, dynamic> json) =>
    _$PlayerProfileDataImpl(
      name: json['name'] as String,
      age: json['age'] as String,
      position: json['position'] as String,
      imageUrl: json['imageUrl'] as String,
      height: json['height'] as String,
      weight: json['weight'] as String,
      experience: json['experience'] as String,
      jerseyNumber: json['jerseyNumber'] as String,
      homeTown: json['homeTown'] as String,
    );

Map<String, dynamic> _$$PlayerProfileDataImplToJson(
        _$PlayerProfileDataImpl instance) =>
    <String, dynamic>{
      'name': instance.name,
      'age': instance.age,
      'position': instance.position,
      'imageUrl': instance.imageUrl,
      'height': instance.height,
      'weight': instance.weight,
      'experience': instance.experience,
      'jerseyNumber': instance.jerseyNumber,
      'homeTown': instance.homeTown,
    };
