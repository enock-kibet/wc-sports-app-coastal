import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:sports_app/data/error/failure.dart';
import 'package:sports_app/data/models/teamstats/teamstats.dart';

import 'package:sports_app/data/services/service.dart';

part 'teamstats_event.dart';
part 'teamstats_state.dart';
part 'teamstats_bloc.freezed.dart';

class TeamStatsBloc extends Bloc<TeamStatsEvent, TeamStatsState> {
  late TeamStatsService _teamstatsService;

  TeamStatsBloc() : super(const TeamStatsState()) {
    _teamstatsService = service<TeamStatsService>();

    on<_TeamStatsFetched>((event, emit) async {
      emit(state.copyWith(status: TeamStatsStatus.loading));
      final recordResponse = await _teamstatsService.getTeamStats();
      recordResponse.when(
        onError: (error) {
          emit(state.copyWith(
            status: TeamStatsStatus.failure,
            failure: error,
          ));
        },
        onSuccess: (data) async {
          emit(state.copyWith(
            status: TeamStatsStatus.success,
            teamstats: data,
            failure: null,
          ));
        },
      );
    });
  }
}
