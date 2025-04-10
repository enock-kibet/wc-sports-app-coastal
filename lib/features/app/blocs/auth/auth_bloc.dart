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
      await authResponse.when(onError: (error) {
        emit(state.copyWith(
          status: AuthStatus.failure,
          failure: error,
        ));
      }, onSuccess: (loginRes) async {
        await service<AppPreferencesManager>().saveValue(loginRes);

        emit(state.copyWith(
          status: AuthStatus.success,
          failure: null,
          data:loginRes as User
        ));
        service<Talker>().info(loginRes);
      });
    });

    on<_Registered>((event, emit) async {
      emit(state.copyWith(status: AuthStatus.loading));
      final authResponse = await _authService.signup(event.request);
      await authResponse.when(onError: (error) {
        emit(state.copyWith(
          status: AuthStatus.failure,
          failure: error,
        ));
      }, onSuccess: (registerRes) async{
        await service<AppPreferencesManager>().saveValue(registerRes);
        emit(state.copyWith(
          status: AuthStatus.success,
          failure: null,
          data:registerRes as User
        ));
        service<Talker>().info(registerRes);

      });
    });

    on<_VerifyOtp>((event,emit)async{
      emit((state.copyWith(status: AuthStatus.loading)));
      final authResponse = await _authService.verifyOtp(event.request);
      await authResponse.when(onError: (error) {
        emit(state.copyWith(
          status: AuthStatus.failure,
          failure: error,
        ));
      }, onSuccess: (registerRes) async{
        await service<AppPreferencesManager>().saveValue(registerRes);
        emit(state.copyWith(
            status: AuthStatus.success,
            failure: null,
            data:registerRes as User
        ));

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
      await authResponse.when(
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

    on<_EditProfile>((event, emit) async {
      emit(state.copyWith(status: AuthStatus.loading));

      final authResponse = await _profileService.updateProfilePicture(event.request);

      await authResponse.when(
        onError: (failure) async {
          emit(state.copyWith(
            status: AuthStatus.failure,
            failure: failure,
          ));
        },
        onSuccess: (userData) async {
          final serverResponse = await _profileService.updateProfileLink({
            "email": userData.email,
            "picture": userData.picture ?? "",
          });

          await serverResponse.when(
            onError: (failure) async {
              emit(state.copyWith(
                status: AuthStatus.failure,
                failure: failure,
              ));
            },
            onSuccess: (updatedUserData) async {
              try {
                await service<AppPreferencesManager>().saveValue(updatedUserData);
                emit(state.copyWith(
                  status: AuthStatus.success,
                  data: updatedUserData,
                ));
              } catch (e) {
                emit(state.copyWith(
                  status: AuthStatus.failure,
                  failure: Failure(error: "Failed to save user data: $e"),
                ));
              }
            },
          );
        },
      );
    });

}
}