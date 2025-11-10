part of 'media_bloc.dart';

enum MediaStatus {
  initial,
  loading,
  success,
  failure,
  ;

  bool get isInitial => this == MediaStatus.initial;
  bool get isLoading => this == MediaStatus.loading;
  bool get isSuccess => this == MediaStatus.success;
  bool get isFailure => this == MediaStatus.failure;
}

@freezed
class MediaState with _$MediaState {
  const factory MediaState({
    @Default(MediaStatus.initial) MediaStatus status,
    Failure? failure,
    String? authorizationUrl,
    String? message,
    @Default([]) List<MediaData> media,
    List<HighlightReel>? homeMedia,
  }) = _MediaState;
}
