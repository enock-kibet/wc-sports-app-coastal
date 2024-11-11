import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:sports_app/data/error/failure.dart';
import 'package:sports_app/data/repository/authentication.dart';
import 'package:sports_app/data/services/service.dart';
import 'package:sports_app/localization/app_prefs.dart';
import 'package:talker_flutter/talker_flutter.dart';

part 'auth_event.dart';
part 'auth_state.dart';
part 'auth_bloc.freezed.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  late AuthService _authService;
  late AppPreferences appPreferences;
  late AuthenticationRepository authRepository;
  // late ProfileService _profileService;
  // final DownloadBloc downloadBloc;

  AuthBloc() : super(const AuthState()) {
    _authService = service<AuthService>();

    appPreferences = service<AppPreferences>();
    authRepository = AuthenticationRepository.instance;
    on<_Login>((event, emit) async {
      emit(state.copyWith(status: AuthStatus.loading));
      final authResponse =
          await _authService.login(event.request);
      authResponse.when(onError: (error) {
        emit(state.copyWith(
          status: AuthStatus.failure,
          failure: error,
        ));
      }, onSuccess: (loginRes) async {
        emit(state.copyWith(
          status: AuthStatus.success,
          failure: null,
        ));
        // await appPreferences.storeAuthData(loginRes);
        // await authRepository.login(loginRes);
      });
    });

    on<_Registered>((event, emit) async {
      emit(state.copyWith(status: AuthStatus.loading));
      final authResponse =
          await _authService.signup(event.request);
      authResponse.when(onError: (error) {
        emit(state.copyWith(
          status: AuthStatus.failure,
          failure: error,
        ));
      }, onSuccess: (registerRes) {
        emit(state.copyWith(
          status: AuthStatus.success,
          failure: null,
        ));
        service<Talker>().info(registerRes);
      });
    });
    // on<_SendOtp>((event, emit) async {
    //   emit(state.copyWith(status: AuthStatus.loading));
    //   final authResponse =
    //       await _authService.sendOtp(event.phone, (count, total) {});
    //   authResponse.when(onError: (error) {
    //     emit(state.copyWith(
    //       status: AuthStatus.failure,
    //       failure: error,
    //     ));
    //   }, onSuccess: (registerRes) {
    //     emit(state.copyWith(
    //       status: AuthStatus.success,
    //       failure: null,
    //     ));
    //     service<Talker>().info(registerRes);
    //   });
    // });
    // on<_VerifyAndResetPassword>((event, emit) async {
    //   emit(state.copyWith(status: AuthStatus.loading));
    //   final authResponse = await _authService.verifyAndResetPassword(
    //       event.data, (count, total) {});
    //   authResponse.when(onError: (error) {
    //     emit(state.copyWith(
    //       status: AuthStatus.failure,
    //       failure: error,
    //     ));
    //   }, onSuccess: (registerRes) {
    //     emit(state.copyWith(
    //       status: AuthStatus.success,
    //       failure: null,
    //     ));
    //     service<Talker>().info(registerRes);
    //   });
    // });
    // on<_EditProfile>((event, emit) async {
    //   emit(state.copyWith(status: AuthStatus.loading));
    //   final profileResponse = await _profileService.editProfile(
    //       request: event.request, (count, total) {});
    //   profileResponse.when(onError: (error) {
    //     emit(state.copyWith(
    //       status: AuthStatus.failure,
    //       failure: error,
    //     ));
    //   }, onSuccess: (res) {
    //     emit(state.copyWith(
    //       status: AuthStatus.success,
    //       failure: null,
    //       data: res,
    //     ));
    //     service<Talker>().info(res);
    //   });
    // });
    // on<_MyProfile>((event, emit) async {
    //   emit(state.copyWith(status: AuthStatus.loading));
    //   final profileResponse =
    //       await _profileService.myProfile(id: event.id, (count, total) {});
    //   profileResponse.when(onError: (error) {
    //     emit(state.copyWith(
    //       status: AuthStatus.failure,
    //       failure: error,
    //     ));
    //   }, onSuccess: (res) {
    //     emit(state.copyWith(
    //       status: AuthStatus.success,
    //       failure: null,
    //       data: res,
    //     ));
    //     service<Talker>().info(res);
    //   });
    // });
  }
}
