import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:sports_app/data/error/failure.dart';

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
        emit(state.copyWith(
          status: MatchStatus.success,
          matches: data,
          failure: null,
        ));
      });
    });
  }
}
