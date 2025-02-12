// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'auth_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$AuthEvent {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(dynamic request) login,
    required TResult Function(dynamic request) verifyOtp,
    required TResult Function(dynamic request) googlelogin,
    required TResult Function(dynamic request) resendOtp,
    required TResult Function(Map<String, dynamic> data) verifyandResetPassword,
    required TResult Function(dynamic request) registering,
    required TResult Function(dynamic request) editProfile,
    required TResult Function(int id) myProfile,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(dynamic request)? login,
    TResult? Function(dynamic request)? verifyOtp,
    TResult? Function(dynamic request)? googlelogin,
    TResult? Function(dynamic request)? resendOtp,
    TResult? Function(Map<String, dynamic> data)? verifyandResetPassword,
    TResult? Function(dynamic request)? registering,
    TResult? Function(dynamic request)? editProfile,
    TResult? Function(int id)? myProfile,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(dynamic request)? login,
    TResult Function(dynamic request)? verifyOtp,
    TResult Function(dynamic request)? googlelogin,
    TResult Function(dynamic request)? resendOtp,
    TResult Function(Map<String, dynamic> data)? verifyandResetPassword,
    TResult Function(dynamic request)? registering,
    TResult Function(dynamic request)? editProfile,
    TResult Function(int id)? myProfile,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Login value) login,
    required TResult Function(_VerifyOtp value) verifyOtp,
    required TResult Function(_GoogleLogin value) googlelogin,
    required TResult Function(_ResendOtp value) resendOtp,
    required TResult Function(_VerifyAndResetPassword value)
        verifyandResetPassword,
    required TResult Function(_Registered value) registering,
    required TResult Function(_EditProfile value) editProfile,
    required TResult Function(_MyProfile value) myProfile,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Login value)? login,
    TResult? Function(_VerifyOtp value)? verifyOtp,
    TResult? Function(_GoogleLogin value)? googlelogin,
    TResult? Function(_ResendOtp value)? resendOtp,
    TResult? Function(_VerifyAndResetPassword value)? verifyandResetPassword,
    TResult? Function(_Registered value)? registering,
    TResult? Function(_EditProfile value)? editProfile,
    TResult? Function(_MyProfile value)? myProfile,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Login value)? login,
    TResult Function(_VerifyOtp value)? verifyOtp,
    TResult Function(_GoogleLogin value)? googlelogin,
    TResult Function(_ResendOtp value)? resendOtp,
    TResult Function(_VerifyAndResetPassword value)? verifyandResetPassword,
    TResult Function(_Registered value)? registering,
    TResult Function(_EditProfile value)? editProfile,
    TResult Function(_MyProfile value)? myProfile,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AuthEventCopyWith<$Res> {
  factory $AuthEventCopyWith(AuthEvent value, $Res Function(AuthEvent) then) =
      _$AuthEventCopyWithImpl<$Res, AuthEvent>;
}

/// @nodoc
class _$AuthEventCopyWithImpl<$Res, $Val extends AuthEvent>
    implements $AuthEventCopyWith<$Res> {
  _$AuthEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;
}

/// @nodoc
abstract class _$$LoginImplCopyWith<$Res> {
  factory _$$LoginImplCopyWith(
          _$LoginImpl value, $Res Function(_$LoginImpl) then) =
      __$$LoginImplCopyWithImpl<$Res>;
  @useResult
  $Res call({dynamic request});
}

/// @nodoc
class __$$LoginImplCopyWithImpl<$Res>
    extends _$AuthEventCopyWithImpl<$Res, _$LoginImpl>
    implements _$$LoginImplCopyWith<$Res> {
  __$$LoginImplCopyWithImpl(
      _$LoginImpl _value, $Res Function(_$LoginImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? request = freezed,
  }) {
    return _then(_$LoginImpl(
      request: freezed == request
          ? _value.request
          : request // ignore: cast_nullable_to_non_nullable
              as dynamic,
    ));
  }
}

/// @nodoc

class _$LoginImpl implements _Login {
  const _$LoginImpl({required this.request});

  @override
  final dynamic request;

