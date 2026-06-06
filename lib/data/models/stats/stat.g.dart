// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'stat.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$StatsImpl _$$StatsImplFromJson(Map<String, dynamic> json) => _$StatsImpl(
      rank: (json['rank'] as num).toInt(),
      playerId: json['playerId'] as String,
      playerName: json['playerName'] as String,
      clubId: json['clubId'] as String,
      clubname: json['clubname'] as String,
      seasonId: json['seasonId'] as String,
      avg: (json['avg'] as num).toDouble(),
      games: (json['games'] as num).toInt(),
      imageUrl: json['imageUrl'] as String?,
    );

Map<String, dynamic> _$$StatsImplToJson(_$StatsImpl instance) =>
    <String, dynamic>{
      'rank': instance.rank,
      'playerId': instance.playerId,
      'playerName': instance.playerName,
      'clubId': instance.clubId,
      'clubname': instance.clubname,
      'seasonId': instance.seasonId,
      'avg': instance.avg,
      'games': instance.games,
      'imageUrl': instance.imageUrl,
    };

_$StatCategoryResponseImpl _$$StatCategoryResponseImplFromJson(
        Map<String, dynamic> json) =>
    _$StatCategoryResponseImpl(
      fieldGoal: (json['Field Goal'] as List<dynamic>)
          .map((e) => Stats.fromJson(e as Map<String, dynamic>))
          .toList(),
      freeThrow: (json['Free Throw'] as List<dynamic>)
          .map((e) => Stats.fromJson(e as Map<String, dynamic>))
          .toList(),
      rebounds: (json['Rebounds'] as List<dynamic>)
          .map((e) => Stats.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$StatCategoryResponseImplToJson(
        _$StatCategoryResponseImpl instance) =>
    <String, dynamic>{
      'Field Goal': instance.fieldGoal,
      'Free Throw': instance.freeThrow,
      'Rebounds': instance.rebounds,
    };

_$PlayerStatResponseImpl _$$PlayerStatResponseImplFromJson(
        Map<String, dynamic> json) =>
    _$PlayerStatResponseImpl(
      matchId: json['matchId'] as String,
      scoreboard: json['scoreboard'] as String,
      matchTitle: json['matchTitle'] as String,
      statsByType: (json['statsByType'] as List<dynamic>)
          .map((e) => StatsByType.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$PlayerStatResponseImplToJson(
        _$PlayerStatResponseImpl instance) =>
    <String, dynamic>{
      'matchId': instance.matchId,
      'scoreboard': instance.scoreboard,
      'matchTitle': instance.matchTitle,
      'statsByType': instance.statsByType,
    };

_$StatsByTypeImpl _$$StatsByTypeImplFromJson(Map<String, dynamic> json) =>
    _$StatsByTypeImpl(
      statType: StatType.fromJson(json['statType'] as Map<String, dynamic>),
      count: (json['count'] as num).toInt(),
    );

Map<String, dynamic> _$$StatsByTypeImplToJson(_$StatsByTypeImpl instance) =>
    <String, dynamic>{
      'statType': instance.statType,
      'count': instance.count,
    };

_$StatTypeImpl _$$StatTypeImplFromJson(Map<String, dynamic> json) =>
    _$StatTypeImpl(
      stattype: json['stattype'] as String,
    );

Map<String, dynamic> _$$StatTypeImplToJson(_$StatTypeImpl instance) =>
    <String, dynamic>{
      'stattype': instance.stattype,
    };

_$HighlightReelsResponseImpl _$$HighlightReelsResponseImplFromJson(
        Map<String, dynamic> json) =>
    _$HighlightReelsResponseImpl(
      page: (json['page'] as num).toInt(),
      pageSize: (json['pageSize'] as num).toInt(),
      total: (json['total'] as num).toInt(),
      totalPages: (json['totalPages'] as num).toInt(),
      highlightReels: (json['highlightReels'] as List<dynamic>)
          .map((e) => HighlightReel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$HighlightReelsResponseImplToJson(
        _$HighlightReelsResponseImpl instance) =>
    <String, dynamic>{
      'page': instance.page,
      'pageSize': instance.pageSize,
      'total': instance.total,
      'totalPages': instance.totalPages,
      'highlightReels': instance.highlightReels,
    };

_$HighlightReelImpl _$$HighlightReelImplFromJson(Map<String, dynamic> json) =>
    _$HighlightReelImpl(
      title: json['title'] as String,
      type: json['type'] as String,
      url: json['url'] as String,
      image: json['image'] as String,
    );

Map<String, dynamic> _$$HighlightReelImplToJson(_$HighlightReelImpl instance) =>
    <String, dynamic>{
      'title': instance.title,
      'type': instance.type,
      'url': instance.url,
      'image': instance.image,
    };

_$MatchStatLeaderImpl _$$MatchStatLeaderImplFromJson(
        Map<String, dynamic> json) =>
    _$MatchStatLeaderImpl(
      playerId: json['playerId'] as String,
      playerName: json['playerName'] as String,
      clubId: json['clubID'] as String,
      clubName: json['clubName'] as String,
      stat: (json['stat'] as num).toInt(),
      rank: (json['rank'] as num).toInt(),
    );

Map<String, dynamic> _$$MatchStatLeaderImplToJson(
        _$MatchStatLeaderImpl instance) =>
    <String, dynamic>{
      'playerId': instance.playerId,
      'playerName': instance.playerName,
      'clubID': instance.clubId,
      'clubName': instance.clubName,
      'stat': instance.stat,
      'rank': instance.rank,
    };
