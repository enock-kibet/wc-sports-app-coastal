part of 'points_bloc.dart';

@freezed
class PointsEvent with _$PointsEvent {
  const factory PointsEvent.points() = _PointsFetched;
  const factory PointsEvent.addPoints({required dynamic request}) = _AddPoints;
  const factory PointsEvent.transferPoints({required dynamic request}) =
      _TransferPoints;
}
