// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'stripe_checkout.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

StripeCheckout _$StripeCheckoutFromJson(Map<String, dynamic> json) {
  return _StripeCheckout.fromJson(json);
}

/// @nodoc
mixin _$StripeCheckout {
  String get paymentIntent => throw _privateConstructorUsedError;
  String get ephemeralKey => throw _privateConstructorUsedError;
  String get customer => throw _privateConstructorUsedError;
  String get publishableKey => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $StripeCheckoutCopyWith<StripeCheckout> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $StripeCheckoutCopyWith<$Res> {
  factory $StripeCheckoutCopyWith(
          StripeCheckout value, $Res Function(StripeCheckout) then) =
      _$StripeCheckoutCopyWithImpl<$Res, StripeCheckout>;
  @useResult
  $Res call(
      {String paymentIntent,
      String ephemeralKey,
      String customer,
      String publishableKey});
}

/// @nodoc
class _$StripeCheckoutCopyWithImpl<$Res, $Val extends StripeCheckout>
    implements $StripeCheckoutCopyWith<$Res> {
  _$StripeCheckoutCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? paymentIntent = null,
    Object? ephemeralKey = null,
    Object? customer = null,
    Object? publishableKey = null,
  }) {
    return _then(_value.copyWith(
      paymentIntent: null == paymentIntent
          ? _value.paymentIntent
          : paymentIntent // ignore: cast_nullable_to_non_nullable
              as String,
      ephemeralKey: null == ephemeralKey
          ? _value.ephemeralKey
          : ephemeralKey // ignore: cast_nullable_to_non_nullable
              as String,
      customer: null == customer
          ? _value.customer
          : customer // ignore: cast_nullable_to_non_nullable
              as String,
      publishableKey: null == publishableKey
          ? _value.publishableKey
          : publishableKey // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$StripeCheckoutImplCopyWith<$Res>
    implements $StripeCheckoutCopyWith<$Res> {
  factory _$$StripeCheckoutImplCopyWith(_$StripeCheckoutImpl value,
          $Res Function(_$StripeCheckoutImpl) then) =
      __$$StripeCheckoutImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String paymentIntent,
      String ephemeralKey,
      String customer,
      String publishableKey});
}

/// @nodoc
class __$$StripeCheckoutImplCopyWithImpl<$Res>
    extends _$StripeCheckoutCopyWithImpl<$Res, _$StripeCheckoutImpl>
    implements _$$StripeCheckoutImplCopyWith<$Res> {
  __$$StripeCheckoutImplCopyWithImpl(
      _$StripeCheckoutImpl _value, $Res Function(_$StripeCheckoutImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? paymentIntent = null,
    Object? ephemeralKey = null,
    Object? customer = null,
    Object? publishableKey = null,
  }) {
    return _then(_$StripeCheckoutImpl(
      paymentIntent: null == paymentIntent
          ? _value.paymentIntent
          : paymentIntent // ignore: cast_nullable_to_non_nullable
              as String,
      ephemeralKey: null == ephemeralKey
          ? _value.ephemeralKey
          : ephemeralKey // ignore: cast_nullable_to_non_nullable
              as String,
      customer: null == customer
          ? _value.customer
          : customer // ignore: cast_nullable_to_non_nullable
              as String,
      publishableKey: null == publishableKey
          ? _value.publishableKey
          : publishableKey // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$StripeCheckoutImpl implements _StripeCheckout {
  const _$StripeCheckoutImpl(
      {required this.paymentIntent,
      required this.ephemeralKey,
      required this.customer,
      required this.publishableKey});

  factory _$StripeCheckoutImpl.fromJson(Map<String, dynamic> json) =>
      _$$StripeCheckoutImplFromJson(json);

  @override
  final String paymentIntent;
  @override
  final String ephemeralKey;
  @override
  final String customer;
  @override
  final String publishableKey;

  @override
  String toString() {
    return 'StripeCheckout(paymentIntent: $paymentIntent, ephemeralKey: $ephemeralKey, customer: $customer, publishableKey: $publishableKey)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$StripeCheckoutImpl &&
            (identical(other.paymentIntent, paymentIntent) ||
                other.paymentIntent == paymentIntent) &&
            (identical(other.ephemeralKey, ephemeralKey) ||
                other.ephemeralKey == ephemeralKey) &&
            (identical(other.customer, customer) ||
                other.customer == customer) &&
            (identical(other.publishableKey, publishableKey) ||
                other.publishableKey == publishableKey));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, paymentIntent, ephemeralKey, customer, publishableKey);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$StripeCheckoutImplCopyWith<_$StripeCheckoutImpl> get copyWith =>
      __$$StripeCheckoutImplCopyWithImpl<_$StripeCheckoutImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$StripeCheckoutImplToJson(
      this,
    );
  }
}

abstract class _StripeCheckout implements StripeCheckout {
  const factory _StripeCheckout(
      {required final String paymentIntent,
      required final String ephemeralKey,
      required final String customer,
      required final String publishableKey}) = _$StripeCheckoutImpl;

  factory _StripeCheckout.fromJson(Map<String, dynamic> json) =
      _$StripeCheckoutImpl.fromJson;

  @override
  String get paymentIntent;
  @override
  String get ephemeralKey;
  @override
  String get customer;
  @override
  String get publishableKey;
  @override
  @JsonKey(ignore: true)
  _$$StripeCheckoutImplCopyWith<_$StripeCheckoutImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
