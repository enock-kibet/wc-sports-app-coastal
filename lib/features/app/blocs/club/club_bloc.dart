import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:sports_app/data/error/failure.dart';
import 'package:sports_app/data/models/club/club.dart';
import 'package:sports_app/data/models/roaster/roaster.dart';

import 'package:sports_app/data/services/service.dart';

part 'club_event.dart';
part 'club_state.dart';
part 'club_bloc.freezed.dart';

class ClubRoastersBloc extends Bloc<ClubRoasterEvent, ClubRoastersState> {
  late RoasterService _roasterService;

  ClubRoastersBloc() : super(const ClubRoastersState()) {
    _roasterService = service<RoasterService>();

    on<_ClubRoasterFetched>((event, emit) async {
      emit(state.copyWith(status: ClubRoastersStatus.loading));
      final recordResponse = await _roasterService.getLeagueRoasters();
      recordResponse.when(
        onError: (error) {
          emit(state.copyWith(
            status: ClubRoastersStatus.failure,
            failure: error,
          ));
        },
        onSuccess: (data) async {
          emit(state.copyWith(
            status: ClubRoastersStatus.success,
            clubRoasters: data,
            failure: null,
          ));
        },
      );
    });
  }
}
