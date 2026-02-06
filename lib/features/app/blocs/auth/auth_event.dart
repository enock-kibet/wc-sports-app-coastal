part of 'auth_bloc.dart';

@freezed
class AuthEvent with _$AuthEvent {
  const factory AuthEvent.login({required dynamic request}) = _Login;
  const factory AuthEvent.verifyOtp({required dynamic request}) = _VerifyOtp;
  const factory AuthEvent.googlelogin({required dynamic request}) =
      _GoogleLogin;

  const factory AuthEvent.appleLogin({required dynamic request}) = _AppleLogin;
  const factory AuthEvent.resendOtp({required dynamic request}) = _ResendOtp;

  const factory AuthEvent.refreshToken({required dynamic request}) =
      _RefreshToken;

  const factory AuthEvent.verifyandResetPassword(
      {required Map<String, dynamic> data}) = _VerifyAndResetPassword;
  const factory AuthEvent.registering({required dynamic request}) = _Registered;
  const factory AuthEvent.editProfile({required dynamic request}) =
      _EditProfile;
  const factory AuthEvent.editProfileData(
      {required Map<String, String> request}) = _EditProfileData;
  const factory AuthEvent.myProfile({required int id}) = _MyProfile;
}
