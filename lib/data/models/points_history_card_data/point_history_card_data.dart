import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:sports_app/features/dashboard/pages/points/points_page.dart';

part 'point_history_card_data.freezed.dart';
part 'point_history_card_data.g.dart';

@freezed
class PointHistoryCardData with _$PointHistoryCardData {
  const factory PointHistoryCardData({
    required PointCardType type,
    required DateTime date,
    @Default(1) int tickets,
    @Default(700) int amount,
    @Default(2) int points,
    String? prize,
  }) = _PointHistoryCardData;

  factory PointHistoryCardData.fromJson(Map<String, Object?> json) =>
      _$PointHistoryCardDataFromJson(json);
}
