part of 'match_bloc.dart';

enum MatchStatus {
  initial,
  loading,
  success,
  failure;

  bool get isInitial => this == MatchStatus.initial;
  bool get isLoading => this == MatchStatus.loading;
  bool get isSuccess => this == MatchStatus.success;
  bool get isFailure => this == MatchStatus.failure;
}

@freezed
class MatchState with _$MatchState {
  const factory MatchState(
      {@Default(MatchStatus.initial) MatchStatus status,
      Failure? failure,
      @Default([]) List<MatchType> matches,
      @Default([]) List<MatchType> datedMatches,
      @Default([]) List<MatchType> monthMatches,
      @Default([]) List<MatchType> statsMatches,
      @Default([]) List<MatchType> searchedMatches}) = _MatchState;
}
