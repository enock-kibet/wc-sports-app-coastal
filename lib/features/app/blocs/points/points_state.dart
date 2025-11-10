part of 'points_bloc.dart';

enum PointsStatus {
  initial,
  loading,
  success,
  failure,
  ;

  bool get isInitial => this == PointsStatus.initial;
  bool get isLoading => this == PointsStatus.loading;
  bool get isSuccess => this == PointsStatus.success;
  bool get isFailure => this == PointsStatus.failure;
}

@freezed
class PointsState with _$PointsState {
  const factory PointsState({
    @Default(PointsStatus.initial) PointsStatus status,
    Failure? failure,
    String? message,
    @Default('') String balance,
    @Default([]) List<PointsData> points,
  }) = _PointsState;
}
