part of 'roaster_bloc.dart';

@freezed
class RoasterEvent with _$RoasterEvent {
  const factory RoasterEvent.roasters() = _RoastersFetched;
}
