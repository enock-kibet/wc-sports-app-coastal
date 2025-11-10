// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'teamstats.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

TeamStatsResponse _$TeamStatsResponseFromJson(Map<String, dynamic> json) {
  return _TeamStatsResponse.fromJson(json);
}

/// @nodoc
mixin _$TeamStatsResponse {
  List<TeamStatsData> get data => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $TeamStatsResponseCopyWith<TeamStatsResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TeamStatsResponseCopyWith<$Res> {
  factory $TeamStatsResponseCopyWith(
          TeamStatsResponse value, $Res Function(TeamStatsResponse) then) =
      _$TeamStatsResponseCopyWithImpl<$Res, TeamStatsResponse>;
  @useResult
  $Res call({List<TeamStatsData> data});
}

/// @nodoc
class _$TeamStatsResponseCopyWithImpl<$Res, $Val extends TeamStatsResponse>
    implements $TeamStatsResponseCopyWith<$Res> {
  _$TeamStatsResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? data = null,
  }) {
    return _then(_value.copyWith(
      data: null == data
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as List<TeamStatsData>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$TeamStatsResponseImplCopyWith<$Res>
    implements $TeamStatsResponseCopyWith<$Res> {
  factory _$$TeamStatsResponseImplCopyWith(_$TeamStatsResponseImpl value,
          $Res Function(_$TeamStatsResponseImpl) then) =
      __$$TeamStatsResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<TeamStatsData> data});
}

/// @nodoc
class __$$TeamStatsResponseImplCopyWithImpl<$Res>
    extends _$TeamStatsResponseCopyWithImpl<$Res, _$TeamStatsResponseImpl>
    implements _$$TeamStatsResponseImplCopyWith<$Res> {
  __$$TeamStatsResponseImplCopyWithImpl(_$TeamStatsResponseImpl _value,
      $Res Function(_$TeamStatsResponseImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? data = null,
  }) {
    return _then(_$TeamStatsResponseImpl(
      data: null == data
          ? _value._data
          : data // ignore: cast_nullable_to_non_nullable
              as List<TeamStatsData>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$TeamStatsResponseImpl implements _TeamStatsResponse {
  const _$TeamStatsResponseImpl({required final List<TeamStatsData> data})
      : _data = data;

  factory _$TeamStatsResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$TeamStatsResponseImplFromJson(json);

  final List<TeamStatsData> _data;
  @override
  List<TeamStatsData> get data {
    if (_data is EqualUnmodifiableListView) return _data;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_data);
  }

  @override
  String toString() {
    return 'TeamStatsResponse(data: $data)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TeamStatsResponseImpl &&
            const DeepCollectionEquality().equals(other._data, _data));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_data));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$TeamStatsResponseImplCopyWith<_$TeamStatsResponseImpl> get copyWith =>
      __$$TeamStatsResponseImplCopyWithImpl<_$TeamStatsResponseImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TeamStatsResponseImplToJson(
      this,
    );
  }
}

abstract class _TeamStatsResponse implements TeamStatsResponse {
  const factory _TeamStatsResponse({required final List<TeamStatsData> data}) =
      _$TeamStatsResponseImpl;

  factory _TeamStatsResponse.fromJson(Map<String, dynamic> json) =
      _$TeamStatsResponseImpl.fromJson;

  @override
  List<TeamStatsData> get data;
  @override
  @JsonKey(ignore: true)
  _$$TeamStatsResponseImplCopyWith<_$TeamStatsResponseImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

TeamStatsData _$TeamStatsDataFromJson(Map<String, dynamic> json) {
  return _TeamStatsData.fromJson(json);
}

/// @nodoc
mixin _$TeamStatsData {
  String get teamId => throw _privateConstructorUsedError;
  String get teamName => throw _privateConstructorUsedError;
  int get wins => throw _privateConstructorUsedError;
  int get losses => throw _privateConstructorUsedError;
  int get draws => throw _privateConstructorUsedError;
  int get points => throw _privateConstructorUsedError;
  int get gamesPlayed => throw _privateConstructorUsedError;
  int get pointsScored => throw _privateConstructorUsedError;
  int get pointsAgainst => throw _privateConstructorUsedError;
  String get season => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $TeamStatsDataCopyWith<TeamStatsData> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TeamStatsDataCopyWith<$Res> {
  factory $TeamStatsDataCopyWith(
          TeamStatsData value, $Res Function(TeamStatsData) then) =
      _$TeamStatsDataCopyWithImpl<$Res, TeamStatsData>;
  @useResult
  $Res call(
      {String teamId,
      String teamName,
      int wins,
      int losses,
      int draws,
      int points,
      int gamesPlayed,
      int pointsScored,
      int pointsAgainst,
      String season});
}

/// @nodoc
class _$TeamStatsDataCopyWithImpl<$Res, $Val extends TeamStatsData>
    implements $TeamStatsDataCopyWith<$Res> {
  _$TeamStatsDataCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? teamId = null,
    Object? teamName = null,
    Object? wins = null,
    Object? losses = null,
    Object? draws = null,
    Object? points = null,
    Object? gamesPlayed = null,
    Object? pointsScored = null,
    Object? pointsAgainst = null,
    Object? season = null,
  }) {
    return _then(_value.copyWith(
      teamId: null == teamId
          ? _value.teamId
          : teamId // ignore: cast_nullable_to_non_nullable
              as String,
      teamName: null == teamName
          ? _value.teamName
          : teamName // ignore: cast_nullable_to_non_nullable
              as String,
      wins: null == wins
          ? _value.wins
          : wins // ignore: cast_nullable_to_non_nullable
              as int,
      losses: null == losses
          ? _value.losses
          : losses // ignore: cast_nullable_to_non_nullable
              as int,
      draws: null == draws
          ? _value.draws
          : draws // ignore: cast_nullable_to_non_nullable
              as int,
      points: null == points
          ? _value.points
          : points // ignore: cast_nullable_to_non_nullable
              as int,
      gamesPlayed: null == gamesPlayed
          ? _value.gamesPlayed
          : gamesPlayed // ignore: cast_nullable_to_non_nullable
              as int,
      pointsScored: null == pointsScored
          ? _value.pointsScored
          : pointsScored // ignore: cast_nullable_to_non_nullable
              as int,
      pointsAgainst: null == pointsAgainst
          ? _value.pointsAgainst
          : pointsAgainst // ignore: cast_nullable_to_non_nullable
              as int,
      season: null == season
          ? _value.season
          : season // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$TeamStatsDataImplCopyWith<$Res>
    implements $TeamStatsDataCopyWith<$Res> {
  factory _$$TeamStatsDataImplCopyWith(
          _$TeamStatsDataImpl value, $Res Function(_$TeamStatsDataImpl) then) =
      __$$TeamStatsDataImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String teamId,
      String teamName,
      int wins,
      int losses,
      int draws,
      int points,
      int gamesPlayed,
      int pointsScored,
      int pointsAgainst,
      String season});
}

/// @nodoc
class __$$TeamStatsDataImplCopyWithImpl<$Res>
    extends _$TeamStatsDataCopyWithImpl<$Res, _$TeamStatsDataImpl>
    implements _$$TeamStatsDataImplCopyWith<$Res> {
  __$$TeamStatsDataImplCopyWithImpl(
      _$TeamStatsDataImpl _value, $Res Function(_$TeamStatsDataImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? teamId = null,
    Object? teamName = null,
    Object? wins = null,
    Object? losses = null,
    Object? draws = null,
    Object? points = null,
    Object? gamesPlayed = null,
    Object? pointsScored = null,
    Object? pointsAgainst = null,
    Object? season = null,
  }) {
    return _then(_$TeamStatsDataImpl(
      teamId: null == teamId
          ? _value.teamId
          : teamId // ignore: cast_nullable_to_non_nullable
              as String,
      teamName: null == teamName
          ? _value.teamName
          : teamName // ignore: cast_nullable_to_non_nullable
              as String,
      wins: null == wins
          ? _value.wins
          : wins // ignore: cast_nullable_to_non_nullable
              as int,
      losses: null == losses
          ? _value.losses
          : losses // ignore: cast_nullable_to_non_nullable
              as int,
      draws: null == draws
          ? _value.draws
          : draws // ignore: cast_nullable_to_non_nullable
              as int,
      points: null == points
          ? _value.points
          : points // ignore: cast_nullable_to_non_nullable
              as int,
      gamesPlayed: null == gamesPlayed
          ? _value.gamesPlayed
          : gamesPlayed // ignore: cast_nullable_to_non_nullable
              as int,
      pointsScored: null == pointsScored
          ? _value.pointsScored
          : pointsScored // ignore: cast_nullable_to_non_nullable
              as int,
      pointsAgainst: null == pointsAgainst
          ? _value.pointsAgainst
          : pointsAgainst // ignore: cast_nullable_to_non_nullable
              as int,
      season: null == season
          ? _value.season
          : season // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$TeamStatsDataImpl implements _TeamStatsData {
  const _$TeamStatsDataImpl(
      {required this.teamId,
      required this.teamName,
      required this.wins,
      required this.losses,
      required this.draws,
      required this.points,
      required this.gamesPlayed,
      required this.pointsScored,
      required this.pointsAgainst,
      required this.season});

  factory _$TeamStatsDataImpl.fromJson(Map<String, dynamic> json) =>
      _$$TeamStatsDataImplFromJson(json);

  @override
  final String teamId;
  @override
  final String teamName;
  @override
  final int wins;
  @override
  final int losses;
  @override
  final int draws;
  @override
  final int points;
  @override
  final int gamesPlayed;
  @override
  final int pointsScored;
  @override
  final int pointsAgainst;
  @override
  final String season;

  @override
  String toString() {
    return 'TeamStatsData(teamId: $teamId, teamName: $teamName, wins: $wins, losses: $losses, draws: $draws, points: $points, gamesPlayed: $gamesPlayed, pointsScored: $pointsScored, pointsAgainst: $pointsAgainst, season: $season)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TeamStatsDataImpl &&
            (identical(other.teamId, teamId) || other.teamId == teamId) &&
            (identical(other.teamName, teamName) ||
                other.teamName == teamName) &&
            (identical(other.wins, wins) || other.wins == wins) &&
            (identical(other.losses, losses) || other.losses == losses) &&
            (identical(other.draws, draws) || other.draws == draws) &&
            (identical(other.points, points) || other.points == points) &&
            (identical(other.gamesPlayed, gamesPlayed) ||
                other.gamesPlayed == gamesPlayed) &&
            (identical(other.pointsScored, pointsScored) ||
                other.pointsScored == pointsScored) &&
            (identical(other.pointsAgainst, pointsAgainst) ||
                other.pointsAgainst == pointsAgainst) &&
            (identical(other.season, season) || other.season == season));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, teamId, teamName, wins, losses,
      draws, points, gamesPlayed, pointsScored, pointsAgainst, season);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$TeamStatsDataImplCopyWith<_$TeamStatsDataImpl> get copyWith =>
      __$$TeamStatsDataImplCopyWithImpl<_$TeamStatsDataImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TeamStatsDataImplToJson(
      this,
    );
  }
}

abstract class _TeamStatsData implements TeamStatsData {
  const factory _TeamStatsData(
      {required final String teamId,
      required final String teamName,
      required final int wins,
      required final int losses,
      required final int draws,
      required final int points,
      required final int gamesPlayed,
      required final int pointsScored,
      required final int pointsAgainst,
      required final String season}) = _$TeamStatsDataImpl;

  factory _TeamStatsData.fromJson(Map<String, dynamic> json) =
      _$TeamStatsDataImpl.fromJson;

  @override
  String get teamId;
  @override
  String get teamName;
  @override
  int get wins;
  @override
  int get losses;
  @override
  int get draws;
  @override
  int get points;
  @override
  int get gamesPlayed;
  @override
  int get pointsScored;
  @override
  int get pointsAgainst;
  @override
  String get season;
  @override
  @JsonKey(ignore: true)
  _$$TeamStatsDataImplCopyWith<_$TeamStatsDataImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
