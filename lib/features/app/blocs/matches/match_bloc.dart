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
      recordResponse.when(
        onError: (error) {
          emit(state.copyWith(
            status: MatchStatus.failure,
            failure: error,
          ));
        },
        onSuccess: (data) async {
          final today = DateTime.now();

          // filter matches for current month
          List<MatchType> currentMonthMatches = data.where((match) {
            return match.matchDate.year == today.year &&
                match.matchDate.month == today.month;
          }).toList();

          // filter matches for today (in case you want to show by default)
          List<MatchType> todaysMatches = data.where((match) {
            return onTheSameDay(
                requiredDate: today, dateToCompare: match.matchDate);
          }).toList();

          emit(state.copyWith(
            status: MatchStatus.success,
            matches: data,
            monthMatches: currentMonthMatches,
            datedMatches: todaysMatches, // 👈 in case _selectedDay is today
            failure: null,
          ));
        },
      );
    });

    on<_MatchStats>((event, emit) async {
      emit(state.copyWith(status: MatchStatus.loading));
      final recordResponse = await _matchService.getMatchStats();
      recordResponse.when(
        onError: (error) {
          emit(state.copyWith(
            status: MatchStatus.failure,
            failure: error,
          ));
        },
        onSuccess: (data) async {
          final today = DateTime.now();

          // filter matches for current month
          List<MatchType> currentMonthMatches = data.where((match) {
            return match.matchDate.year == today.year &&
                match.matchDate.month == today.month;
          }).toList();

          // filter matches for today (in case you want to show by default)
          List<MatchType> todaysMatches = data.where((match) {
            return onTheSameDay(
                requiredDate: today, dateToCompare: match.matchDate);
          }).toList();

          emit(state.copyWith(
            status: MatchStatus.success,
            statsMatches: data,
            // monthMatches: currentMonthMatches,
            // datedMatches: todaysMatches, // 👈 in case _selectedDay is today
            failure: null,
          ));
        },
      );
    });

    on<_MatchesDated>((event, emit) async {
      emit(state.copyWith(status: MatchStatus.loading));
      List<MatchType> datedMatches = state.matches.where((match) {
        return onTheSameDay(
            requiredDate: event.date, dateToCompare: match.matchDate);
      }).toList();
      emit(state.copyWith(
          status: MatchStatus.success,
          datedMatches: datedMatches,
          failure: null));
    });
    on<_MatchesSearched>((event, emit) async {
      emit(state.copyWith(status: MatchStatus.loading));
      List<MatchType> searchlist = state.matches
          .where((match) => match.matchName
              .toLowerCase()
              .contains(event.search.toLowerCase().trim()))
          .toList();
      emit(state.copyWith(
          status: MatchStatus.success,
          searchedMatches: searchlist,
          failure: null));
    });

    on<_MatchesMonth>((event, emit) async {
      emit(state.copyWith(status: MatchStatus.loading));

      List<MatchType> monthlyMatches = state.matches.where((match) {
        return onTheSameMonth(event.month, match.matchDate);
      }).toList();

      emit(state.copyWith(
        status: MatchStatus.success,
        monthMatches: monthlyMatches,
        failure: null,
      ));
    });
  }

  bool onTheSameMonth(DateTime month, DateTime dateToCompare) {
    return month.year == dateToCompare.year &&
        month.month == dateToCompare.month;
  }
}
