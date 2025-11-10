part of 'teamstats_bloc.dart';

enum TeamStatsStatus {
  initial,
  loading,
  success,
  failure;

  bool get isInitial => this == TeamStatsStatus.initial;
  bool get isLoading => this == TeamStatsStatus.loading;
  bool get isSuccess => this == TeamStatsStatus.success;
  bool get isFailure => this == TeamStatsStatus.failure;
}

@freezed
class TeamStatsState with _$TeamStatsState {
  const factory TeamStatsState({
    @Default(TeamStatsStatus.initial) TeamStatsStatus status,
    Failure? failure,
    List<TeamStatsData>? teamstats,
  }) = _TeamStatsState;
}
