// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'points.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$PointsDataImpl _$$PointsDataImplFromJson(Map<String, dynamic> json) =>
    _$PointsDataImpl(
      pointid: json['pointid'] as String,
      txType: json['txType'] as String,
      actualpoint: const StringOrIntConverter().fromJson(json['actualpoint']),
      action: json['action'] as String,
      externalRef: json['externalRef'] as String,
      pointtimestamp: json['pointtimestamp'] as String,
    );

Map<String, dynamic> _$$PointsDataImplToJson(_$PointsDataImpl instance) =>
    <String, dynamic>{
      'pointid': instance.pointid,
      'txType': instance.txType,
      'actualpoint': const StringOrIntConverter().toJson(instance.actualpoint),
      'action': instance.action,
      'externalRef': instance.externalRef,
      'pointtimestamp': instance.pointtimestamp,
    };

_$PointsBalanceImpl _$$PointsBalanceImplFromJson(Map<String, dynamic> json) =>
    _$PointsBalanceImpl(
      walletId: json['walletId'] as String,
      balance: const StringOrIntConverter().fromJson(json['balance']),
      tier: json['tier'] as String,
    );

Map<String, dynamic> _$$PointsBalanceImplToJson(_$PointsBalanceImpl instance) =>
    <String, dynamic>{
      'walletId': instance.walletId,
      'balance': const StringOrIntConverter().toJson(instance.balance),
      'tier': instance.tier,
    };