  @override
  String toString() {
    return 'AuthEvent.login(request: $request)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LoginImpl &&
            const DeepCollectionEquality().equals(other.request, request));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(request));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$LoginImplCopyWith<_$LoginImpl> get copyWith =>
      __$$LoginImplCopyWithImpl<_$LoginImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(dynamic request) login,
    required TResult Function(dynamic request) verifyOtp,
    required TResult Function(dynamic request) googlelogin,
    required TResult Function(dynamic request) resendOtp,
    required TResult Function(Map<String, dynamic> data) verifyandResetPassword,
    required TResult Function(dynamic request) registering,
    required TResult Function(dynamic request) editProfile,
    required TResult Function(int id) myProfile,
  }) {
    return login(request);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(dynamic request)? login,
    TResult? Function(dynamic request)? verifyOtp,
    TResult? Function(dynamic request)? googlelogin,
    TResult? Function(dynamic request)? resendOtp,
    TResult? Function(Map<String, dynamic> data)? verifyandResetPassword,
    TResult? Function(dynamic request)? registering,
    TResult? Function(dynamic request)? editProfile,
    TResult? Function(int id)? myProfile,
  }) {
    return login?.call(request);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(dynamic request)? login,
    TResult Function(dynamic request)? verifyOtp,
    TResult Function(dynamic request)? googlelogin,
    TResult Function(dynamic request)? resendOtp,
    TResult Function(Map<String, dynamic> data)? verifyandResetPassword,
    TResult Function(dynamic request)? registering,
    TResult Function(dynamic request)? editProfile,
    TResult Function(int id)? myProfile,
    required TResult orElse(),
  }) {
    if (login != null) {
      return login(request);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Login value) login,
    required TResult Function(_VerifyOtp value) verifyOtp,
    required TResult Function(_GoogleLogin value) googlelogin,
    required TResult Function(_ResendOtp value) resendOtp,
    required TResult Function(_VerifyAndResetPassword value)
        verifyandResetPassword,
    required TResult Function(_Registered value) registering,
    required TResult Function(_EditProfile value) editProfile,
    required TResult Function(_MyProfile value) myProfile,
  }) {
    return login(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Login value)? login,
    TResult? Function(_VerifyOtp value)? verifyOtp,
    TResult? Function(_GoogleLogin value)? googlelogin,
    TResult? Function(_ResendOtp value)? resendOtp,
    TResult? Function(_VerifyAndResetPassword value)? verifyandResetPassword,
    TResult? Function(_Registered value)? registering,
    TResult? Function(_EditProfile value)? editProfile,
    TResult? Function(_MyProfile value)? myProfile,
  }) {
    return login?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Login value)? login,
    TResult Function(_VerifyOtp value)? verifyOtp,
    TResult Function(_GoogleLogin value)? googlelogin,
    TResult Function(_ResendOtp value)? resendOtp,
    TResult Function(_VerifyAndResetPassword value)? verifyandResetPassword,
    TResult Function(_Registered value)? registering,
    TResult Function(_EditProfile value)? editProfile,
    TResult Function(_MyProfile value)? myProfile,
    required TResult orElse(),
  }) {
    if (login != null) {
      return login(this);
    }
    return orElse();
  }
}

abstract class _Login implements AuthEvent {
  const factory _Login({required final dynamic request}) = _$LoginImpl;

  dynamic get request;
  @JsonKey(ignore: true)
  _$$LoginImplCopyWith<_$LoginImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$VerifyOtpImplCopyWith<$Res> {
  factory _$$VerifyOtpImplCopyWith(
          _$VerifyOtpImpl value, $Res Function(_$VerifyOtpImpl) then) =
      __$$VerifyOtpImplCopyWithImpl<$Res>;
  @useResult
  $Res call({dynamic request});
}

/// @nodoc
class __$$VerifyOtpImplCopyWithImpl<$Res>
    extends _$AuthEventCopyWithImpl<$Res, _$VerifyOtpImpl>
    implements _$$VerifyOtpImplCopyWith<$Res> {
  __$$VerifyOtpImplCopyWithImpl(
      _$VerifyOtpImpl _value, $Res Function(_$VerifyOtpImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? request = freezed,
  }) {
    return _then(_$VerifyOtpImpl(
      request: freezed == request
          ? _value.request
          : request // ignore: cast_nullable_to_non_nullable
              as dynamic,
    ));
  }
}

/// @nodoc

class _$VerifyOtpImpl implements _VerifyOtp {
  const _$VerifyOtpImpl({required this.request});

  @override
  final dynamic request;

  @override
  String toString() {
    return 'AuthEvent.verifyOtp(request: $request)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$VerifyOtpImpl &&
            const DeepCollectionEquality().equals(other.request, request));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(request));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$VerifyOtpImplCopyWith<_$VerifyOtpImpl> get copyWith =>
      __$$VerifyOtpImplCopyWithImpl<_$VerifyOtpImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(dynamic request) login,
    required TResult Function(dynamic request) verifyOtp,
    required TResult Function(dynamic request) googlelogin,
    required TResult Function(dynamic request) resendOtp,
    required TResult Function(Map<String, dynamic> data) verifyandResetPassword,
    required TResult Function(dynamic request) registering,
    required TResult Function(dynamic request) editProfile,
    required TResult Function(int id) myProfile,
  }) {
    return verifyOtp(request);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(dynamic request)? login,
    TResult? Function(dynamic request)? verifyOtp,
    TResult? Function(dynamic request)? googlelogin,
    TResult? Function(dynamic request)? resendOtp,
    TResult? Function(Map<String, dynamic> data)? verifyandResetPassword,
    TResult? Function(dynamic request)? registering,
    TResult? Function(dynamic request)? editProfile,
    TResult? Function(int id)? myProfile,
  }) {
    return verifyOtp?.call(request);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(dynamic request)? login,
    TResult Function(dynamic request)? verifyOtp,
    TResult Function(dynamic request)? googlelogin,
    TResult Function(dynamic request)? resendOtp,
    TResult Function(Map<String, dynamic> data)? verifyandResetPassword,
    TResult Function(dynamic request)? registering,
    TResult Function(dynamic request)? editProfile,
    TResult Function(int id)? myProfile,
    required TResult orElse(),
  }) {
    if (verifyOtp != null) {
      return verifyOtp(request);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Login value) login,
    required TResult Function(_VerifyOtp value) verifyOtp,
    required TResult Function(_GoogleLogin value) googlelogin,
    required TResult Function(_ResendOtp value) resendOtp,
    required TResult Function(_VerifyAndResetPassword value)
        verifyandResetPassword,
    required TResult Function(_Registered value) registering,
    required TResult Function(_EditProfile value) editProfile,
    required TResult Function(_MyProfile value) myProfile,
  }) {
    return verifyOtp(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Login value)? login,
    TResult? Function(_VerifyOtp value)? verifyOtp,
    TResult? Function(_GoogleLogin value)? googlelogin,
    TResult? Function(_ResendOtp value)? resendOtp,
    TResult? Function(_VerifyAndResetPassword value)? verifyandResetPassword,
    TResult? Function(_Registered value)? registering,
    TResult? Function(_EditProfile value)? editProfile,
    TResult? Function(_MyProfile value)? myProfile,
  }) {
    return verifyOtp?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Login value)? login,
    TResult Function(_VerifyOtp value)? verifyOtp,
    TResult Function(_GoogleLogin value)? googlelogin,
    TResult Function(_ResendOtp value)? resendOtp,
    TResult Function(_VerifyAndResetPassword value)? verifyandResetPassword,
    TResult Function(_Registered value)? registering,
    TResult Function(_EditProfile value)? editProfile,
    TResult Function(_MyProfile value)? myProfile,
    required TResult orElse(),
  }) {
    if (verifyOtp != null) {
      return verifyOtp(this);
    }
    return orElse();
  }
}

