// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'match.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$MatchTypeImpl _$$MatchTypeImplFromJson(Map<String, dynamic> json) =>
    _$MatchTypeImpl(
      matchId: json['matchId'] as String,
      teamOne: json['teamOne'] as String,
      teamTwo: json['teamTwo'] as String,
      matchName: json['matchName'] as String,
      matchDescription: json['matchDescription'] as String,
      matchDate: DateTime.parse(json['matchDate'] as String),
      matchVenue: json['matchVenue'] as String,
      matchLocation: json['matchLocation'] as String,
      matchPrice: (json['matchPrice'] as num).toDouble(),
      teamOneScore: json['teamOneScore'] as String?,
      teamTwoScore: json['teamTwoScore'] as String?,
      recap: json['recap'] == null
          ? null
          : MatchModel.fromJson(json['recap'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$MatchTypeImplToJson(_$MatchTypeImpl instance) =>
    <String, dynamic>{
      'matchId': instance.matchId,
      'teamOne': instance.teamOne,
      'teamTwo': instance.teamTwo,
      'matchName': instance.matchName,
      'matchDescription': instance.matchDescription,
      'matchDate': instance.matchDate.toIso8601String(),
      'matchVenue': instance.matchVenue,
      'matchLocation': instance.matchLocation,
      'matchPrice': instance.matchPrice,
      'teamOneScore': instance.teamOneScore,
      'teamTwoScore': instance.teamTwoScore,
      'recap': instance.recap,
    };
