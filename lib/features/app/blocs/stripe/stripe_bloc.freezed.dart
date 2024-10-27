// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'stripe_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$StripeEvent {
  String get email => throw _privateConstructorUsedError;
  int get price => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String email, int price) stripe,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String email, int price)? stripe,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String email, int price)? stripe,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_StripeFetched value) stripe,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_StripeFetched value)? stripe,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_StripeFetched value)? stripe,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $StripeEventCopyWith<StripeEvent> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $StripeEventCopyWith<$Res> {
  factory $StripeEventCopyWith(
          StripeEvent value, $Res Function(StripeEvent) then) =
      _$StripeEventCopyWithImpl<$Res, StripeEvent>;
  @useResult
  $Res call({String email, int price});
}

/// @nodoc
class _$StripeEventCopyWithImpl<$Res, $Val extends StripeEvent>
    implements $StripeEventCopyWith<$Res> {
  _$StripeEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? email = null,
    Object? price = null,
  }) {
    return _then(_value.copyWith(
      email: null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      price: null == price
          ? _value.price
          : price // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$StripeFetchedImplCopyWith<$Res>
    implements $StripeEventCopyWith<$Res> {
  factory _$$StripeFetchedImplCopyWith(
          _$StripeFetchedImpl value, $Res Function(_$StripeFetchedImpl) then) =
      __$$StripeFetchedImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String email, int price});
}

/// @nodoc
class __$$StripeFetchedImplCopyWithImpl<$Res>
    extends _$StripeEventCopyWithImpl<$Res, _$StripeFetchedImpl>
    implements _$$StripeFetchedImplCopyWith<$Res> {
  __$$StripeFetchedImplCopyWithImpl(
      _$StripeFetchedImpl _value, $Res Function(_$StripeFetchedImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? email = null,
    Object? price = null,
  }) {
    return _then(_$StripeFetchedImpl(
      email: null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      price: null == price
          ? _value.price
          : price // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

class _$StripeFetchedImpl implements _StripeFetched {
  const _$StripeFetchedImpl({required this.email, required this.price});

  @override
  final String email;
  @override
  final int price;

  @override
  String toString() {
    return 'StripeEvent.stripe(email: $email, price: $price)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$StripeFetchedImpl &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.price, price) || other.price == price));
  }

  @override
  int get hashCode => Object.hash(runtimeType, email, price);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$StripeFetchedImplCopyWith<_$StripeFetchedImpl> get copyWith =>
      __$$StripeFetchedImplCopyWithImpl<_$StripeFetchedImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String email, int price) stripe,
  }) {
    return stripe(email, price);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String email, int price)? stripe,
  }) {
    return stripe?.call(email, price);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String email, int price)? stripe,
    required TResult orElse(),
  }) {
    if (stripe != null) {
      return stripe(email, price);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_StripeFetched value) stripe,
  }) {
    return stripe(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_StripeFetched value)? stripe,
  }) {
    return stripe?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_StripeFetched value)? stripe,
    required TResult orElse(),
  }) {
    if (stripe != null) {
      return stripe(this);
    }
    return orElse();
  }
}

abstract class _StripeFetched implements StripeEvent {
  const factory _StripeFetched(
      {required final String email,
      required final int price}) = _$StripeFetchedImpl;

  @override
  String get email;
  @override
  int get price;
  @override
  @JsonKey(ignore: true)
  _$$StripeFetchedImplCopyWith<_$StripeFetchedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$StripeState {
  StripeStatus get status => throw _privateConstructorUsedError;
  Failure? get failure => throw _privateConstructorUsedError;
  Map<String, dynamic>? get stripe => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $StripeStateCopyWith<StripeState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $StripeStateCopyWith<$Res> {
  factory $StripeStateCopyWith(
          StripeState value, $Res Function(StripeState) then) =
      _$StripeStateCopyWithImpl<$Res, StripeState>;
  @useResult
  $Res call(
      {StripeStatus status, Failure? failure, Map<String, dynamic>? stripe});
}

/// @nodoc
class _$StripeStateCopyWithImpl<$Res, $Val extends StripeState>
    implements $StripeStateCopyWith<$Res> {
  _$StripeStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? failure = freezed,
    Object? stripe = freezed,
  }) {
    return _then(_value.copyWith(
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as StripeStatus,
      failure: freezed == failure
          ? _value.failure
          : failure // ignore: cast_nullable_to_non_nullable
              as Failure?,
      stripe: freezed == stripe
          ? _value.stripe
          : stripe // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$StripeStateImplCopyWith<$Res>
    implements $StripeStateCopyWith<$Res> {
  factory _$$StripeStateImplCopyWith(
          _$StripeStateImpl value, $Res Function(_$StripeStateImpl) then) =
      __$$StripeStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {StripeStatus status, Failure? failure, Map<String, dynamic>? stripe});
}

/// @nodoc
class __$$StripeStateImplCopyWithImpl<$Res>
    extends _$StripeStateCopyWithImpl<$Res, _$StripeStateImpl>
    implements _$$StripeStateImplCopyWith<$Res> {
  __$$StripeStateImplCopyWithImpl(
      _$StripeStateImpl _value, $Res Function(_$StripeStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? failure = freezed,
    Object? stripe = freezed,
  }) {
    return _then(_$StripeStateImpl(
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as StripeStatus,
      failure: freezed == failure
          ? _value.failure
          : failure // ignore: cast_nullable_to_non_nullable
              as Failure?,
      stripe: freezed == stripe
          ? _value._stripe
          : stripe // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
    ));
  }
}

/// @nodoc

class _$StripeStateImpl implements _StripeState {
  const _$StripeStateImpl(
      {this.status = StripeStatus.initial,
      this.failure,
      final Map<String, dynamic>? stripe})
      : _stripe = stripe;

  @override
  @JsonKey()
  final StripeStatus status;
  @override
  final Failure? failure;
  final Map<String, dynamic>? _stripe;
  @override
  Map<String, dynamic>? get stripe {
    final value = _stripe;
    if (value == null) return null;
    if (_stripe is EqualUnmodifiableMapView) return _stripe;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

  @override
  String toString() {
    return 'StripeState(status: $status, failure: $failure, stripe: $stripe)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$StripeStateImpl &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.failure, failure) || other.failure == failure) &&
            const DeepCollectionEquality().equals(other._stripe, _stripe));
  }

  @override
  int get hashCode => Object.hash(runtimeType, status, failure,
      const DeepCollectionEquality().hash(_stripe));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$StripeStateImplCopyWith<_$StripeStateImpl> get copyWith =>
      __$$StripeStateImplCopyWithImpl<_$StripeStateImpl>(this, _$identity);
}

abstract class _StripeState implements StripeState {
  const factory _StripeState(
      {final StripeStatus status,
      final Failure? failure,
      final Map<String, dynamic>? stripe}) = _$StripeStateImpl;

  @override
  StripeStatus get status;
  @override
  Failure? get failure;
  @override
  Map<String, dynamic>? get stripe;
  @override
  @JsonKey(ignore: true)
  _$$StripeStateImplCopyWith<_$StripeStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
