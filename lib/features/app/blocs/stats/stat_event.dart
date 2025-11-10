part of 'stat_bloc.dart';

@freezed
class StatEvent with _$StatEvent {
  const factory StatEvent.stats() = _StatsFetched;
  const factory StatEvent.getPlayerStats({required String playerId}) =
      _PLayerStatsFetched;

  const factory StatEvent.getPlayerMedia({required String playerId}) =
      _PLayerMediaFetched;
}
