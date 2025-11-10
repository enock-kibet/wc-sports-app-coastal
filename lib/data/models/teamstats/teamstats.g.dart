// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'teamstats.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$TeamStatsResponseImpl _$$TeamStatsResponseImplFromJson(
        Map<String, dynamic> json) =>
    _$TeamStatsResponseImpl(
      data: (json['data'] as List<dynamic>)
          .map((e) => TeamStatsData.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$TeamStatsResponseImplToJson(
        _$TeamStatsResponseImpl instance) =>
    <String, dynamic>{
      'data': instance.data,
    };

_$TeamStatsDataImpl _$$TeamStatsDataImplFromJson(Map<String, dynamic> json) =>
    _$TeamStatsDataImpl(
      teamId: json['teamId'] as String,
      teamName: json['teamName'] as String,
      wins: (json['wins'] as num).toInt(),
      losses: (json['losses'] as num).toInt(),
      draws: (json['draws'] as num).toInt(),
      points: (json['points'] as num).toInt(),
      gamesPlayed: (json['gamesPlayed'] as num).toInt(),
      pointsScored: (json['pointsScored'] as num).toInt(),
      pointsAgainst: (json['pointsAgainst'] as num).toInt(),
      season: json['season'] as String,
    );

Map<String, dynamic> _$$TeamStatsDataImplToJson(_$TeamStatsDataImpl instance) =>
    <String, dynamic>{
      'teamId': instance.teamId,
      'teamName': instance.teamName,
      'wins': instance.wins,
      'losses': instance.losses,
      'draws': instance.draws,
      'points': instance.points,
      'gamesPlayed': instance.gamesPlayed,
      'pointsScored': instance.pointsScored,
      'pointsAgainst': instance.pointsAgainst,
      'season': instance.season,
    };
