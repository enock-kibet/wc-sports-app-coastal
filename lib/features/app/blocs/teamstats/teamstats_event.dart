part of 'teamstats_bloc.dart';

@freezed
class TeamStatsEvent with _$TeamStatsEvent {
  const factory TeamStatsEvent.standings() = _TeamStatsFetched;
}
