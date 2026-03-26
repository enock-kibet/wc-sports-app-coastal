import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:sports_app/data/error/failure.dart';
import 'package:sports_app/data/models/stats/stat.dart';

import 'package:sports_app/data/services/service.dart';

part 'stat_event.dart';
part 'stat_state.dart';
part 'stat_bloc.freezed.dart';

class StatBloc extends Bloc<StatEvent, StatState> {
  late StatService _statService;
  final String? clubId;

  StatBloc({this.clubId}) : super(const StatState()) {
    _statService = service<StatService>();

    on<_StatsFetched>((event, emit) async {
      emit(state.copyWith(status: StatStatus.loading));
      final recordResponse = await _statService.getStats(clubId);
      recordResponse.when(
        onError: (error) {
          emit(state.copyWith(
            status: StatStatus.failure,
            failure: error,
          ));
        },
        onSuccess: (data) async {
          emit(state.copyWith(
            status: StatStatus.success,
            stats: data,
            failure: null,
          ));
        },
      );
    });

    on<_PLayerStatsFetched>((playerID, emit) async {
      emit(state.copyWith(status: StatStatus.loading));
      final recordResponse =
          await _statService.getPlayerStats(playerID.playerId);
      recordResponse.when(
        onError: (error) {
          emit(state.copyWith(
            status: StatStatus.failure,
            failure: error,
          ));
        },
        onSuccess: (data) async {
          emit(state.copyWith(
            status: StatStatus.success,
            playerStats: data,
            failure: null,
          ));
        },
      );
    });

    on<_PLayerMediaFetched>((playerID, emit) async {
      emit(state.copyWith(status: StatStatus.loading));
      final recordResponse =
          await _statService.getPlayerMedia(playerID.playerId);
      recordResponse.when(
        onError: (error) {
          emit(state.copyWith(
            status: StatStatus.failure,
            failure: error,
          ));
        },
        onSuccess: (data) async {
          emit(state.copyWith(
            status: StatStatus.success,
            playerMedia: data,
            failure: null,
          ));
        },
      );
    });
  }
}
