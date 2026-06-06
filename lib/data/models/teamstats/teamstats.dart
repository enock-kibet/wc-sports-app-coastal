import 'package:freezed_annotation/freezed_annotation.dart';

part 'teamstats.freezed.dart';
part 'teamstats.g.dart';

@freezed
class TeamStatsResponse with _$TeamStatsResponse {
  const factory TeamStatsResponse({
    required List<TeamStatsData> data,
  }) = _TeamStatsResponse;

  factory TeamStatsResponse.fromJson(Map<String, dynamic> json) =>
      _$TeamStatsResponseFromJson(json);
}

@freezed
class TeamStatsData with _$TeamStatsData {
  const factory TeamStatsData({
    required String teamId,
    required String teamName,
    required int rank,
    required int gamesPlayed,
    required int wins,
    required int draws,
    required int forfeits,
    required int losses,
    required int pointsScored,
    required int pointsAgainst,
    required int pointsDifference,
    required int points,
    required double winPercentage,
    required String season,
  }) = _TeamStatsData;

  factory TeamStatsData.fromJson(Map<String, dynamic> json) =>
      _$TeamStatsDataFromJson(json);
}
