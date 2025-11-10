// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'point_history_card_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$PointHistoryCardDataImpl _$$PointHistoryCardDataImplFromJson(
        Map<String, dynamic> json) =>
    _$PointHistoryCardDataImpl(
      date: DateTime.parse(json['date'] as String),
      tickets: (json['tickets'] as num?)?.toInt() ?? 1,
      amount: (json['amount'] as num?)?.toInt() ?? 700,
      points: (json['points'] as num?)?.toInt() ?? 2,
      prize: json['prize'] as String?,
    );

Map<String, dynamic> _$$PointHistoryCardDataImplToJson(
        _$PointHistoryCardDataImpl instance) =>
    <String, dynamic>{
      'date': instance.date.toIso8601String(),
      'tickets': instance.tickets,
      'amount': instance.amount,
      'points': instance.points,
      'prize': instance.prize,
    };
