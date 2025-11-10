part of 'roaster_bloc.dart';

enum RoasterStatus {
  initial,
  loading,
  success,
  failure;

  bool get isInitial => this == RoasterStatus.initial;
  bool get isLoading => this == RoasterStatus.loading;
  bool get isSuccess => this == RoasterStatus.success;
  bool get isFailure => this == RoasterStatus.failure;
}

@freezed
class RoasterState with _$RoasterState {
  const factory RoasterState({
    @Default(RoasterStatus.initial) RoasterStatus status,
    Failure? failure,
    List<RoasterData>? roasters,
  }) = _RoasterState;
}
