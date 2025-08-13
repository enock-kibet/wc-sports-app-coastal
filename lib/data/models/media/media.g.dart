// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'media.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$MediaDataImpl _$$MediaDataImplFromJson(Map<String, dynamic> json) =>
    _$MediaDataImpl(
      recentHighlights: (json['recentHighlights'] as List<dynamic>)
          .map((e) => Highlight.fromJson(e as Map<String, dynamic>))
          .toList(),
      seasonHighlights: (json['seasonHighlights'] as List<dynamic>)
          .map((e) => SeasonHighlight.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$MediaDataImplToJson(_$MediaDataImpl instance) =>
    <String, dynamic>{
      'recentHighlights': instance.recentHighlights,
      'seasonHighlights': instance.seasonHighlights,
    };

_$HighlightImpl _$$HighlightImplFromJson(Map<String, dynamic> json) =>
    _$HighlightImpl(
      title: json['title'] as String,
      image: json['image'] as String,
    );

Map<String, dynamic> _$$HighlightImplToJson(_$HighlightImpl instance) =>
    <String, dynamic>{
      'title': instance.title,
      'image': instance.image,
    };

_$SeasonHighlightImpl _$$SeasonHighlightImplFromJson(
        Map<String, dynamic> json) =>
    _$SeasonHighlightImpl(
      title: json['title'] as String,
      image: json['image'] as String,
      time: json['time'] as String,
      date: json['date'] as String,
    );

Map<String, dynamic> _$$SeasonHighlightImplToJson(
        _$SeasonHighlightImpl instance) =>
    <String, dynamic>{
      'title': instance.title,
      'image': instance.image,
      'time': instance.time,
      'date': instance.date,
    };
