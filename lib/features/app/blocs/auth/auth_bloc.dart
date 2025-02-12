import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:sports_app/data/error/failure.dart';
import 'package:sports_app/data/models/user/user.dart';
import 'package:sports_app/data/services/service.dart';
import 'package:sports_app/localization/app_prefs_manager.dart';
import 'package:talker_flutter/talker_flutter.dart';
part 'auth_event.dart';
part 'auth_state.dart';
part 'auth_bloc.freezed.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  late AuthService _authService;
  late ProfileService _profileService;

  AuthBloc() : super(const AuthState()) {
    _authService = service<AuthService>();
    _profileService = service<ProfileService>();


    on<_Login>((event, emit) async {
      emit(state.copyWith(status: AuthStatus.loading));
      final authResponse = await _authService.login(event.request);
      authResponse.when(onError: (error) {
        emit(state.copyWith(
          status: AuthStatus.failure,
          failure: error,
        ));
      }, onSuccess: (loginRes) async {
        emit(state.copyWith(
          status: AuthStatus.success,
          failure: null,
          data:loginRes as User
        ));
        await service<AppPreferencesManager>().saveValue(loginRes);
        service<Talker>().info(loginRes);
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
      }, onSuccess: (registerRes) async{
        emit(state.copyWith(
          status: AuthStatus.success,
          failure: null,
          data:registerRes as User
        ));
        await service<AppPreferencesManager>().saveValue(registerRes);
        service<Talker>().info(registerRes);

      });
    });

    on<_VerifyOtp>((event,emit)async{
      emit((state.copyWith(status: AuthStatus.loading)));
      final authResponse = await _authService.verifyOtp(event.request);
      authResponse.when(onError: (error) {
        emit(state.copyWith(
          status: AuthStatus.failure,
          failure: error,
        ));
      }, onSuccess: (registerRes) async{
        emit(state.copyWith(
            status: AuthStatus.success,
            failure: null,
            data:registerRes as User
        ));
        await service<AppPreferencesManager>().saveValue(registerRes);

      });
    });

    on<_ResendOtp>((event,emit) async{
      emit(state.copyWith(status: AuthStatus.loading));
      final authResponse = await _authService.resendOtp(event.request);
      authResponse.when(
          onError: (Failure error) {
            emit(state.copyWith(
              status: AuthStatus.failure,
              failure: error
            ));
          },
          onSuccess: (String data) {
            emit(state.copyWith(
                status: AuthStatus.success,
                data: data));
          });
    });

    on<_GoogleLogin>((event,emit) async{
      emit(state.copyWith(status: AuthStatus.loading));
      final authResponse = await _authService.googleLogin(event.request);
      authResponse.when(
          onError: (Failure error) {
            emit(state.copyWith(
                status: AuthStatus.failure,
                failure: error
            ));
          },
          onSuccess: (dynamic data) async{
            emit(state.copyWith(
                status: AuthStatus.success,
                data: data as User));
            await service<AppPreferencesManager>().saveValue(data);
          }
      );
    });

    on<_EditProfile>((event,emit) async{
      emit(state.copyWith(status: AuthStatus.loading));
      final authResponse = await _profileService.updateProfilePicture(event.request);
      authResponse.when(
          onError: (Failure error) {
            emit(state.copyWith(
                status: AuthStatus.failure,
                failure: error
            ));
          },
          onSuccess: (dynamic data) async{
            emit(state.copyWith(
                status: AuthStatus.success,
                data: data as User));
            await service<AppPreferencesManager>().saveValue(data);

          }
      );
    });
}
}