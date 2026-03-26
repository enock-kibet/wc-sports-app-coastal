part of 'club_bloc.dart';

enum ClubRoastersStatus {
  initial,
  loading,
  success,
  failure;

  bool get isInitial => this == ClubRoastersStatus.initial;
  bool get isLoading => this == ClubRoastersStatus.loading;
  bool get isSuccess => this == ClubRoastersStatus.success;
  bool get isFailure => this == ClubRoastersStatus.failure;
}

@freezed
class ClubRoastersState with _$ClubRoastersState {
  const factory ClubRoastersState({
    @Default(ClubRoastersStatus.initial) ClubRoastersStatus status,
    Failure? failure,
    List<ClubRoasterData>? clubRoasters,
  }) = _ClubRoastersState;
}
