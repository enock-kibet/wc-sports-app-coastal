part of 'auth_bloc.dart';

@freezed
class AuthEvent with _$AuthEvent {
  const factory AuthEvent.login({required dynamic request}) = _Login;
  const factory AuthEvent.sendOtp({required String phone}) = _SendOtp;
  const factory AuthEvent.verifyandResetPassword(
      {required Map<String, dynamic> data}) = _VerifyAndResetPassword;
  const factory AuthEvent.registering({required dynamic request}) =
      _Registered;
  const factory AuthEvent.editProfile({required dynamic request}) =
      _EditProfile;
  const factory AuthEvent.myProfile({required int id}) = _MyProfile;
}
