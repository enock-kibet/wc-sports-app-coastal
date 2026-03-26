import 'package:freezed_annotation/freezed_annotation.dart';

part 'match-recarp.freezed.dart';
part 'match-recarp.g.dart';

@freezed
class MatchModel with _$MatchModel {
  const factory MatchModel({
    required String id,
    required String name,
    required ClubModel clubOne,
    required ClubModel clubTwo,
    required MatchDateModel matchDate,
    required VenueModel venue,
    required String description,
    required String matchWinner,
    required String clubOneScore,
    required String clubTwoScore,
    required bool matchStatus,
    @Default([]) List<IntervalScoreModel> intervalScores,
  }) = _MatchModel;

  factory MatchModel.fromJson(Map<String, dynamic> json) =>
      _$MatchModelFromJson(json);
}

@freezed
class ClubModel with _$ClubModel {
  const factory ClubModel({
    required String id,
    required String name,
    String? pic,
    @Default([]) List<StatModel> stats,
  }) = _ClubModel;

  factory ClubModel.fromJson(Map<String, dynamic> json) =>
      _$ClubModelFromJson(json);
}

@freezed
class StatModel with _$StatModel {
  const factory StatModel({
    required String stat,
    required int statValue,
  }) = _StatModel;

  factory StatModel.fromJson(Map<String, dynamic> json) =>
      _$StatModelFromJson(json);
}

@freezed
class MatchDateModel with _$MatchDateModel {
  const factory MatchDateModel({
    required String id,
    required DateTime date,
  }) = _MatchDateModel;

  factory MatchDateModel.fromJson(Map<String, dynamic> json) =>
      _$MatchDateModelFromJson(json);
}

@freezed
class VenueModel with _$VenueModel {
  const factory VenueModel({
    required String id,
    required String name,
    required String location,
    required double latitude,
    required double longitude,
  }) = _VenueModel;

  factory VenueModel.fromJson(Map<String, dynamic> json) =>
      _$VenueModelFromJson(json);
}

@freezed
class IntervalScoreModel with _$IntervalScoreModel {
  const factory IntervalScoreModel({
    required int sequencePosition,
    required String interval,
    required String clubOne,
    required String homeTeamScore,
    required String clubTwo,
    required String awayTeamScore,
  }) = _IntervalScoreModel;

  factory IntervalScoreModel.fromJson(Map<String, dynamic> json) =>
      _$IntervalScoreModelFromJson(json);
}
