part of 'match_bloc.dart';

@freezed
class MatchEvent with _$MatchEvent {
  const factory MatchEvent.matches() = _MatchesFetched;
  const factory MatchEvent.matchstats({String? clubId}) = _MatchStats;

  const factory MatchEvent.searchMatch({required String search}) =
      _MatchesSearched;
  const factory MatchEvent.datedMatch({required DateTime date}) = _MatchesDated;
  const factory MatchEvent.monthMatches({required DateTime month}) =
      _MatchesMonth;
}
