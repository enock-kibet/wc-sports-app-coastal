// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'roaster.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$RoasterResponseImpl _$$RoasterResponseImplFromJson(
        Map<String, dynamic> json) =>
    _$RoasterResponseImpl(
      data: (json['data'] as List<dynamic>)
          .map((e) => RoasterData.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$RoasterResponseImplToJson(
        _$RoasterResponseImpl instance) =>
    <String, dynamic>{
      'data': instance.data,
    };

_$RoasterDataImpl _$$RoasterDataImplFromJson(Map<String, dynamic> json) =>
    _$RoasterDataImpl(
      playerId: json['playerId'] as String,
      playerName: json['playerName'] as String,
      position: json['position'] as String,
      imageUrl: json['imageUrl'] as String,
      playerHeight: json['playerHeight'] as String,
      playerWeight: json['playerWeight'] as String,
      playerNumber: json['playerNumber'] as String,
      stats: json['stats'] as Map<String, dynamic>,
    );

Map<String, dynamic> _$$RoasterDataImplToJson(_$RoasterDataImpl instance) =>
    <String, dynamic>{
      'playerId': instance.playerId,
      'playerName': instance.playerName,
      'position': instance.position,
      'imageUrl': instance.imageUrl,
      'playerHeight': instance.playerHeight,
      'playerWeight': instance.playerWeight,
      'playerNumber': instance.playerNumber,
      'stats': instance.stats,
    };
