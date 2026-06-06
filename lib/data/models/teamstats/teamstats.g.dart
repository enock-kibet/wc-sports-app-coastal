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
      rank: (json['rank'] as num).toInt(),
      gamesPlayed: (json['gamesPlayed'] as num).toInt(),
      wins: (json['wins'] as num).toInt(),
      draws: (json['draws'] as num).toInt(),
      forfeits: (json['forfeits'] as num).toInt(),
      losses: (json['losses'] as num).toInt(),
      pointsScored: (json['pointsScored'] as num).toInt(),
      pointsAgainst: (json['pointsAgainst'] as num).toInt(),
      pointsDifference: (json['pointsDifference'] as num).toInt(),
      points: (json['points'] as num).toInt(),
      winPercentage: (json['winPercentage'] as num).toDouble(),
      season: json['season'] as String,
    );

Map<String, dynamic> _$$TeamStatsDataImplToJson(_$TeamStatsDataImpl instance) =>
    <String, dynamic>{
      'teamId': instance.teamId,
      'teamName': instance.teamName,
      'rank': instance.rank,
      'gamesPlayed': instance.gamesPlayed,
      'wins': instance.wins,
      'draws': instance.draws,
      'forfeits': instance.forfeits,
      'losses': instance.losses,
      'pointsScored': instance.pointsScored,
      'pointsAgainst': instance.pointsAgainst,
      'pointsDifference': instance.pointsDifference,
      'points': instance.points,
      'winPercentage': instance.winPercentage,
      'season': instance.season,
    };
