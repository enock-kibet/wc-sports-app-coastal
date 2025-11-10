// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'points.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

PointsData _$PointsDataFromJson(Map<String, dynamic> json) {
  return _PointsData.fromJson(json);
}

/// @nodoc
mixin _$PointsData {
  String get pointid => throw _privateConstructorUsedError;
  String get txType => throw _privateConstructorUsedError;
  @StringOrIntConverter()
  String get actualpoint => throw _privateConstructorUsedError;
  String get action => throw _privateConstructorUsedError;
  String get externalRef => throw _privateConstructorUsedError;
  String get pointtimestamp => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $PointsDataCopyWith<PointsData> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PointsDataCopyWith<$Res> {
  factory $PointsDataCopyWith(
          PointsData value, $Res Function(PointsData) then) =
      _$PointsDataCopyWithImpl<$Res, PointsData>;
  @useResult
  $Res call(
      {String pointid,
      String txType,
      @StringOrIntConverter() String actualpoint,
      String action,
      String externalRef,
      String pointtimestamp});
}

/// @nodoc
class _$PointsDataCopyWithImpl<$Res, $Val extends PointsData>
    implements $PointsDataCopyWith<$Res> {
  _$PointsDataCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? pointid = null,
    Object? txType = null,
    Object? actualpoint = null,
    Object? action = null,
    Object? externalRef = null,
    Object? pointtimestamp = null,
  }) {
    return _then(_value.copyWith(
      pointid: null == pointid
          ? _value.pointid
          : pointid // ignore: cast_nullable_to_non_nullable
              as String,
      txType: null == txType
          ? _value.txType
          : txType // ignore: cast_nullable_to_non_nullable
              as String,
      actualpoint: null == actualpoint
          ? _value.actualpoint
          : actualpoint // ignore: cast_nullable_to_non_nullable
              as String,
      action: null == action
          ? _value.action
          : action // ignore: cast_nullable_to_non_nullable
              as String,
      externalRef: null == externalRef
          ? _value.externalRef
          : externalRef // ignore: cast_nullable_to_non_nullable
              as String,
      pointtimestamp: null == pointtimestamp
          ? _value.pointtimestamp
          : pointtimestamp // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$PointsDataImplCopyWith<$Res>
    implements $PointsDataCopyWith<$Res> {
  factory _$$PointsDataImplCopyWith(
          _$PointsDataImpl value, $Res Function(_$PointsDataImpl) then) =
      __$$PointsDataImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String pointid,
      String txType,
      @StringOrIntConverter() String actualpoint,
      String action,
      String externalRef,
      String pointtimestamp});
}

/// @nodoc
class __$$PointsDataImplCopyWithImpl<$Res>
    extends _$PointsDataCopyWithImpl<$Res, _$PointsDataImpl>
    implements _$$PointsDataImplCopyWith<$Res> {
  __$$PointsDataImplCopyWithImpl(
      _$PointsDataImpl _value, $Res Function(_$PointsDataImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? pointid = null,
    Object? txType = null,
    Object? actualpoint = null,
    Object? action = null,
    Object? externalRef = null,
    Object? pointtimestamp = null,
  }) {
    return _then(_$PointsDataImpl(
      pointid: null == pointid
          ? _value.pointid
          : pointid // ignore: cast_nullable_to_non_nullable
              as String,
      txType: null == txType
          ? _value.txType
          : txType // ignore: cast_nullable_to_non_nullable
              as String,
      actualpoint: null == actualpoint
          ? _value.actualpoint
          : actualpoint // ignore: cast_nullable_to_non_nullable
              as String,
      action: null == action
          ? _value.action
          : action // ignore: cast_nullable_to_non_nullable
              as String,
      externalRef: null == externalRef
          ? _value.externalRef
          : externalRef // ignore: cast_nullable_to_non_nullable
              as String,
      pointtimestamp: null == pointtimestamp
          ? _value.pointtimestamp
          : pointtimestamp // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$PointsDataImpl implements _PointsData {
  const _$PointsDataImpl(
      {required this.pointid,
      required this.txType,
      @StringOrIntConverter() required this.actualpoint,
      required this.action,
      required this.externalRef,
      required this.pointtimestamp});

  factory _$PointsDataImpl.fromJson(Map<String, dynamic> json) =>
      _$$PointsDataImplFromJson(json);

  @override
  final String pointid;
  @override
  final String txType;
  @override
  @StringOrIntConverter()
  final String actualpoint;
  @override
  final String action;
  @override
  final String externalRef;
  @override
  final String pointtimestamp;

  @override
  String toString() {
    return 'PointsData(pointid: $pointid, txType: $txType, actualpoint: $actualpoint, action: $action, externalRef: $externalRef, pointtimestamp: $pointtimestamp)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PointsDataImpl &&
            (identical(other.pointid, pointid) || other.pointid == pointid) &&
            (identical(other.txType, txType) || other.txType == txType) &&
            (identical(other.actualpoint, actualpoint) ||
                other.actualpoint == actualpoint) &&
            (identical(other.action, action) || other.action == action) &&
            (identical(other.externalRef, externalRef) ||
                other.externalRef == externalRef) &&
            (identical(other.pointtimestamp, pointtimestamp) ||
                other.pointtimestamp == pointtimestamp));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, pointid, txType, actualpoint,
      action, externalRef, pointtimestamp);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$PointsDataImplCopyWith<_$PointsDataImpl> get copyWith =>
      __$$PointsDataImplCopyWithImpl<_$PointsDataImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PointsDataImplToJson(
      this,
    );
  }
}

abstract class _PointsData implements PointsData {
  const factory _PointsData(
      {required final String pointid,
      required final String txType,
      @StringOrIntConverter() required final String actualpoint,
      required final String action,
      required final String externalRef,
      required final String pointtimestamp}) = _$PointsDataImpl;

  factory _PointsData.fromJson(Map<String, dynamic> json) =
      _$PointsDataImpl.fromJson;

  @override
  String get pointid;
  @override
  String get txType;
  @override
  @StringOrIntConverter()
  String get actualpoint;
  @override
  String get action;
  @override
  String get externalRef;
  @override
  String get pointtimestamp;
  @override
  @JsonKey(ignore: true)
  _$$PointsDataImplCopyWith<_$PointsDataImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

PointsBalance _$PointsBalanceFromJson(Map<String, dynamic> json) {
  return _PointsBalance.fromJson(json);
}

/// @nodoc
mixin _$PointsBalance {
  String get walletId => throw _privateConstructorUsedError;
  @StringOrIntConverter()
  String get balance => throw _privateConstructorUsedError;
  String get tier => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $PointsBalanceCopyWith<PointsBalance> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PointsBalanceCopyWith<$Res> {
  factory $PointsBalanceCopyWith(
          PointsBalance value, $Res Function(PointsBalance) then) =
      _$PointsBalanceCopyWithImpl<$Res, PointsBalance>;
  @useResult
  $Res call(
      {String walletId, @StringOrIntConverter() String balance, String tier});
}

/// @nodoc
class _$PointsBalanceCopyWithImpl<$Res, $Val extends PointsBalance>
    implements $PointsBalanceCopyWith<$Res> {
  _$PointsBalanceCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? walletId = null,
    Object? balance = null,
    Object? tier = null,
  }) {
    return _then(_value.copyWith(
      walletId: null == walletId
          ? _value.walletId
          : walletId // ignore: cast_nullable_to_non_nullable
              as String,
      balance: null == balance
          ? _value.balance
          : balance // ignore: cast_nullable_to_non_nullable
              as String,
      tier: null == tier
          ? _value.tier
          : tier // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$PointsBalanceImplCopyWith<$Res>
    implements $PointsBalanceCopyWith<$Res> {
  factory _$$PointsBalanceImplCopyWith(
          _$PointsBalanceImpl value, $Res Function(_$PointsBalanceImpl) then) =
      __$$PointsBalanceImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String walletId, @StringOrIntConverter() String balance, String tier});
}

/// @nodoc
class __$$PointsBalanceImplCopyWithImpl<$Res>
    extends _$PointsBalanceCopyWithImpl<$Res, _$PointsBalanceImpl>
    implements _$$PointsBalanceImplCopyWith<$Res> {
  __$$PointsBalanceImplCopyWithImpl(
      _$PointsBalanceImpl _value, $Res Function(_$PointsBalanceImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? walletId = null,
    Object? balance = null,
    Object? tier = null,
  }) {
    return _then(_$PointsBalanceImpl(
      walletId: null == walletId
          ? _value.walletId
          : walletId // ignore: cast_nullable_to_non_nullable
              as String,
      balance: null == balance
          ? _value.balance
          : balance // ignore: cast_nullable_to_non_nullable
              as String,
      tier: null == tier
          ? _value.tier
          : tier // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$PointsBalanceImpl implements _PointsBalance {
  const _$PointsBalanceImpl(
      {required this.walletId,
      @StringOrIntConverter() required this.balance,
      required this.tier});

  factory _$PointsBalanceImpl.fromJson(Map<String, dynamic> json) =>
      _$$PointsBalanceImplFromJson(json);

  @override
  final String walletId;
  @override
  @StringOrIntConverter()
  final String balance;
  @override
  final String tier;

  @override
  String toString() {
    return 'PointsBalance(walletId: $walletId, balance: $balance, tier: $tier)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PointsBalanceImpl &&
            (identical(other.walletId, walletId) ||
                other.walletId == walletId) &&
            (identical(other.balance, balance) || other.balance == balance) &&
            (identical(other.tier, tier) || other.tier == tier));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, walletId, balance, tier);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$PointsBalanceImplCopyWith<_$PointsBalanceImpl> get copyWith =>
      __$$PointsBalanceImplCopyWithImpl<_$PointsBalanceImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PointsBalanceImplToJson(
      this,
    );
  }
}

abstract class _PointsBalance implements PointsBalance {
  const factory _PointsBalance(
      {required final String walletId,
      @StringOrIntConverter() required final String balance,
      required final String tier}) = _$PointsBalanceImpl;

  factory _PointsBalance.fromJson(Map<String, dynamic> json) =
      _$PointsBalanceImpl.fromJson;

  @override
  String get walletId;
  @override
  @StringOrIntConverter()
  String get balance;
  @override
  String get tier;
  @override
  @JsonKey(ignore: true)
  _$$PointsBalanceImplCopyWith<_$PointsBalanceImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