abstract class _VerifyOtp implements AuthEvent {
  const factory _VerifyOtp({required final dynamic request}) = _$VerifyOtpImpl;

  dynamic get request;
  @JsonKey(ignore: true)
  _$$VerifyOtpImplCopyWith<_$VerifyOtpImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$GoogleLoginImplCopyWith<$Res> {
  factory _$$GoogleLoginImplCopyWith(
          _$GoogleLoginImpl value, $Res Function(_$GoogleLoginImpl) then) =
      __$$GoogleLoginImplCopyWithImpl<$Res>;
  @useResult
  $Res call({dynamic request});
}

/// @nodoc
class __$$GoogleLoginImplCopyWithImpl<$Res>
    extends _$AuthEventCopyWithImpl<$Res, _$GoogleLoginImpl>
    implements _$$GoogleLoginImplCopyWith<$Res> {
  __$$GoogleLoginImplCopyWithImpl(
      _$GoogleLoginImpl _value, $Res Function(_$GoogleLoginImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? request = freezed,
  }) {
    return _then(_$GoogleLoginImpl(
      request: freezed == request
          ? _value.request
          : request // ignore: cast_nullable_to_non_nullable
              as dynamic,
    ));
  }
}

/// @nodoc

class _$GoogleLoginImpl implements _GoogleLogin {
  const _$GoogleLoginImpl({required this.request});

  @override
  final dynamic request;

  @override
  String toString() {
    return 'AuthEvent.googlelogin(request: $request)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GoogleLoginImpl &&
            const DeepCollectionEquality().equals(other.request, request));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(request));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$GoogleLoginImplCopyWith<_$GoogleLoginImpl> get copyWith =>
      __$$GoogleLoginImplCopyWithImpl<_$GoogleLoginImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(dynamic request) login,
    required TResult Function(dynamic request) verifyOtp,
    required TResult Function(dynamic request) googlelogin,
    required TResult Function(dynamic request) resendOtp,
    required TResult Function(Map<String, dynamic> data) verifyandResetPassword,
    required TResult Function(dynamic request) registering,
    required TResult Function(dynamic request) editProfile,
    required TResult Function(int id) myProfile,
  }) {
    return googlelogin(request);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(dynamic request)? login,
    TResult? Function(dynamic request)? verifyOtp,
    TResult? Function(dynamic request)? googlelogin,
    TResult? Function(dynamic request)? resendOtp,
    TResult? Function(Map<String, dynamic> data)? verifyandResetPassword,
    TResult? Function(dynamic request)? registering,
    TResult? Function(dynamic request)? editProfile,
    TResult? Function(int id)? myProfile,
  }) {
    return googlelogin?.call(request);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(dynamic request)? login,
    TResult Function(dynamic request)? verifyOtp,
    TResult Function(dynamic request)? googlelogin,
    TResult Function(dynamic request)? resendOtp,
    TResult Function(Map<String, dynamic> data)? verifyandResetPassword,
    TResult Function(dynamic request)? registering,
    TResult Function(dynamic request)? editProfile,
    TResult Function(int id)? myProfile,
    required TResult orElse(),
  }) {
    if (googlelogin != null) {
      return googlelogin(request);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Login value) login,
    required TResult Function(_VerifyOtp value) verifyOtp,
    required TResult Function(_GoogleLogin value) googlelogin,
    required TResult Function(_ResendOtp value) resendOtp,
    required TResult Function(_VerifyAndResetPassword value)
        verifyandResetPassword,
    required TResult Function(_Registered value) registering,
    required TResult Function(_EditProfile value) editProfile,
    required TResult Function(_MyProfile value) myProfile,
  }) {
    return googlelogin(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Login value)? login,
    TResult? Function(_VerifyOtp value)? verifyOtp,
    TResult? Function(_GoogleLogin value)? googlelogin,
    TResult? Function(_ResendOtp value)? resendOtp,
    TResult? Function(_VerifyAndResetPassword value)? verifyandResetPassword,
    TResult? Function(_Registered value)? registering,
    TResult? Function(_EditProfile value)? editProfile,
    TResult? Function(_MyProfile value)? myProfile,
  }) {
    return googlelogin?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Login value)? login,
    TResult Function(_VerifyOtp value)? verifyOtp,
    TResult Function(_GoogleLogin value)? googlelogin,
    TResult Function(_ResendOtp value)? resendOtp,
    TResult Function(_VerifyAndResetPassword value)? verifyandResetPassword,
    TResult Function(_Registered value)? registering,
    TResult Function(_EditProfile value)? editProfile,
    TResult Function(_MyProfile value)? myProfile,
    required TResult orElse(),
  }) {
    if (googlelogin != null) {
      return googlelogin(this);
    }
    return orElse();
  }
}

