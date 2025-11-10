part of 'stat_bloc.dart';

enum StatStatus {
  initial,
  loading,
  success,
  failure;

  bool get isInitial => this == StatStatus.initial;
  bool get isLoading => this == StatStatus.loading;
  bool get isSuccess => this == StatStatus.success;
  bool get isFailure => this == StatStatus.failure;
}

@freezed
class StatState with _$StatState {
  const factory StatState({
    @Default(StatStatus.initial) StatStatus status,
    Failure? failure,
    Map<String, List<Stats>>? stats,
    List<PlayerStatResponse>? playerStats,
    List<HighlightReel>? playerMedia,
  }) = _StatState;
}
