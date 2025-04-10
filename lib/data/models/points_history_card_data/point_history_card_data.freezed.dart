// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'point_history_card_data.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

PointHistoryCardData _$PointHistoryCardDataFromJson(Map<String, dynamic> json) {
  return _PointHistoryCardData.fromJson(json);
}

/// @nodoc
mixin _$PointHistoryCardData {
  PointCardType get type => throw _privateConstructorUsedError;
  DateTime get date => throw _privateConstructorUsedError;
  int get tickets => throw _privateConstructorUsedError;
  int get amount => throw _privateConstructorUsedError;
  int get points => throw _privateConstructorUsedError;
  String? get prize => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $PointHistoryCardDataCopyWith<PointHistoryCardData> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PointHistoryCardDataCopyWith<$Res> {
  factory $PointHistoryCardDataCopyWith(PointHistoryCardData value,
          $Res Function(PointHistoryCardData) then) =
      _$PointHistoryCardDataCopyWithImpl<$Res, PointHistoryCardData>;
  @useResult
  $Res call(
      {PointCardType type,
      DateTime date,
      int tickets,
      int amount,
      int points,
      String? prize});
}

/// @nodoc
class _$PointHistoryCardDataCopyWithImpl<$Res,
        $Val extends PointHistoryCardData>
    implements $PointHistoryCardDataCopyWith<$Res> {
  _$PointHistoryCardDataCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? type = null,
    Object? date = null,
    Object? tickets = null,
    Object? amount = null,
    Object? points = null,
    Object? prize = freezed,
  }) {
    return _then(_value.copyWith(
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as PointCardType,
      date: null == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as DateTime,
      tickets: null == tickets
          ? _value.tickets
          : tickets // ignore: cast_nullable_to_non_nullable
              as int,
      amount: null == amount
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as int,
      points: null == points
          ? _value.points
          : points // ignore: cast_nullable_to_non_nullable
              as int,
      prize: freezed == prize
          ? _value.prize
          : prize // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$PointHistoryCardDataImplCopyWith<$Res>
    implements $PointHistoryCardDataCopyWith<$Res> {
  factory _$$PointHistoryCardDataImplCopyWith(_$PointHistoryCardDataImpl value,
          $Res Function(_$PointHistoryCardDataImpl) then) =
      __$$PointHistoryCardDataImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {PointCardType type,
      DateTime date,
      int tickets,
      int amount,
      int points,
      String? prize});
}

/// @nodoc
class __$$PointHistoryCardDataImplCopyWithImpl<$Res>
    extends _$PointHistoryCardDataCopyWithImpl<$Res, _$PointHistoryCardDataImpl>
    implements _$$PointHistoryCardDataImplCopyWith<$Res> {
  __$$PointHistoryCardDataImplCopyWithImpl(_$PointHistoryCardDataImpl _value,
      $Res Function(_$PointHistoryCardDataImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? type = null,
    Object? date = null,
    Object? tickets = null,
    Object? amount = null,
    Object? points = null,
    Object? prize = freezed,
  }) {
    return _then(_$PointHistoryCardDataImpl(
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as PointCardType,
      date: null == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as DateTime,
      tickets: null == tickets
          ? _value.tickets
          : tickets // ignore: cast_nullable_to_non_nullable
              as int,
      amount: null == amount
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as int,
      points: null == points
          ? _value.points
          : points // ignore: cast_nullable_to_non_nullable
              as int,
      prize: freezed == prize
          ? _value.prize
          : prize // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$PointHistoryCardDataImpl implements _PointHistoryCardData {
  const _$PointHistoryCardDataImpl(
      {required this.type,
      required this.date,
      this.tickets = 1,
      this.amount = 700,
      this.points = 2,
      this.prize});

  factory _$PointHistoryCardDataImpl.fromJson(Map<String, dynamic> json) =>
      _$$PointHistoryCardDataImplFromJson(json);

  @override
  final PointCardType type;
  @override
  final DateTime date;
  @override
  @JsonKey()
  final int tickets;
  @override
  @JsonKey()
  final int amount;
  @override
  @JsonKey()
  final int points;
  @override
  final String? prize;

  @override
  String toString() {
    return 'PointHistoryCardData(type: $type, date: $date, tickets: $tickets, amount: $amount, points: $points, prize: $prize)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PointHistoryCardDataImpl &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.date, date) || other.date == date) &&
            (identical(other.tickets, tickets) || other.tickets == tickets) &&
            (identical(other.amount, amount) || other.amount == amount) &&
            (identical(other.points, points) || other.points == points) &&
            (identical(other.prize, prize) || other.prize == prize));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, type, date, tickets, amount, points, prize);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$PointHistoryCardDataImplCopyWith<_$PointHistoryCardDataImpl>
      get copyWith =>
          __$$PointHistoryCardDataImplCopyWithImpl<_$PointHistoryCardDataImpl>(
              this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PointHistoryCardDataImplToJson(
      this,
    );
  }
}

abstract class _PointHistoryCardData implements PointHistoryCardData {
  const factory _PointHistoryCardData(
      {required final PointCardType type,
      required final DateTime date,
      final int tickets,
      final int amount,
      final int points,
      final String? prize}) = _$PointHistoryCardDataImpl;

  factory _PointHistoryCardData.fromJson(Map<String, dynamic> json) =
      _$PointHistoryCardDataImpl.fromJson;

  @override
  PointCardType get type;
  @override
  DateTime get date;
  @override
  int get tickets;
  @override
  int get amount;
  @override
  int get points;
  @override
  String? get prize;
  @override
  @JsonKey(ignore: true)
  _$$PointHistoryCardDataImplCopyWith<_$PointHistoryCardDataImpl>
      get copyWith => throw _privateConstructorUsedError;
}
