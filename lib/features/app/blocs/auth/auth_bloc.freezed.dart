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
    required TResult Function(String phone) sendOtp,
    required TResult Function(Map<String, dynamic> data) verifyandResetPassword,
    required TResult Function(dynamic request) registering,
    required TResult Function(dynamic request) editProfile,
    required TResult Function(int id) myProfile,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(dynamic request)? login,
    TResult? Function(String phone)? sendOtp,
    TResult? Function(Map<String, dynamic> data)? verifyandResetPassword,
    TResult? Function(dynamic request)? registering,
    TResult? Function(dynamic request)? editProfile,
    TResult? Function(int id)? myProfile,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(dynamic request)? login,
    TResult Function(String phone)? sendOtp,
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
    required TResult Function(_SendOtp value) sendOtp,
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
    TResult? Function(_SendOtp value)? sendOtp,
    TResult? Function(_VerifyAndResetPassword value)? verifyandResetPassword,
    TResult? Function(_Registered value)? registering,
    TResult? Function(_EditProfile value)? editProfile,
    TResult? Function(_MyProfile value)? myProfile,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Login value)? login,
    TResult Function(_SendOtp value)? sendOtp,
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
    required TResult Function(String phone) sendOtp,
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
    TResult? Function(String phone)? sendOtp,
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
    TResult Function(String phone)? sendOtp,
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
    required TResult Function(_SendOtp value) sendOtp,
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
    TResult? Function(_SendOtp value)? sendOtp,
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
    TResult Function(_SendOtp value)? sendOtp,
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
abstract class _$$SendOtpImplCopyWith<$Res> {
  factory _$$SendOtpImplCopyWith(
          _$SendOtpImpl value, $Res Function(_$SendOtpImpl) then) =
      __$$SendOtpImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String phone});
}

/// @nodoc
class __$$SendOtpImplCopyWithImpl<$Res>
    extends _$AuthEventCopyWithImpl<$Res, _$SendOtpImpl>
    implements _$$SendOtpImplCopyWith<$Res> {
  __$$SendOtpImplCopyWithImpl(
      _$SendOtpImpl _value, $Res Function(_$SendOtpImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? phone = null,
  }) {
    return _then(_$SendOtpImpl(
      phone: null == phone
          ? _value.phone
          : phone // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$SendOtpImpl implements _SendOtp {
  const _$SendOtpImpl({required this.phone});

  @override
  final String phone;

  @override
  String toString() {
    return 'AuthEvent.sendOtp(phone: $phone)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SendOtpImpl &&
            (identical(other.phone, phone) || other.phone == phone));
  }

  @override
  int get hashCode => Object.hash(runtimeType, phone);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$SendOtpImplCopyWith<_$SendOtpImpl> get copyWith =>
      __$$SendOtpImplCopyWithImpl<_$SendOtpImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(dynamic request) login,
    required TResult Function(String phone) sendOtp,
    required TResult Function(Map<String, dynamic> data) verifyandResetPassword,
    required TResult Function(dynamic request) registering,
    required TResult Function(dynamic request) editProfile,
    required TResult Function(int id) myProfile,
  }) {
    return sendOtp(phone);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(dynamic request)? login,
    TResult? Function(String phone)? sendOtp,
    TResult? Function(Map<String, dynamic> data)? verifyandResetPassword,
    TResult? Function(dynamic request)? registering,
    TResult? Function(dynamic request)? editProfile,
    TResult? Function(int id)? myProfile,
  }) {
    return sendOtp?.call(phone);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(dynamic request)? login,
    TResult Function(String phone)? sendOtp,
    TResult Function(Map<String, dynamic> data)? verifyandResetPassword,
    TResult Function(dynamic request)? registering,
    TResult Function(dynamic request)? editProfile,
    TResult Function(int id)? myProfile,
    required TResult orElse(),
  }) {
    if (sendOtp != null) {
      return sendOtp(phone);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Login value) login,
    required TResult Function(_SendOtp value) sendOtp,
    required TResult Function(_VerifyAndResetPassword value)
        verifyandResetPassword,
    required TResult Function(_Registered value) registering,
    required TResult Function(_EditProfile value) editProfile,
    required TResult Function(_MyProfile value) myProfile,
  }) {
    return sendOtp(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Login value)? login,
    TResult? Function(_SendOtp value)? sendOtp,
    TResult? Function(_VerifyAndResetPassword value)? verifyandResetPassword,
    TResult? Function(_Registered value)? registering,
    TResult? Function(_EditProfile value)? editProfile,
    TResult? Function(_MyProfile value)? myProfile,
  }) {
    return sendOtp?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Login value)? login,
    TResult Function(_SendOtp value)? sendOtp,
    TResult Function(_VerifyAndResetPassword value)? verifyandResetPassword,
    TResult Function(_Registered value)? registering,
    TResult Function(_EditProfile value)? editProfile,
    TResult Function(_MyProfile value)? myProfile,
    required TResult orElse(),
  }) {
    if (sendOtp != null) {
      return sendOtp(this);
    }
    return orElse();
  }
}

abstract class _SendOtp implements AuthEvent {
  const factory _SendOtp({required final String phone}) = _$SendOtpImpl;

  String get phone;
  @JsonKey(ignore: true)
  _$$SendOtpImplCopyWith<_$SendOtpImpl> get copyWith =>
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
    required TResult Function(String phone) sendOtp,
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
    TResult? Function(String phone)? sendOtp,
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
    TResult Function(String phone)? sendOtp,
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
    required TResult Function(_SendOtp value) sendOtp,
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
    TResult? Function(_SendOtp value)? sendOtp,
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
    TResult Function(_SendOtp value)? sendOtp,
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
    required TResult Function(String phone) sendOtp,
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
    TResult? Function(String phone)? sendOtp,
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
    TResult Function(String phone)? sendOtp,
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
    required TResult Function(_SendOtp value) sendOtp,
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
    TResult? Function(_SendOtp value)? sendOtp,
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
    TResult Function(_SendOtp value)? sendOtp,
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
    required TResult Function(String phone) sendOtp,
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
    TResult? Function(String phone)? sendOtp,
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
    TResult Function(String phone)? sendOtp,
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
    required TResult Function(_SendOtp value) sendOtp,
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
    TResult? Function(_SendOtp value)? sendOtp,
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
    TResult Function(_SendOtp value)? sendOtp,
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
    required TResult Function(String phone) sendOtp,
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
    TResult? Function(String phone)? sendOtp,
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
    TResult Function(String phone)? sendOtp,
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
    required TResult Function(_SendOtp value) sendOtp,
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
    TResult? Function(_SendOtp value)? sendOtp,
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
    TResult Function(_SendOtp value)? sendOtp,
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
