import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:sports_app/data/error/failure.dart';
import 'package:sports_app/data/models/notifications/notification.dart';

import 'package:sports_app/data/services/service.dart';

import '../../../../localization/app_prefs_manager.dart';

part 'notification_event.dart';
part 'notification_state.dart';
part 'notification_bloc.freezed.dart';

class NotificationBloc extends Bloc<NotificationEvent, NotificationState> {
  late NotificationService _notificationService;

  final token = service<AppPreferencesManager>().currentUserValue!.token;

  NotificationBloc() : super(const NotificationState()) {
    _notificationService = service<NotificationService>();

    on<_NotificationsFetched>((event, emit) async {
      emit(state.copyWith(status: NotificationStatus.loading));
      final recordResponse = await _notificationService.getNotifications();
      recordResponse.when(onError: (error) {
        emit(state.copyWith(
          status: NotificationStatus.failure,
          failure: error,
        ));
      }, onSuccess: (data) async {
        emit(state.copyWith(
          status: NotificationStatus.success,
          notifications: data,
          failure: null,
        ));
      });
    });
  }
}
