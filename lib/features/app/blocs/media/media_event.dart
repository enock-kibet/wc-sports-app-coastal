part of 'media_bloc.dart';

@freezed
class MediaEvent with _$MediaEvent {
  const factory MediaEvent.media() = _MediaFetched;
  const factory MediaEvent.getHomeMedia() = _HomeMediaFetched;
}
