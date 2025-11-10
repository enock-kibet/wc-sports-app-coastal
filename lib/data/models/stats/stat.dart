import 'package:freezed_annotation/freezed_annotation.dart';

part 'stat.freezed.dart';
part 'stat.g.dart';

@freezed
class Stats with _$Stats {
  const factory Stats({
    required int rank,
    required String playerId,
    required String playerName,
    required String clubId,
    required String clubname,
    required String seasonId,
    required int avg,
    required int games,
    String? imageUrl,
  }) = _Stats;

  factory Stats.fromJson(Map<String, Object?> json) => _$StatsFromJson(json);
}

/// Wrapper model for the full response
@freezed
class StatCategoryResponse with _$StatCategoryResponse {
  const factory StatCategoryResponse({
    @JsonKey(name: 'Field Goal') required List<Stats> fieldGoal,
    @JsonKey(name: 'Free Throw') required List<Stats> freeThrow,
    @JsonKey(name: 'Rebounds') required List<Stats> rebounds,
  }) = _StatCategoryResponse;

  factory StatCategoryResponse.fromJson(Map<String, Object?> json) =>
      _$StatCategoryResponseFromJson(json);
}

@freezed
class PlayerStatResponse with _$PlayerStatResponse {
  const factory PlayerStatResponse({
    required String matchId,
    required String scoreboard,
    required String matchTitle,
    required List<StatsByType> statsByType,
  }) = _PlayerStatResponse;

  factory PlayerStatResponse.fromJson(Map<String, dynamic> json) =>
      _$PlayerStatResponseFromJson(json);
}

@freezed
class StatsByType with _$StatsByType {
  const factory StatsByType({
    required StatType statType,
    required int count,
  }) = _StatsByType;

  factory StatsByType.fromJson(Map<String, dynamic> json) =>
      _$StatsByTypeFromJson(json);
}

@freezed
class StatType with _$StatType {
  const factory StatType({
    required String stattype,
  }) = _StatType;

  factory StatType.fromJson(Map<String, dynamic> json) =>
      _$StatTypeFromJson(json);
}

@freezed
class HighlightReelsResponse with _$HighlightReelsResponse {
  const factory HighlightReelsResponse({
    required int page,
    required int pageSize,
    required int total,
    required int totalPages,
    required List<HighlightReel> highlightReels,
  }) = _HighlightReelsResponse;

  factory HighlightReelsResponse.fromJson(Map<String, dynamic> json) =>
      _$HighlightReelsResponseFromJson(json);
}

@freezed
class HighlightReel with _$HighlightReel {
  const factory HighlightReel({
    required String title,
    required String type,
    required String url,
    required String image,
  }) = _HighlightReel;

  factory HighlightReel.fromJson(Map<String, dynamic> json) =>
      _$HighlightReelFromJson(json);
}