abstract class _GoogleLogin implements AuthEvent {
  const factory _GoogleLogin({required final dynamic request}) =
      _$GoogleLoginImpl;

  dynamic get request;
  @JsonKey(ignore: true)
  _$$GoogleLoginImplCopyWith<_$GoogleLoginImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ResendOtpImplCopyWith<$Res> {
  factory _$$ResendOtpImplCopyWith(
          _$ResendOtpImpl value, $Res Function(_$ResendOtpImpl) then) =
      __$$ResendOtpImplCopyWithImpl<$Res>;
  @useResult
  $Res call({dynamic request});
}

/// @nodoc
class __$$ResendOtpImplCopyWithImpl<$Res>
    extends _$AuthEventCopyWithImpl<$Res, _$ResendOtpImpl>
    implements _$$ResendOtpImplCopyWith<$Res> {
  __$$ResendOtpImplCopyWithImpl(
      _$ResendOtpImpl _value, $Res Function(_$ResendOtpImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? request = freezed,
  }) {
    return _then(_$ResendOtpImpl(
      request: freezed == request
          ? _value.request
          : request // ignore: cast_nullable_to_non_nullable
              as dynamic,
    ));
  }
}

/// @nodoc

class _$ResendOtpImpl implements _ResendOtp {
  const _$ResendOtpImpl({required this.request});

  @override
  final dynamic request;

  @override
  String toString() {
    return 'AuthEvent.resendOtp(request: $request)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ResendOtpImpl &&
            const DeepCollectionEquality().equals(other.request, request));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(request));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ResendOtpImplCopyWith<_$ResendOtpImpl> get copyWith =>
      __$$ResendOtpImplCopyWithImpl<_$ResendOtpImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(dynamic request) login,
    required TResult Function(dynamic request) verifyOtp,
    required TResult Function(dynamic request) googlelogin,
    required TResult Function(dynamic request) resendOtp,
    required TResult Function(Map<String, dynamic> data) verifyandResetPassword,
    required TResult Function(dynamic request) registering,
    required TResult Function(dynamic request) editProfile,
    required TResult Function(int id) myProfile,
  }) {
    return resendOtp(request);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(dynamic request)? login,
    TResult? Function(dynamic request)? verifyOtp,
    TResult? Function(dynamic request)? googlelogin,
    TResult? Function(dynamic request)? resendOtp,
    TResult? Function(Map<String, dynamic> data)? verifyandResetPassword,
    TResult? Function(dynamic request)? registering,
    TResult? Function(dynamic request)? editProfile,
    TResult? Function(int id)? myProfile,
  }) {
    return resendOtp?.call(request);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(dynamic request)? login,
    TResult Function(dynamic request)? verifyOtp,
    TResult Function(dynamic request)? googlelogin,
    TResult Function(dynamic request)? resendOtp,
    TResult Function(Map<String, dynamic> data)? verifyandResetPassword,
    TResult Function(dynamic request)? registering,
    TResult Function(dynamic request)? editProfile,
    TResult Function(int id)? myProfile,
    required TResult orElse(),
  }) {
    if (resendOtp != null) {
      return resendOtp(request);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Login value) login,
    required TResult Function(_VerifyOtp value) verifyOtp,
    required TResult Function(_GoogleLogin value) googlelogin,
    required TResult Function(_ResendOtp value) resendOtp,
    required TResult Function(_VerifyAndResetPassword value)
        verifyandResetPassword,
    required TResult Function(_Registered value) registering,
    required TResult Function(_EditProfile value) editProfile,
    required TResult Function(_MyProfile value) myProfile,
  }) {
    return resendOtp(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Login value)? login,
    TResult? Function(_VerifyOtp value)? verifyOtp,
    TResult? Function(_GoogleLogin value)? googlelogin,
    TResult? Function(_ResendOtp value)? resendOtp,
    TResult? Function(_VerifyAndResetPassword value)? verifyandResetPassword,
    TResult? Function(_Registered value)? registering,
    TResult? Function(_EditProfile value)? editProfile,
    TResult? Function(_MyProfile value)? myProfile,
  }) {
    return resendOtp?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Login value)? login,
    TResult Function(_VerifyOtp value)? verifyOtp,
    TResult Function(_GoogleLogin value)? googlelogin,
    TResult Function(_ResendOtp value)? resendOtp,
    TResult Function(_VerifyAndResetPassword value)? verifyandResetPassword,
    TResult Function(_Registered value)? registering,
    TResult Function(_EditProfile value)? editProfile,
    TResult Function(_MyProfile value)? myProfile,
    required TResult orElse(),
  }) {
    if (resendOtp != null) {
      return resendOtp(this);
    }
    return orElse();
  }
}

abstract class _ResendOtp implements AuthEvent {
  const factory _ResendOtp({required final dynamic request}) = _$ResendOtpImpl;

