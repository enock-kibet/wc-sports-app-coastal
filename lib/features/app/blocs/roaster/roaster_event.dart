part of 'roaster_bloc.dart';

@freezed
class RoasterEvent with _$RoasterEvent {
  const factory RoasterEvent.roasters(String? clubid) = _RoastersFetched;
  const factory RoasterEvent.teamRoasters() = _TeamsRoastersFetched;
}
