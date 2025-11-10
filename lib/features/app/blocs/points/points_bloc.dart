import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:sports_app/data/error/failure.dart';
import 'package:sports_app/data/models/points/points.dart';

import 'package:sports_app/data/services/service.dart';

import '../../../../localization/app_prefs_manager.dart';

part 'points_event.dart';
part 'points_state.dart';
part 'points_bloc.freezed.dart';

class PointsBloc extends Bloc<PointsEvent, PointsState> {
  late PointsService _pointsService;

  final token = service<AppPreferencesManager>().currentUserValue!.token;

  PointsBloc() : super(const PointsState()) {
    _pointsService = service<PointsService>();

    on<_PointsFetched>((event, emit) async {
      emit(state.copyWith(status: PointsStatus.loading));

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
      final recordResponse =
          await _pointsService.addPoints(event.request, token!);
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

      try {
        final recordResponse =
            await _pointsService.transferPoints(event.request, token!);

        recordResponse.when(
          onError: (error) {
            emit(state.copyWith(
              status: PointsStatus.failure,
              failure: Failure(
                error: 'Something went wrong, please try again',
              ),
            ));
          },
          onSuccess: (data) async {
            // Check that data is not null
            if (data == null) {
              emit(state.copyWith(
                status: PointsStatus.failure,
                failure:
                    Failure(error: 'Something went wrong, please try again'),
              ));
              return;
            }

            // Optional: If you expect a Map or List, validate it
            if (data is Map || data is List) {
              emit(state.copyWith(
                status: PointsStatus.success,
                failure: null,
              ));
            } else {
              emit(state.copyWith(
                status: PointsStatus.failure,
                failure:
                    Failure(error: 'Something went wrong, please try again'),
              ));
            }
          },
        );
      } catch (e, st) {
        // Catch unexpected exceptions
        emit(state.copyWith(
          status: PointsStatus.failure,
          failure: Failure(error: 'Something went wrong, please try again'),
        ));
        print('TransferPoints error: $e\n$st');
      }
    });
  }
}