  dynamic get request;
  @JsonKey(ignore: true)
  _$$ResendOtpImplCopyWith<_$ResendOtpImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$VerifyAndResetPasswordImplCopyWith<$Res> {
  factory _$$VerifyAndResetPasswordImplCopyWith(
          _$VerifyAndResetPasswordImpl value,
          $Res Function(_$VerifyAndResetPasswordImpl) then) =
      __$$VerifyAndResetPasswordImplCopyWithImpl<$Res>;
  @useResult
  $Res call({Map<String, dynamic> data});
}

/// @nodoc
class __$$VerifyAndResetPasswordImplCopyWithImpl<$Res>
    extends _$AuthEventCopyWithImpl<$Res, _$VerifyAndResetPasswordImpl>
    implements _$$VerifyAndResetPasswordImplCopyWith<$Res> {
  __$$VerifyAndResetPasswordImplCopyWithImpl(
      _$VerifyAndResetPasswordImpl _value,
      $Res Function(_$VerifyAndResetPasswordImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? data = null,
  }) {
    return _then(_$VerifyAndResetPasswordImpl(
      data: null == data
          ? _value._data
          : data // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
    ));
  }
}

/// @nodoc

class _$VerifyAndResetPasswordImpl implements _VerifyAndResetPassword {
  const _$VerifyAndResetPasswordImpl({required final Map<String, dynamic> data})
      : _data = data;

  final Map<String, dynamic> _data;
  @override
  Map<String, dynamic> get data {
    if (_data is EqualUnmodifiableMapView) return _data;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_data);
  }

  @override
  String toString() {
    return 'AuthEvent.verifyandResetPassword(data: $data)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$VerifyAndResetPasswordImpl &&
            const DeepCollectionEquality().equals(other._data, _data));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_data));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$VerifyAndResetPasswordImplCopyWith<_$VerifyAndResetPasswordImpl>
      get copyWith => __$$VerifyAndResetPasswordImplCopyWithImpl<
          _$VerifyAndResetPasswordImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(dynamic request) login,
    required TResult Function(dynamic request) verifyOtp,
    required TResult Function(dynamic request) googlelogin,
    required TResult Function(dynamic request) resendOtp,
    required TResult Function(Map<String, dynamic> data) verifyandResetPassword,
    required TResult Function(dynamic request) registering,
    required TResult Function(dynamic request) editProfile,
    required TResult Function(int id) myProfile,
  }) {
    return verifyandResetPassword(data);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(dynamic request)? login,
    TResult? Function(dynamic request)? verifyOtp,
    TResult? Function(dynamic request)? googlelogin,
    TResult? Function(dynamic request)? resendOtp,
    TResult? Function(Map<String, dynamic> data)? verifyandResetPassword,
    TResult? Function(dynamic request)? registering,
    TResult? Function(dynamic request)? editProfile,
    TResult? Function(int id)? myProfile,
  }) {
    return verifyandResetPassword?.call(data);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(dynamic request)? login,
    TResult Function(dynamic request)? verifyOtp,
    TResult Function(dynamic request)? googlelogin,
    TResult Function(dynamic request)? resendOtp,
    TResult Function(Map<String, dynamic> data)? verifyandResetPassword,
    TResult Function(dynamic request)? registering,
    TResult Function(dynamic request)? editProfile,
    TResult Function(int id)? myProfile,
    required TResult orElse(),
  }) {
    if (verifyandResetPassword != null) {
      return verifyandResetPassword(data);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Login value) login,
    required TResult Function(_VerifyOtp value) verifyOtp,
    required TResult Function(_GoogleLogin value) googlelogin,
    required TResult Function(_ResendOtp value) resendOtp,
    required TResult Function(_VerifyAndResetPassword value)
        verifyandResetPassword,
    required TResult Function(_Registered value) registering,
    required TResult Function(_EditProfile value) editProfile,
    required TResult Function(_MyProfile value) myProfile,
  }) {
    return verifyandResetPassword(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Login value)? login,
    TResult? Function(_VerifyOtp value)? verifyOtp,
    TResult? Function(_GoogleLogin value)? googlelogin,
    TResult? Function(_ResendOtp value)? resendOtp,
    TResult? Function(_VerifyAndResetPassword value)? verifyandResetPassword,
    TResult? Function(_Registered value)? registering,
    TResult? Function(_EditProfile value)? editProfile,
    TResult? Function(_MyProfile value)? myProfile,
  }) {
    return verifyandResetPassword?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Login value)? login,
    TResult Function(_VerifyOtp value)? verifyOtp,
    TResult Function(_GoogleLogin value)? googlelogin,
    TResult Function(_ResendOtp value)? resendOtp,
    TResult Function(_VerifyAndResetPassword value)? verifyandResetPassword,
    TResult Function(_Registered value)? registering,
    TResult Function(_EditProfile value)? editProfile,
    TResult Function(_MyProfile value)? myProfile,
    required TResult orElse(),
  }) {
    if (verifyandResetPassword != null) {
      return verifyandResetPassword(this);
    }
    return orElse();
  }
}

abstract class _VerifyAndResetPassword implements AuthEvent {
  const factory _VerifyAndResetPassword(
          {required final Map<String, dynamic> data}) =
      _$VerifyAndResetPasswordImpl;

