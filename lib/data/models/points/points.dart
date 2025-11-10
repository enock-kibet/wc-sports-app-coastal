import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:sports_app/data/models/products/string_or_int_converter.dart';

part 'points.freezed.dart';
part 'points.g.dart';

@freezed
class PointsData with _$PointsData {
  const factory PointsData({
    required String pointid,
    required String txType,
    @StringOrIntConverter() required String actualpoint,
    required String action,
    required String externalRef,
    required String pointtimestamp,
  }) = _PointsData;

  factory PointsData.fromJson(Map<String, dynamic> json) =>
      _$PointsDataFromJson(json);
}

@freezed
class PointsBalance with _$PointsBalance {
  const factory PointsBalance({
    required String walletId,
    @StringOrIntConverter() required String balance,
    required String tier,
  }) = _PointsBalance;

  factory PointsBalance.fromJson(Map<String, dynamic> json) =>
      _$PointsBalanceFromJson(json);
}
