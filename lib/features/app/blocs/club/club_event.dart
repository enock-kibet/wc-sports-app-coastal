part of 'club_bloc.dart';

@freezed
class ClubRoasterEvent with _$ClubRoasterEvent {
  const factory ClubRoasterEvent.roasters() = _ClubRoasterFetched;
}
