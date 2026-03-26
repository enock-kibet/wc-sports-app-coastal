import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:sports_app/data/error/failure.dart';
import 'package:sports_app/data/models/roaster/roaster.dart';

import 'package:sports_app/data/services/service.dart';

part 'roaster_event.dart';
part 'roaster_state.dart';
part 'roaster_bloc.freezed.dart';

class RoasterBloc extends Bloc<RoasterEvent, RoasterState> {
  late RoasterService _roasterService;

  RoasterBloc() : super(const RoasterState()) {
    _roasterService = service<RoasterService>();

    on<_RoastersFetched>((event, emit) async {
      emit(state.copyWith(status: RoasterStatus.loading));
      final recordResponse = await _roasterService.getRoasters(event.clubid);
      recordResponse.when(
        onError: (error) {
          emit(state.copyWith(
            status: RoasterStatus.failure,
            failure: error,
          ));
        },
        onSuccess: (data) async {
          emit(state.copyWith(
            status: RoasterStatus.success,
            roasters: data,
            failure: null,
          ));
        },
      );
    });

    on<_TeamsRoastersFetched>((event, emit) async {
      emit(state.copyWith(status: RoasterStatus.loading));
      final recordResponse = await _roasterService.getTeamRoasters();
      recordResponse.when(
        onError: (error) {
          emit(state.copyWith(
            status: RoasterStatus.failure,
            failure: error,
          ));
        },
        onSuccess: (data) async {
          emit(state.copyWith(
            status: RoasterStatus.success,
            roasters: data,
            failure: null,
          ));
        },
      );
    });
  }
}
