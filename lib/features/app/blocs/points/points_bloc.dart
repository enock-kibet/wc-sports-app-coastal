import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:sports_app/data/error/failure.dart';
import 'package:sports_app/data/models/points/points.dart';
import 'package:sports_app/data/services/service.dart';
import 'package:talker_flutter/talker_flutter.dart';

import '../../../../localization/app_prefs_manager.dart';

part 'points_event.dart';
part 'points_state.dart';
part 'points_bloc.freezed.dart';

class PointsBloc extends Bloc<PointsEvent, PointsState> {
  late PointsService _pointsService;

  PointsBloc() : super(const PointsState()) {
    _pointsService = service<PointsService>();

    on<_PointsFetched>((event, emit) async {
      emit(state.copyWith(status: PointsStatus.loading));

      final currentUser = service<AppPreferencesManager>().currentUserValue;
      if (currentUser == null) {
        emit(state.copyWith(
          status: PointsStatus.failure,
          failure: Failure(error: "Please sign in to view points."),
        ));
        return;
      }

      final results = await Future.wait([
        _pointsService.getPoints(),
        _pointsService.getPointsBalance(),
      ]);

      final recordResponse = results[0];
      final balanceResponse = results[1];

      String? failure;
      dynamic points;
      dynamic balance;

      recordResponse.when(
        onError: (error) => failure = "Something went wrong",
        onSuccess: (data) => points = data,
      );

      balanceResponse.when(
        onError: (error) => failure = "Something went wrong",
        onSuccess: (data) => balance = data,
      );

      if (failure != null) {
        emit(state.copyWith(status: PointsStatus.failure));
      } else {
        emit(state.copyWith(
          status: PointsStatus.success,
          points: points,
          balance: balance.toString(),
          failure: null,
        ));
      }
    });

    on<_AddPoints>((event, emit) async {
      emit(state.copyWith(status: PointsStatus.loading));
      final currentUser = service<AppPreferencesManager>().currentUserValue;
      if (currentUser == null) {
        emit(state.copyWith(
          status: PointsStatus.failure,
          failure: Failure(error: "Please sign in to continue."),
        ));
        return;
      }
      final recordResponse = await _pointsService.addPoints(
        Map<String, dynamic>.from(event.request as Map),
      );
      recordResponse.when(onError: (error) {
        emit(state.copyWith(
          status: PointsStatus.failure,
          failure: error,
        ));
      }, onSuccess: (data) async {
        emit(state.copyWith(
          status: PointsStatus.success,
          message: data,
          failure: null,
        ));
      });
    });

    on<_TransferPoints>((event, emit) async {
      emit(state.copyWith(status: PointsStatus.loading));
      final currentUser = service<AppPreferencesManager>().currentUserValue;
      if (currentUser == null) {
        emit(state.copyWith(
          status: PointsStatus.failure,
          failure: Failure(error: "Please sign in to continue."),
        ));
        return;
      }

      try {
        final recordResponse = await _pointsService.transferPoints(
          Map<String, dynamic>.from(event.request as Map),
        );

        recordResponse.when(
          onError: (error) {
            emit(state.copyWith(
              status: PointsStatus.failure,
              failure: error,
            ));
          },
          onSuccess: (data) async {
            emit(state.copyWith(
              status: PointsStatus.success,
              message: data,
              failure: null,
            ));
          },
        );
      } catch (e, st) {
        service<Talker>().error('TransferPoints error: $e', st);
        emit(state.copyWith(
          status: PointsStatus.failure,
          failure: Failure(error: 'Something went wrong, please try again'),
        ));
      }
    });
  }
}