  Map<String, dynamic> get data;
  @JsonKey(ignore: true)
  _$$VerifyAndResetPasswordImplCopyWith<_$VerifyAndResetPasswordImpl>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$RegisteredImplCopyWith<$Res> {
  factory _$$RegisteredImplCopyWith(
          _$RegisteredImpl value, $Res Function(_$RegisteredImpl) then) =
      __$$RegisteredImplCopyWithImpl<$Res>;
  @useResult
  $Res call({dynamic request});
}

/// @nodoc
class __$$RegisteredImplCopyWithImpl<$Res>
    extends _$AuthEventCopyWithImpl<$Res, _$RegisteredImpl>
    implements _$$RegisteredImplCopyWith<$Res> {
  __$$RegisteredImplCopyWithImpl(
      _$RegisteredImpl _value, $Res Function(_$RegisteredImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? request = freezed,
  }) {
    return _then(_$RegisteredImpl(
      request: freezed == request
          ? _value.request
          : request // ignore: cast_nullable_to_non_nullable
              as dynamic,
    ));
  }
}

/// @nodoc

class _$RegisteredImpl implements _Registered {
  const _$RegisteredImpl({required this.request});

  @override
  final dynamic request;

  @override
  String toString() {
    return 'AuthEvent.registering(request: $request)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RegisteredImpl &&
            const DeepCollectionEquality().equals(other.request, request));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(request));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$RegisteredImplCopyWith<_$RegisteredImpl> get copyWith =>
      __$$RegisteredImplCopyWithImpl<_$RegisteredImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(dynamic request) login,
    required TResult Function(dynamic request) verifyOtp,
    required TResult Function(dynamic request) googlelogin,
    required TResult Function(dynamic request) resendOtp,
    required TResult Function(Map<String, dynamic> data) verifyandResetPassword,
    required TResult Function(dynamic request) registering,
    required TResult Function(dynamic request) editProfile,
    required TResult Function(int id) myProfile,
  }) {
    return registering(request);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(dynamic request)? login,
    TResult? Function(dynamic request)? verifyOtp,
    TResult? Function(dynamic request)? googlelogin,
    TResult? Function(dynamic request)? resendOtp,
    TResult? Function(Map<String, dynamic> data)? verifyandResetPassword,
    TResult? Function(dynamic request)? registering,
    TResult? Function(dynamic request)? editProfile,
    TResult? Function(int id)? myProfile,
  }) {
    return registering?.call(request);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(dynamic request)? login,
    TResult Function(dynamic request)? verifyOtp,
    TResult Function(dynamic request)? googlelogin,
    TResult Function(dynamic request)? resendOtp,
    TResult Function(Map<String, dynamic> data)? verifyandResetPassword,
    TResult Function(dynamic request)? registering,
    TResult Function(dynamic request)? editProfile,
    TResult Function(int id)? myProfile,
    required TResult orElse(),
  }) {
    if (registering != null) {
      return registering(request);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Login value) login,
    required TResult Function(_VerifyOtp value) verifyOtp,
    required TResult Function(_GoogleLogin value) googlelogin,
    required TResult Function(_ResendOtp value) resendOtp,
    required TResult Function(_VerifyAndResetPassword value)
        verifyandResetPassword,
    required TResult Function(_Registered value) registering,
    required TResult Function(_EditProfile value) editProfile,
    required TResult Function(_MyProfile value) myProfile,
  }) {
    return registering(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Login value)? login,
    TResult? Function(_VerifyOtp value)? verifyOtp,
    TResult? Function(_GoogleLogin value)? googlelogin,
    TResult? Function(_ResendOtp value)? resendOtp,
    TResult? Function(_VerifyAndResetPassword value)? verifyandResetPassword,
    TResult? Function(_Registered value)? registering,
    TResult? Function(_EditProfile value)? editProfile,
    TResult? Function(_MyProfile value)? myProfile,
  }) {
    return registering?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Login value)? login,
    TResult Function(_VerifyOtp value)? verifyOtp,
    TResult Function(_GoogleLogin value)? googlelogin,
    TResult Function(_ResendOtp value)? resendOtp,
    TResult Function(_VerifyAndResetPassword value)? verifyandResetPassword,
    TResult Function(_Registered value)? registering,
    TResult Function(_EditProfile value)? editProfile,
    TResult Function(_MyProfile value)? myProfile,
    required TResult orElse(),
  }) {
    if (registering != null) {
      return registering(this);
    }
    return orElse();
  }
}

abstract class _Registered implements AuthEvent {
  const factory _Registered({required final dynamic request}) =
      _$RegisteredImpl;

  dynamic get request;
  @JsonKey(ignore: true)
  _$$RegisteredImplCopyWith<_$RegisteredImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$EditProfileImplCopyWith<$Res> {
  factory _$$EditProfileImplCopyWith(
          _$EditProfileImpl value, $Res Function(_$EditProfileImpl) then) =
      __$$EditProfileImplCopyWithImpl<$Res>;
  @useResult
  $Res call({dynamic request});
}

/// @nodoc
class __$$EditProfileImplCopyWithImpl<$Res>
    extends _$AuthEventCopyWithImpl<$Res, _$EditProfileImpl>
    implements _$$EditProfileImplCopyWith<$Res> {
  __$$EditProfileImplCopyWithImpl(
      _$EditProfileImpl _value, $Res Function(_$EditProfileImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? request = freezed,
  }) {
    return _then(_$EditProfileImpl(
      request: freezed == request
          ? _value.request
          : request // ignore: cast_nullable_to_non_nullable
              as dynamic,
    ));
  }
}

/// @nodoc

class _$EditProfileImpl implements _EditProfile {
  const _$EditProfileImpl({required this.request});

  @override
  final dynamic request;

