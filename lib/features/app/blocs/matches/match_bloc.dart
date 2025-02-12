import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:sports_app/data/error/failure.dart';
import 'package:sports_app/data/models/match/match.dart';

import 'package:sports_app/data/services/service.dart';

part 'match_event.dart';
part 'match_state.dart';
part 'match_bloc.freezed.dart';

class MatchBloc extends Bloc<MatchEvent, MatchState> {
  late MatchService _matchService;

  MatchBloc() : super(const MatchState()) {
    _matchService = service<MatchService>();

    on<_MatchesFetched>((event, emit) async {
      emit(state.copyWith(status: MatchStatus.loading));
      final recordResponse = await _matchService.getMatches();
      recordResponse.when(onError: (error) {
        emit(state.copyWith(
          status: MatchStatus.failure,
          failure: error,
        ));
      }, onSuccess: (data) async {
        List<MatchType> todaysMatches = data.where((match) {
          return onTheSameDay(requiredDate: null, dateToCompare: match.matchDate);
        }).toList();
        emit(state.copyWith(
          status: MatchStatus.success,
          matches: data,
          datedMatches: todaysMatches,
          failure: null,
        ));
      });
    });
    on<_MatchesDated>((event,emit)async{
      emit(state.copyWith(status: MatchStatus.loading));
      List<MatchType> datedMatches = state.matches.where((match) {
        return onTheSameDay(requiredDate: event.date, dateToCompare: match.matchDate);
      }).toList();
      emit(state.copyWith(
        status: MatchStatus.success,
        datedMatches: datedMatches,
        failure:null
      ));
    });
    on<_MatchesSearched>((event,emit)async{
      emit(state.copyWith(status: MatchStatus.loading));
      List<MatchType> searchlist = state.matches
          .where((match) => match.matchName.toLowerCase().contains(event.search.toLowerCase().trim()))
          .toList();
      emit(state.copyWith(
          status: MatchStatus.success,
          searchedMatches: searchlist,
          failure:null
      ));
    });

  }
}
