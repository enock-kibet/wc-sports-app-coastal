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
          emit(state.copyWith(status: MatchStatus.failure, failure: error));
        },
        onSuccess: (data) async {
          final today = DateTime.now();
          final month = DateTime(today.year, today.month);

          // upcoming matches in current month
          final currentMonthMatches = data
              .where((m) =>
                  onTheSameMonth(month, m.matchDate.toLocal()) &&
                  _isUpcoming(m.matchDate))
              .toList()
            ..sort((a, b) => a.matchDate.compareTo(b.matchDate));

          // upcoming matches today (optional)
          final todaysMatches = data
              .where((m) =>
                  onTheSameDay(
                      requiredDate: today, dateToCompare: m.matchDate) &&
                  _isUpcoming(m.matchDate))
              .toList()
            ..sort((a, b) => a.matchDate.compareTo(b.matchDate));

          emit(state.copyWith(
            status: MatchStatus.success,
            matches: data,
            monthMatches: currentMonthMatches,
            datedMatches: todaysMatches,
            failure: null,
          ));
        },
      );
    });
    on<_MatchStats>((event, emit) async {
      emit(state.copyWith(status: MatchStatus.loading));
      final recordResponse = await _matchService.getMatchStats(event.clubId);
      recordResponse.when(
        onError: (error) {
          emit(state.copyWith(
            status: MatchStatus.failure,
            failure: error,
          ));
        },
        onSuccess: (data) async {
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

      final datedMatches = state.matches
          .where((m) => onTheSameDay(
                requiredDate: event.date,
                dateToCompare: m.matchDate,
              ))
          .toList()
        ..sort((a, b) => a.matchDate.compareTo(b.matchDate));

      emit(state.copyWith(
        status: MatchStatus.success,
        datedMatches: datedMatches,
        failure: null,
      ));
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

      final monthlyMatches = state.matches
          .where((m) => onTheSameMonth(event.month, m.matchDate.toLocal()))
          .toList()
        ..sort((a, b) => a.matchDate.compareTo(b.matchDate));

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

  DateTime _startOfToday() {
    final now = DateTime.now();
    return DateTime(now.year, now.month, now.day);
  }

  /// Upcoming = today or future
  bool _isUpcoming(DateTime date) {
    final d = date.toLocal();
    return !d.isBefore(_startOfToday());
  }
}