  @override
  String toString() {
    return 'AuthEvent.editProfile(request: $request)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$EditProfileImpl &&
            const DeepCollectionEquality().equals(other.request, request));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(request));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$EditProfileImplCopyWith<_$EditProfileImpl> get copyWith =>
      __$$EditProfileImplCopyWithImpl<_$EditProfileImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(dynamic request) login,
    required TResult Function(dynamic request) verifyOtp,
    required TResult Function(dynamic request) googlelogin,
    required TResult Function(dynamic request) resendOtp,
    required TResult Function(Map<String, dynamic> data) verifyandResetPassword,
    required TResult Function(dynamic request) registering,
    required TResult Function(dynamic request) editProfile,
    required TResult Function(int id) myProfile,
  }) {
    return editProfile(request);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(dynamic request)? login,
    TResult? Function(dynamic request)? verifyOtp,
    TResult? Function(dynamic request)? googlelogin,
    TResult? Function(dynamic request)? resendOtp,
    TResult? Function(Map<String, dynamic> data)? verifyandResetPassword,
    TResult? Function(dynamic request)? registering,
    TResult? Function(dynamic request)? editProfile,
    TResult? Function(int id)? myProfile,
  }) {
    return editProfile?.call(request);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(dynamic request)? login,
    TResult Function(dynamic request)? verifyOtp,
    TResult Function(dynamic request)? googlelogin,
    TResult Function(dynamic request)? resendOtp,
    TResult Function(Map<String, dynamic> data)? verifyandResetPassword,
    TResult Function(dynamic request)? registering,
    TResult Function(dynamic request)? editProfile,
    TResult Function(int id)? myProfile,
    required TResult orElse(),
  }) {
    if (editProfile != null) {
      return editProfile(request);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Login value) login,
    required TResult Function(_VerifyOtp value) verifyOtp,
    required TResult Function(_GoogleLogin value) googlelogin,
    required TResult Function(_ResendOtp value) resendOtp,
    required TResult Function(_VerifyAndResetPassword value)
        verifyandResetPassword,
    required TResult Function(_Registered value) registering,
    required TResult Function(_EditProfile value) editProfile,
    required TResult Function(_MyProfile value) myProfile,
  }) {
    return editProfile(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Login value)? login,
    TResult? Function(_VerifyOtp value)? verifyOtp,
    TResult? Function(_GoogleLogin value)? googlelogin,
    TResult? Function(_ResendOtp value)? resendOtp,
    TResult? Function(_VerifyAndResetPassword value)? verifyandResetPassword,
    TResult? Function(_Registered value)? registering,
    TResult? Function(_EditProfile value)? editProfile,
    TResult? Function(_MyProfile value)? myProfile,
  }) {
    return editProfile?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Login value)? login,
    TResult Function(_VerifyOtp value)? verifyOtp,
    TResult Function(_GoogleLogin value)? googlelogin,
    TResult Function(_ResendOtp value)? resendOtp,
    TResult Function(_VerifyAndResetPassword value)? verifyandResetPassword,
    TResult Function(_Registered value)? registering,
    TResult Function(_EditProfile value)? editProfile,
    TResult Function(_MyProfile value)? myProfile,
    required TResult orElse(),
  }) {
    if (editProfile != null) {
      return editProfile(this);
    }
    return orElse();
  }
}

abstract class _EditProfile implements AuthEvent {
  const factory _EditProfile({required final dynamic request}) =
      _$EditProfileImpl;

  dynamic get request;
  @JsonKey(ignore: true)
  _$$EditProfileImplCopyWith<_$EditProfileImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$MyProfileImplCopyWith<$Res> {
  factory _$$MyProfileImplCopyWith(
          _$MyProfileImpl value, $Res Function(_$MyProfileImpl) then) =
      __$$MyProfileImplCopyWithImpl<$Res>;
  @useResult
  $Res call({int id});
}

/// @nodoc
class __$$MyProfileImplCopyWithImpl<$Res>
    extends _$AuthEventCopyWithImpl<$Res, _$MyProfileImpl>
    implements _$$MyProfileImplCopyWith<$Res> {
  __$$MyProfileImplCopyWithImpl(
      _$MyProfileImpl _value, $Res Function(_$MyProfileImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
  }) {
    return _then(_$MyProfileImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

class _$MyProfileImpl implements _MyProfile {
  const _$MyProfileImpl({required this.id});

  @override
  final int id;

  @override
  String toString() {
    return 'AuthEvent.myProfile(id: $id)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MyProfileImpl &&
            (identical(other.id, id) || other.id == id));
  }

  @override
  int get hashCode => Object.hash(runtimeType, id);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$MyProfileImplCopyWith<_$MyProfileImpl> get copyWith =>
      __$$MyProfileImplCopyWithImpl<_$MyProfileImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(dynamic request) login,
    required TResult Function(dynamic request) verifyOtp,
    required TResult Function(dynamic request) googlelogin,
    required TResult Function(dynamic request) resendOtp,
    required TResult Function(Map<String, dynamic> data) verifyandResetPassword,
    required TResult Function(dynamic request) registering,
    required TResult Function(dynamic request) editProfile,
    required TResult Function(int id) myProfile,
  }) {
    return myProfile(id);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(dynamic request)? login,
    TResult? Function(dynamic request)? verifyOtp,
    TResult? Function(dynamic request)? googlelogin,
    TResult? Function(dynamic request)? resendOtp,
    TResult? Function(Map<String, dynamic> data)? verifyandResetPassword,
    TResult? Function(dynamic request)? registering,
    TResult? Function(dynamic request)? editProfile,
    TResult? Function(int id)? myProfile,
  }) {
    return myProfile?.call(id);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(dynamic request)? login,
    TResult Function(dynamic request)? verifyOtp,
    TResult Function(dynamic request)? googlelogin,
    TResult Function(dynamic request)? resendOtp,
    TResult Function(Map<String, dynamic> data)? verifyandResetPassword,
    TResult Function(dynamic request)? registering,
    TResult Function(dynamic request)? editProfile,
    TResult Function(int id)? myProfile,
    required TResult orElse(),
  }) {
    if (myProfile != null) {
      return myProfile(id);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Login value) login,
    required TResult Function(_VerifyOtp value) verifyOtp,
    required TResult Function(_GoogleLogin value) googlelogin,
    required TResult Function(_ResendOtp value) resendOtp,
    required TResult Function(_VerifyAndResetPassword value)
        verifyandResetPassword,
    required TResult Function(_Registered value) registering,
    required TResult Function(_EditProfile value) editProfile,
    required TResult Function(_MyProfile value) myProfile,
  }) {
    return myProfile(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Login value)? login,
    TResult? Function(_VerifyOtp value)? verifyOtp,
    TResult? Function(_GoogleLogin value)? googlelogin,
    TResult? Function(_ResendOtp value)? resendOtp,
    TResult? Function(_VerifyAndResetPassword value)? verifyandResetPassword,
    TResult? Function(_Registered value)? registering,
    TResult? Function(_EditProfile value)? editProfile,
    TResult? Function(_MyProfile value)? myProfile,
  }) {
    return myProfile?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Login value)? login,
    TResult Function(_VerifyOtp value)? verifyOtp,
    TResult Function(_GoogleLogin value)? googlelogin,
    TResult Function(_ResendOtp value)? resendOtp,
    TResult Function(_VerifyAndResetPassword value)? verifyandResetPassword,
    TResult Function(_Registered value)? registering,
    TResult Function(_EditProfile value)? editProfile,
    TResult Function(_MyProfile value)? myProfile,
    required TResult orElse(),
  }) {
    if (myProfile != null) {
      return myProfile(this);
    }
    return orElse();
  }
}

