// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'match-recarp.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$MatchModelImpl _$$MatchModelImplFromJson(Map<String, dynamic> json) =>
    _$MatchModelImpl(
      id: json['id'] as String,
      name: json['name'] as String,
      clubOne: ClubModel.fromJson(json['clubOne'] as Map<String, dynamic>),
      clubTwo: ClubModel.fromJson(json['clubTwo'] as Map<String, dynamic>),
      matchDate:
          MatchDateModel.fromJson(json['matchDate'] as Map<String, dynamic>),
      venue: VenueModel.fromJson(json['venue'] as Map<String, dynamic>),
      description: json['description'] as String,
      matchWinner: json['matchWinner'] as String,
      clubOneScore: json['clubOneScore'] as String,
      clubTwoScore: json['clubTwoScore'] as String,
      matchStatus: json['matchStatus'] as bool,
      intervalScores: (json['intervalScores'] as List<dynamic>?)
              ?.map(
                  (e) => IntervalScoreModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      playerStatistics: (json['playerStatistics'] as List<dynamic>?)
              ?.map((e) =>
                  PlayerBoxScoreModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$$MatchModelImplToJson(_$MatchModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'clubOne': instance.clubOne,
      'clubTwo': instance.clubTwo,
      'matchDate': instance.matchDate,
      'venue': instance.venue,
      'description': instance.description,
      'matchWinner': instance.matchWinner,
      'clubOneScore': instance.clubOneScore,
      'clubTwoScore': instance.clubTwoScore,
      'matchStatus': instance.matchStatus,
      'intervalScores': instance.intervalScores,
      'playerStatistics': instance.playerStatistics,
    };

_$ClubModelImpl _$$ClubModelImplFromJson(Map<String, dynamic> json) =>
    _$ClubModelImpl(
      id: json['id'] as String,
      name: json['name'] as String,
      pic: json['pic'] as String?,
      stats: (json['stats'] as List<dynamic>?)
              ?.map((e) => StatModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$$ClubModelImplToJson(_$ClubModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'pic': instance.pic,
      'stats': instance.stats,
    };

_$StatModelImpl _$$StatModelImplFromJson(Map<String, dynamic> json) =>
    _$StatModelImpl(
      stat: json['stat'] as String,
      statValue: (json['statValue'] as num).toInt(),
    );

Map<String, dynamic> _$$StatModelImplToJson(_$StatModelImpl instance) =>
    <String, dynamic>{
      'stat': instance.stat,
      'statValue': instance.statValue,
    };

_$MatchDateModelImpl _$$MatchDateModelImplFromJson(Map<String, dynamic> json) =>
    _$MatchDateModelImpl(
      id: json['id'] as String,
      date: DateTime.parse(json['date'] as String),
    );

Map<String, dynamic> _$$MatchDateModelImplToJson(
        _$MatchDateModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'date': instance.date.toIso8601String(),
    };

_$VenueModelImpl _$$VenueModelImplFromJson(Map<String, dynamic> json) =>
    _$VenueModelImpl(
      id: json['id'] as String,
      name: json['name'] as String,
      location: json['location'] as String,
      latitude: (json['latitude'] as num).toDouble(),
      longitude: (json['longitude'] as num).toDouble(),
    );

Map<String, dynamic> _$$VenueModelImplToJson(_$VenueModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'location': instance.location,
      'latitude': instance.latitude,
      'longitude': instance.longitude,
    };

_$IntervalScoreModelImpl _$$IntervalScoreModelImplFromJson(
        Map<String, dynamic> json) =>
    _$IntervalScoreModelImpl(
      sequencePosition: (json['sequencePosition'] as num).toInt(),
      interval: json['interval'] as String,
      clubOne: json['clubOne'] as String,
      homeTeamScore: json['homeTeamScore'] as String,
      clubTwo: json['clubTwo'] as String,
      awayTeamScore: json['awayTeamScore'] as String,
    );

Map<String, dynamic> _$$IntervalScoreModelImplToJson(
        _$IntervalScoreModelImpl instance) =>
    <String, dynamic>{
      'sequencePosition': instance.sequencePosition,
      'interval': instance.interval,
      'clubOne': instance.clubOne,
      'homeTeamScore': instance.homeTeamScore,
      'clubTwo': instance.clubTwo,
      'awayTeamScore': instance.awayTeamScore,
    };

_$PlayerBoxScoreModelImpl _$$PlayerBoxScoreModelImplFromJson(
        Map<String, dynamic> json) =>
    _$PlayerBoxScoreModelImpl(
      playerId: json['playerId'] as String,
      playerName: json['playerName'] as String,
      clubId: json['clubId'] as String,
      clubName: json['clubName'] as String,
      teamSide: json['teamSide'] as String,
      isStarter: json['isStarter'] as bool,
      points: (json['points'] as num?)?.toInt() ?? 0,
      assists: (json['assists'] as num?)?.toInt() ?? 0,
      offensiveRebounds: (json['offensiveRebounds'] as num?)?.toInt() ?? 0,
      defensiveRebounds: (json['defensiveRebounds'] as num?)?.toInt() ?? 0,
      totalRebounds: (json['totalRebounds'] as num?)?.toInt() ?? 0,
      steals: (json['steals'] as num?)?.toInt() ?? 0,
      blocks: (json['blocks'] as num?)?.toInt() ?? 0,
      turnovers: (json['turnovers'] as num?)?.toInt() ?? 0,
      personalFouls: (json['personalFouls'] as num?)?.toInt() ?? 0,
      technicalFouls: (json['technicalFouls'] as num?)?.toInt() ?? 0,
      fieldGoalsMade: (json['fieldGoalsMade'] as num?)?.toInt() ?? 0,
      fieldGoalsAttempted: (json['fieldGoalsAttempted'] as num?)?.toInt() ?? 0,
      freeThrowsMade: (json['freeThrowsMade'] as num?)?.toInt() ?? 0,
      freeThrowsAttempted: (json['freeThrowsAttempted'] as num?)?.toInt() ?? 0,
      threePointersMade: (json['threePointersMade'] as num?)?.toInt() ?? 0,
      threePointersAttempted:
          (json['threePointersAttempted'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$$PlayerBoxScoreModelImplToJson(
        _$PlayerBoxScoreModelImpl instance) =>
    <String, dynamic>{
      'playerId': instance.playerId,
      'playerName': instance.playerName,
      'clubId': instance.clubId,
      'clubName': instance.clubName,
      'teamSide': instance.teamSide,
      'isStarter': instance.isStarter,
      'points': instance.points,
      'assists': instance.assists,
      'offensiveRebounds': instance.offensiveRebounds,
      'defensiveRebounds': instance.defensiveRebounds,
      'totalRebounds': instance.totalRebounds,
      'steals': instance.steals,
      'blocks': instance.blocks,
      'turnovers': instance.turnovers,
      'personalFouls': instance.personalFouls,
      'technicalFouls': instance.technicalFouls,
      'fieldGoalsMade': instance.fieldGoalsMade,
      'fieldGoalsAttempted': instance.fieldGoalsAttempted,
      'freeThrowsMade': instance.freeThrowsMade,
      'freeThrowsAttempted': instance.freeThrowsAttempted,
      'threePointersMade': instance.threePointersMade,
      'threePointersAttempted': instance.threePointersAttempted,
    };
