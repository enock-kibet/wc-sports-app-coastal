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