abstract class _MyProfile implements AuthEvent {
  const factory _MyProfile({required final int id}) = _$MyProfileImpl;

  int get id;
  @JsonKey(ignore: true)
  _$$MyProfileImplCopyWith<_$MyProfileImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$AuthState {
  AuthStatus get status => throw _privateConstructorUsedError;
  Failure? get failure => throw _privateConstructorUsedError;
  dynamic get data => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $AuthStateCopyWith<AuthState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AuthStateCopyWith<$Res> {
  factory $AuthStateCopyWith(AuthState value, $Res Function(AuthState) then) =
      _$AuthStateCopyWithImpl<$Res, AuthState>;
  @useResult
  $Res call({AuthStatus status, Failure? failure, dynamic data});
}

/// @nodoc
class _$AuthStateCopyWithImpl<$Res, $Val extends AuthState>
    implements $AuthStateCopyWith<$Res> {
  _$AuthStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? failure = freezed,
    Object? data = freezed,
  }) {
    return _then(_value.copyWith(
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as AuthStatus,
      failure: freezed == failure
          ? _value.failure
          : failure // ignore: cast_nullable_to_non_nullable
              as Failure?,
      data: freezed == data
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as dynamic,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$AuthStateImplCopyWith<$Res>
    implements $AuthStateCopyWith<$Res> {
  factory _$$AuthStateImplCopyWith(
          _$AuthStateImpl value, $Res Function(_$AuthStateImpl) then) =
      __$$AuthStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({AuthStatus status, Failure? failure, dynamic data});
}

/// @nodoc
class __$$AuthStateImplCopyWithImpl<$Res>
    extends _$AuthStateCopyWithImpl<$Res, _$AuthStateImpl>
    implements _$$AuthStateImplCopyWith<$Res> {
  __$$AuthStateImplCopyWithImpl(
      _$AuthStateImpl _value, $Res Function(_$AuthStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? failure = freezed,
    Object? data = freezed,
  }) {
    return _then(_$AuthStateImpl(
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as AuthStatus,
      failure: freezed == failure
          ? _value.failure
          : failure // ignore: cast_nullable_to_non_nullable
              as Failure?,
      data: freezed == data
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as dynamic,
    ));
  }
}

/// @nodoc

class _$AuthStateImpl implements _AuthState {
  const _$AuthStateImpl(
      {this.status = AuthStatus.initial, this.failure, this.data});

  @override
  @JsonKey()
  final AuthStatus status;
  @override
  final Failure? failure;
  @override
  final dynamic data;

  @override
  String toString() {
    return 'AuthState(status: $status, failure: $failure, data: $data)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AuthStateImpl &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.failure, failure) || other.failure == failure) &&
            const DeepCollectionEquality().equals(other.data, data));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, status, failure, const DeepCollectionEquality().hash(data));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$AuthStateImplCopyWith<_$AuthStateImpl> get copyWith =>
      __$$AuthStateImplCopyWithImpl<_$AuthStateImpl>(this, _$identity);
}

abstract class _AuthState implements AuthState {
  const factory _AuthState(
      {final AuthStatus status,
      final Failure? failure,
      final dynamic data}) = _$AuthStateImpl;

  @override
  AuthStatus get status;
  @override
  Failure? get failure;
  @override
  dynamic get data;
  @override
  @JsonKey(ignore: true)
  _$$AuthStateImplCopyWith<_$AuthStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
