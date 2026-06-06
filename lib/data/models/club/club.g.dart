// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'club.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ClubRoasterResponseImpl _$$ClubRoasterResponseImplFromJson(
        Map<String, dynamic> json) =>
    _$ClubRoasterResponseImpl(
      data: (json['data'] as List<dynamic>)
          .map((e) => ClubRoasterData.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$ClubRoasterResponseImplToJson(
        _$ClubRoasterResponseImpl instance) =>
    <String, dynamic>{
      'data': instance.data,
    };

_$ClubRoasterDataImpl _$$ClubRoasterDataImplFromJson(
        Map<String, dynamic> json) =>
    _$ClubRoasterDataImpl(
      id: json['id'] as String,
      name: json['name'] as String,
      leagueId: json['leagueId'] as String,
      imageUrl: json['imageUrl'] as String?,
    );

Map<String, dynamic> _$$ClubRoasterDataImplToJson(
        _$ClubRoasterDataImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'leagueId': instance.leagueId,
      'imageUrl': instance.imageUrl,
    };
