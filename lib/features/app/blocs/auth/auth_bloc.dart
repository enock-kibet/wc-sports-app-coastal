import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:sports_app/data/error/failure.dart';
import 'package:sports_app/data/models/session/auth_session.dart';
import 'package:sports_app/data/services/service.dart';
import 'package:sports_app/localization/app_prefs_manager.dart';
import 'package:talker_flutter/talker_flutter.dart';

import '../../../../data/repository/auth_repository.dart';
part 'auth_event.dart';
part 'auth_state.dart';
part 'auth_bloc.freezed.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  late AuthService _authService;
  late ProfileService _profileService;
  late AuthRepository _authRepository;

  AuthBloc() : super(const AuthState()) {
    _authService = service<AuthService>();
    _profileService = service<ProfileService>();
    _authRepository = service<AuthRepository>();

    on<_Login>((event, emit) async {
      emit(state.copyWith(status: AuthStatus.loading));
      final authResponse = await _authService.login(event.request);
      await authResponse.when(onError: (error) {
        emit(state.copyWith(
          status: AuthStatus.failure,
          failure: error,
        ));
      }, onSuccess: (loginRes) async {
        if (loginRes is! AuthenticatedUserPayload) {
          emit(state.copyWith(
            status: AuthStatus.failure,
            failure: Failure(error: "Invalid login response"),
          ));
          return;
        }

        await service<AppPreferencesManager>().saveSession(loginRes);

        emit(state.copyWith(
            status: AuthStatus.success, failure: null, data: loginRes.user));
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
      }, onSuccess: (registerRes) async {
        if (registerRes is! AuthenticatedUserPayload) {
          emit(state.copyWith(
            status: AuthStatus.failure,
            failure: Failure(error: "Invalid signup response"),
          ));
          return;
        }

        await service<AppPreferencesManager>().saveSession(registerRes);
        emit(state.copyWith(
            status: AuthStatus.success, failure: null, data: registerRes.user));
        service<Talker>().info(registerRes);
      });
    });

    on<_VerifyOtp>((event, emit) async {
      emit((state.copyWith(status: AuthStatus.loading)));
      final authResponse = await _authService.verifyOtp(event.request);
      await authResponse.when(onError: (error) {
        emit(state.copyWith(
          status: AuthStatus.failure,
          failure: error,
        ));
      }, onSuccess: (registerRes) async {
        if (registerRes is! AuthenticatedUserPayload) {
          emit(state.copyWith(
            status: AuthStatus.failure,
            failure: Failure(error: "Invalid OTP verification response"),
          ));
          return;
        }

        await service<AppPreferencesManager>().saveSession(registerRes);
        emit(state.copyWith(
            status: AuthStatus.success, failure: null, data: registerRes.user));
      });
    });

    on<_ResendOtp>((event, emit) async {
      emit(state.copyWith(status: AuthStatus.loading));
      final authResponse = await _authService.resendOtp(event.request);
      authResponse.when(onError: (Failure error) {
        emit(state.copyWith(status: AuthStatus.failure, failure: error));
      }, onSuccess: (String data) {
        emit(state.copyWith(status: AuthStatus.success, data: data));
      });
    });

    on<_GoogleLogin>((event, emit) async {
      emit(state.copyWith(status: AuthStatus.loading));
      final authResponse = await _authService.googleLogin(event.request);
      await authResponse.when(onError: (Failure error) {
        emit(state.copyWith(status: AuthStatus.failure, failure: error));
      }, onSuccess: (dynamic data) async {
        if (data is! AuthenticatedUserPayload) {
          emit(state.copyWith(
            status: AuthStatus.failure,
            failure: Failure(error: "Invalid Google login response"),
          ));
          return;
        }

        emit(state.copyWith(status: AuthStatus.success, data: data.user));
        await service<AppPreferencesManager>().saveSession(data);
      });
    });

    on<_AppleLogin>((event, emit) async {
      emit(state.copyWith(status: AuthStatus.loading));
      final authResponse = await _authService.appleLogin(event.request);
      await authResponse.when(onError: (Failure error) {
        emit(state.copyWith(status: AuthStatus.failure, failure: error));
      }, onSuccess: (dynamic data) async {
        if (data is! AuthenticatedUserPayload) {
          emit(state.copyWith(
            status: AuthStatus.failure,
            failure: Failure(error: "Invalid Apple login response"),
          ));
          return;
        }

        emit(state.copyWith(status: AuthStatus.success, data: data.user));
        await service<AppPreferencesManager>().saveSession(data);
      });
    });

    on<_EditProfile>((event, emit) async {
      emit(state.copyWith(status: AuthStatus.uploading));

      final authResponse =
          await _profileService.updateProfilePicture(event.request);

      await authResponse.when(
        onError: (failure) async {
          emit(state.copyWith(
            status: AuthStatus.failure,
            failure: failure,
          ));
        },
        onSuccess: (updatedUserData) async {
          try {
            await service<AppPreferencesManager>()
                .updateUserPhoto(updatedUserData.picture ?? "");
            await service<AppPreferencesManager>().updateUser(updatedUserData);
            emit(state.copyWith(
                status: AuthStatus.uploadSuccess,
                data: updatedUserData,
                pdata: updatedUserData.picture));
          } catch (e) {
            emit(state.copyWith(
              status: AuthStatus.failure,
              failure: Failure(error: "Failed to save user data: $e"),
            ));
          }
        },
      );
    });

    on<_EditProfileData>((event, emit) async {
      emit(state.copyWith(status: AuthStatus.loading));
      final authResponse = await _profileService.updateProfile(event.request);

      await authResponse.when(
        onError: (failure) async {
          emit(state.copyWith(
            status: AuthStatus.failure,
            failure: Failure(error: "Failed to save user data"),
          ));
        },
        onSuccess: (updatedUserData) async {
          try {
            await service<AppPreferencesManager>().updateUser(updatedUserData);
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
    });

    on<_RefreshToken>((event, emit) async {
      final success = await _authRepository.refreshToken();
      final prefs = service<AppPreferencesManager>();

      if (!success) {
        emit(state.copyWith(
          status: AuthStatus.failure,
          failure: Failure(error: "Token refresh failed"),
        ));
        return;
      }

      emit(state.copyWith(
        status: AuthStatus.success,
        data: prefs.currentUserValue!,
      ));
    });
  }

  Future<void> deleteProfile() async {
    // ignore: invalid_use_of_visible_for_testing_member
    emit(state.copyWith(status: AuthStatus.loading, failure: null));
    final response = await _authService.deleteMe();

    await response.when(
      onError: (error) {
        // ignore: invalid_use_of_visible_for_testing_member
        emit(state.copyWith(
          status: AuthStatus.failure,
          failure: error,
        ));
      },
      onSuccess: (message) async {
        await service<AppPreferencesManager>().logOut();
        // ignore: invalid_use_of_visible_for_testing_member
        emit(state.copyWith(
          status: AuthStatus.success,
          failure: null,
          data: message,
        ));
      },
    );
  }
}
