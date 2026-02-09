// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'match.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

MatchType _$MatchTypeFromJson(Map<String, dynamic> json) {
  return _MatchType.fromJson(json);
}

/// @nodoc
mixin _$MatchType {
  String get matchId => throw _privateConstructorUsedError;
  String get teamOne => throw _privateConstructorUsedError;
  String get teamTwo => throw _privateConstructorUsedError;
  String get matchName => throw _privateConstructorUsedError;
  String get matchDescription => throw _privateConstructorUsedError;
  DateTime get matchDate => throw _privateConstructorUsedError;
  String get matchVenue => throw _privateConstructorUsedError;
  String get matchLocation => throw _privateConstructorUsedError;
  double get matchPrice => throw _privateConstructorUsedError;
  String? get teamOneScore => throw _privateConstructorUsedError;
  String? get teamTwoScore => throw _privateConstructorUsedError;
  MatchModel? get recap => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $MatchTypeCopyWith<MatchType> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MatchTypeCopyWith<$Res> {
  factory $MatchTypeCopyWith(MatchType value, $Res Function(MatchType) then) =
      _$MatchTypeCopyWithImpl<$Res, MatchType>;
  @useResult
  $Res call(
      {String matchId,
      String teamOne,
      String teamTwo,
      String matchName,
      String matchDescription,
      DateTime matchDate,
      String matchVenue,
      String matchLocation,
      double matchPrice,
      String? teamOneScore,
      String? teamTwoScore,
      MatchModel? recap});

  $MatchModelCopyWith<$Res>? get recap;
}

/// @nodoc
class _$MatchTypeCopyWithImpl<$Res, $Val extends MatchType>
    implements $MatchTypeCopyWith<$Res> {
  _$MatchTypeCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? matchId = null,
    Object? teamOne = null,
    Object? teamTwo = null,
    Object? matchName = null,
    Object? matchDescription = null,
    Object? matchDate = null,
    Object? matchVenue = null,
    Object? matchLocation = null,
    Object? matchPrice = null,
    Object? teamOneScore = freezed,
    Object? teamTwoScore = freezed,
    Object? recap = freezed,
  }) {
    return _then(_value.copyWith(
      matchId: null == matchId
          ? _value.matchId
          : matchId // ignore: cast_nullable_to_non_nullable
              as String,
      teamOne: null == teamOne
          ? _value.teamOne
          : teamOne // ignore: cast_nullable_to_non_nullable
              as String,
      teamTwo: null == teamTwo
          ? _value.teamTwo
          : teamTwo // ignore: cast_nullable_to_non_nullable
              as String,
      matchName: null == matchName
          ? _value.matchName
          : matchName // ignore: cast_nullable_to_non_nullable
              as String,
      matchDescription: null == matchDescription
          ? _value.matchDescription
          : matchDescription // ignore: cast_nullable_to_non_nullable
              as String,
      matchDate: null == matchDate
          ? _value.matchDate
          : matchDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      matchVenue: null == matchVenue
          ? _value.matchVenue
          : matchVenue // ignore: cast_nullable_to_non_nullable
              as String,
      matchLocation: null == matchLocation
          ? _value.matchLocation
          : matchLocation // ignore: cast_nullable_to_non_nullable
              as String,
      matchPrice: null == matchPrice
          ? _value.matchPrice
          : matchPrice // ignore: cast_nullable_to_non_nullable
              as double,
      teamOneScore: freezed == teamOneScore
          ? _value.teamOneScore
          : teamOneScore // ignore: cast_nullable_to_non_nullable
              as String?,
      teamTwoScore: freezed == teamTwoScore
          ? _value.teamTwoScore
          : teamTwoScore // ignore: cast_nullable_to_non_nullable
              as String?,
      recap: freezed == recap
          ? _value.recap
          : recap // ignore: cast_nullable_to_non_nullable
              as MatchModel?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $MatchModelCopyWith<$Res>? get recap {
    if (_value.recap == null) {
      return null;
    }

    return $MatchModelCopyWith<$Res>(_value.recap!, (value) {
      return _then(_value.copyWith(recap: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$MatchTypeImplCopyWith<$Res>
    implements $MatchTypeCopyWith<$Res> {
  factory _$$MatchTypeImplCopyWith(
          _$MatchTypeImpl value, $Res Function(_$MatchTypeImpl) then) =
      __$$MatchTypeImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String matchId,
      String teamOne,
      String teamTwo,
      String matchName,
      String matchDescription,
      DateTime matchDate,
      String matchVenue,
      String matchLocation,
      double matchPrice,
      String? teamOneScore,
      String? teamTwoScore,
      MatchModel? recap});

  @override
  $MatchModelCopyWith<$Res>? get recap;
}

/// @nodoc
class __$$MatchTypeImplCopyWithImpl<$Res>
    extends _$MatchTypeCopyWithImpl<$Res, _$MatchTypeImpl>
    implements _$$MatchTypeImplCopyWith<$Res> {
  __$$MatchTypeImplCopyWithImpl(
      _$MatchTypeImpl _value, $Res Function(_$MatchTypeImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? matchId = null,
    Object? teamOne = null,
    Object? teamTwo = null,
    Object? matchName = null,
    Object? matchDescription = null,
    Object? matchDate = null,
    Object? matchVenue = null,
    Object? matchLocation = null,
    Object? matchPrice = null,
    Object? teamOneScore = freezed,
    Object? teamTwoScore = freezed,
    Object? recap = freezed,
  }) {
    return _then(_$MatchTypeImpl(
      matchId: null == matchId
          ? _value.matchId
          : matchId // ignore: cast_nullable_to_non_nullable
              as String,
      teamOne: null == teamOne
          ? _value.teamOne
          : teamOne // ignore: cast_nullable_to_non_nullable
              as String,
      teamTwo: null == teamTwo
          ? _value.teamTwo
          : teamTwo // ignore: cast_nullable_to_non_nullable
              as String,
      matchName: null == matchName
          ? _value.matchName
          : matchName // ignore: cast_nullable_to_non_nullable
              as String,
      matchDescription: null == matchDescription
          ? _value.matchDescription
          : matchDescription // ignore: cast_nullable_to_non_nullable
              as String,
      matchDate: null == matchDate
          ? _value.matchDate
          : matchDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      matchVenue: null == matchVenue
          ? _value.matchVenue
          : matchVenue // ignore: cast_nullable_to_non_nullable
              as String,
      matchLocation: null == matchLocation
          ? _value.matchLocation
          : matchLocation // ignore: cast_nullable_to_non_nullable
              as String,
      matchPrice: null == matchPrice
          ? _value.matchPrice
          : matchPrice // ignore: cast_nullable_to_non_nullable
              as double,
      teamOneScore: freezed == teamOneScore
          ? _value.teamOneScore
          : teamOneScore // ignore: cast_nullable_to_non_nullable
              as String?,
      teamTwoScore: freezed == teamTwoScore
          ? _value.teamTwoScore
          : teamTwoScore // ignore: cast_nullable_to_non_nullable
              as String?,
      recap: freezed == recap
          ? _value.recap
          : recap // ignore: cast_nullable_to_non_nullable
              as MatchModel?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$MatchTypeImpl implements _MatchType {
  const _$MatchTypeImpl(
      {required this.matchId,
      required this.teamOne,
      required this.teamTwo,
      required this.matchName,
      required this.matchDescription,
      required this.matchDate,
      required this.matchVenue,
      required this.matchLocation,
      required this.matchPrice,
      this.teamOneScore,
      this.teamTwoScore,
      this.recap});

  factory _$MatchTypeImpl.fromJson(Map<String, dynamic> json) =>
      _$$MatchTypeImplFromJson(json);

  @override
  final String matchId;
  @override
  final String teamOne;
  @override
  final String teamTwo;
  @override
  final String matchName;
  @override
  final String matchDescription;
  @override
  final DateTime matchDate;
  @override
  final String matchVenue;
  @override
  final String matchLocation;
  @override
  final double matchPrice;
  @override
  final String? teamOneScore;
  @override
  final String? teamTwoScore;
  @override
  final MatchModel? recap;

  @override
  String toString() {
    return 'MatchType(matchId: $matchId, teamOne: $teamOne, teamTwo: $teamTwo, matchName: $matchName, matchDescription: $matchDescription, matchDate: $matchDate, matchVenue: $matchVenue, matchLocation: $matchLocation, matchPrice: $matchPrice, teamOneScore: $teamOneScore, teamTwoScore: $teamTwoScore, recap: $recap)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MatchTypeImpl &&
            (identical(other.matchId, matchId) || other.matchId == matchId) &&
            (identical(other.teamOne, teamOne) || other.teamOne == teamOne) &&
            (identical(other.teamTwo, teamTwo) || other.teamTwo == teamTwo) &&
            (identical(other.matchName, matchName) ||
                other.matchName == matchName) &&
            (identical(other.matchDescription, matchDescription) ||
                other.matchDescription == matchDescription) &&
            (identical(other.matchDate, matchDate) ||
                other.matchDate == matchDate) &&
            (identical(other.matchVenue, matchVenue) ||
                other.matchVenue == matchVenue) &&
            (identical(other.matchLocation, matchLocation) ||
                other.matchLocation == matchLocation) &&
            (identical(other.matchPrice, matchPrice) ||
                other.matchPrice == matchPrice) &&
            (identical(other.teamOneScore, teamOneScore) ||
                other.teamOneScore == teamOneScore) &&
            (identical(other.teamTwoScore, teamTwoScore) ||
                other.teamTwoScore == teamTwoScore) &&
            (identical(other.recap, recap) || other.recap == recap));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      matchId,
      teamOne,
      teamTwo,
      matchName,
      matchDescription,
      matchDate,
      matchVenue,
      matchLocation,
      matchPrice,
      teamOneScore,
      teamTwoScore,
      recap);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$MatchTypeImplCopyWith<_$MatchTypeImpl> get copyWith =>
      __$$MatchTypeImplCopyWithImpl<_$MatchTypeImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$MatchTypeImplToJson(
      this,
    );
  }
}

abstract class _MatchType implements MatchType {
  const factory _MatchType(
      {required final String matchId,
      required final String teamOne,
      required final String teamTwo,
      required final String matchName,
      required final String matchDescription,
      required final DateTime matchDate,
      required final String matchVenue,
      required final String matchLocation,
      required final double matchPrice,
      final String? teamOneScore,
      final String? teamTwoScore,
      final MatchModel? recap}) = _$MatchTypeImpl;

  factory _MatchType.fromJson(Map<String, dynamic> json) =
      _$MatchTypeImpl.fromJson;

  @override
  String get matchId;
  @override
  String get teamOne;
  @override
  String get teamTwo;
  @override
  String get matchName;
  @override
  String get matchDescription;
  @override
  DateTime get matchDate;
  @override
  String get matchVenue;
  @override
  String get matchLocation;
  @override
  double get matchPrice;
  @override
  String? get teamOneScore;
  @override
  String? get teamTwoScore;
  @override
  MatchModel? get recap;
  @override
  @JsonKey(ignore: true)
  _$$MatchTypeImplCopyWith<_$MatchTypeImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
