import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:sports_app/data/error/failure.dart';
import 'package:sports_app/data/models/media/media.dart';

import 'package:sports_app/data/services/service.dart';

import '../../../../localization/app_prefs_manager.dart';

part 'media_event.dart';
part 'media_state.dart';
part 'media_bloc.freezed.dart';

class MediaBloc extends Bloc<MediaEvent, MediaState> {
  late MediaService _mediaService;

  final token = service<AppPreferencesManager>().currentUserValue!.token;

  MediaBloc() : super(const MediaState()) {
    _mediaService = service<MediaService>();

    on<_MediaFetched>((event, emit) async {
      emit(state.copyWith(status: MediaStatus.loading));
      final recordResponse = await _mediaService.getMedia();
      recordResponse.when(onError: (error) {
        emit(state.copyWith(
          status: MediaStatus.failure,
          failure: error,
        ));
      }, onSuccess: (data) async {
        emit(state.copyWith(
          status: MediaStatus.success,
          media: data,
          failure: null,
        ));
      });
    });
  }
}
