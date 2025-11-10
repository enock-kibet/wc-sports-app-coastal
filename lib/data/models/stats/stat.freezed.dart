// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'stat.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

Stats _$StatsFromJson(Map<String, dynamic> json) {
  return _Stats.fromJson(json);
}

/// @nodoc
mixin _$Stats {
  int get rank => throw _privateConstructorUsedError;
  String get playerId => throw _privateConstructorUsedError;
  String get playerName => throw _privateConstructorUsedError;
  String get clubId => throw _privateConstructorUsedError;
  String get clubname => throw _privateConstructorUsedError;
  String get seasonId => throw _privateConstructorUsedError;
  int get avg => throw _privateConstructorUsedError;
  int get games => throw _privateConstructorUsedError;
  String? get imageUrl => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $StatsCopyWith<Stats> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $StatsCopyWith<$Res> {
  factory $StatsCopyWith(Stats value, $Res Function(Stats) then) =
      _$StatsCopyWithImpl<$Res, Stats>;
  @useResult
  $Res call(
      {int rank,
      String playerId,
      String playerName,
      String clubId,
      String clubname,
      String seasonId,
      int avg,
      int games,
      String? imageUrl});
}

/// @nodoc
class _$StatsCopyWithImpl<$Res, $Val extends Stats>
    implements $StatsCopyWith<$Res> {
  _$StatsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? rank = null,
    Object? playerId = null,
    Object? playerName = null,
    Object? clubId = null,
    Object? clubname = null,
    Object? seasonId = null,
    Object? avg = null,
    Object? games = null,
    Object? imageUrl = freezed,
  }) {
    return _then(_value.copyWith(
      rank: null == rank
          ? _value.rank
          : rank // ignore: cast_nullable_to_non_nullable
              as int,
      playerId: null == playerId
          ? _value.playerId
          : playerId // ignore: cast_nullable_to_non_nullable
              as String,
      playerName: null == playerName
          ? _value.playerName
          : playerName // ignore: cast_nullable_to_non_nullable
              as String,
      clubId: null == clubId
          ? _value.clubId
          : clubId // ignore: cast_nullable_to_non_nullable
              as String,
      clubname: null == clubname
          ? _value.clubname
          : clubname // ignore: cast_nullable_to_non_nullable
              as String,
      seasonId: null == seasonId
          ? _value.seasonId
          : seasonId // ignore: cast_nullable_to_non_nullable
              as String,
      avg: null == avg
          ? _value.avg
          : avg // ignore: cast_nullable_to_non_nullable
              as int,
      games: null == games
          ? _value.games
          : games // ignore: cast_nullable_to_non_nullable
              as int,
      imageUrl: freezed == imageUrl
          ? _value.imageUrl
          : imageUrl // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$StatsImplCopyWith<$Res> implements $StatsCopyWith<$Res> {
  factory _$$StatsImplCopyWith(
          _$StatsImpl value, $Res Function(_$StatsImpl) then) =
      __$$StatsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int rank,
      String playerId,
      String playerName,
      String clubId,
      String clubname,
      String seasonId,
      int avg,
      int games,
      String? imageUrl});
}

/// @nodoc
class __$$StatsImplCopyWithImpl<$Res>
    extends _$StatsCopyWithImpl<$Res, _$StatsImpl>
    implements _$$StatsImplCopyWith<$Res> {
  __$$StatsImplCopyWithImpl(
      _$StatsImpl _value, $Res Function(_$StatsImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? rank = null,
    Object? playerId = null,
    Object? playerName = null,
    Object? clubId = null,
    Object? clubname = null,
    Object? seasonId = null,
    Object? avg = null,
    Object? games = null,
    Object? imageUrl = freezed,
  }) {
    return _then(_$StatsImpl(
      rank: null == rank
          ? _value.rank
          : rank // ignore: cast_nullable_to_non_nullable
              as int,
      playerId: null == playerId
          ? _value.playerId
          : playerId // ignore: cast_nullable_to_non_nullable
              as String,
      playerName: null == playerName
          ? _value.playerName
          : playerName // ignore: cast_nullable_to_non_nullable
              as String,
      clubId: null == clubId
          ? _value.clubId
          : clubId // ignore: cast_nullable_to_non_nullable
              as String,
      clubname: null == clubname
          ? _value.clubname
          : clubname // ignore: cast_nullable_to_non_nullable
              as String,
      seasonId: null == seasonId
          ? _value.seasonId
          : seasonId // ignore: cast_nullable_to_non_nullable
              as String,
      avg: null == avg
          ? _value.avg
          : avg // ignore: cast_nullable_to_non_nullable
              as int,
      games: null == games
          ? _value.games
          : games // ignore: cast_nullable_to_non_nullable
              as int,
      imageUrl: freezed == imageUrl
          ? _value.imageUrl
          : imageUrl // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$StatsImpl implements _Stats {
  const _$StatsImpl(
      {required this.rank,
      required this.playerId,
      required this.playerName,
      required this.clubId,
      required this.clubname,
      required this.seasonId,
      required this.avg,
      required this.games,
      this.imageUrl});

  factory _$StatsImpl.fromJson(Map<String, dynamic> json) =>
      _$$StatsImplFromJson(json);

  @override
  final int rank;
  @override
  final String playerId;
  @override
  final String playerName;
  @override
  final String clubId;
  @override
  final String clubname;
  @override
  final String seasonId;
  @override
  final int avg;
  @override
  final int games;
  @override
  final String? imageUrl;

  @override
  String toString() {
    return 'Stats(rank: $rank, playerId: $playerId, playerName: $playerName, clubId: $clubId, clubname: $clubname, seasonId: $seasonId, avg: $avg, games: $games, imageUrl: $imageUrl)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$StatsImpl &&
            (identical(other.rank, rank) || other.rank == rank) &&
            (identical(other.playerId, playerId) ||
                other.playerId == playerId) &&
            (identical(other.playerName, playerName) ||
                other.playerName == playerName) &&
            (identical(other.clubId, clubId) || other.clubId == clubId) &&
            (identical(other.clubname, clubname) ||
                other.clubname == clubname) &&
            (identical(other.seasonId, seasonId) ||
                other.seasonId == seasonId) &&
            (identical(other.avg, avg) || other.avg == avg) &&
            (identical(other.games, games) || other.games == games) &&
            (identical(other.imageUrl, imageUrl) ||
                other.imageUrl == imageUrl));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, rank, playerId, playerName,
      clubId, clubname, seasonId, avg, games, imageUrl);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$StatsImplCopyWith<_$StatsImpl> get copyWith =>
      __$$StatsImplCopyWithImpl<_$StatsImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$StatsImplToJson(
      this,
    );
  }
}

abstract class _Stats implements Stats {
  const factory _Stats(
      {required final int rank,
      required final String playerId,
      required final String playerName,
      required final String clubId,
      required final String clubname,
      required final String seasonId,
      required final int avg,
      required final int games,
      final String? imageUrl}) = _$StatsImpl;

  factory _Stats.fromJson(Map<String, dynamic> json) = _$StatsImpl.fromJson;

  @override
  int get rank;
  @override
  String get playerId;
  @override
  String get playerName;
  @override
  String get clubId;
  @override
  String get clubname;
  @override
  String get seasonId;
  @override
  int get avg;
  @override
  int get games;
  @override
  String? get imageUrl;
  @override
  @JsonKey(ignore: true)
  _$$StatsImplCopyWith<_$StatsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

StatCategoryResponse _$StatCategoryResponseFromJson(Map<String, dynamic> json) {
  return _StatCategoryResponse.fromJson(json);
}

/// @nodoc
mixin _$StatCategoryResponse {
  @JsonKey(name: 'Field Goal')
  List<Stats> get fieldGoal => throw _privateConstructorUsedError;
  @JsonKey(name: 'Free Throw')
  List<Stats> get freeThrow => throw _privateConstructorUsedError;
  @JsonKey(name: 'Rebounds')
  List<Stats> get rebounds => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $StatCategoryResponseCopyWith<StatCategoryResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $StatCategoryResponseCopyWith<$Res> {
  factory $StatCategoryResponseCopyWith(StatCategoryResponse value,
          $Res Function(StatCategoryResponse) then) =
      _$StatCategoryResponseCopyWithImpl<$Res, StatCategoryResponse>;
  @useResult
  $Res call(
      {@JsonKey(name: 'Field Goal') List<Stats> fieldGoal,
      @JsonKey(name: 'Free Throw') List<Stats> freeThrow,
      @JsonKey(name: 'Rebounds') List<Stats> rebounds});
}

/// @nodoc
class _$StatCategoryResponseCopyWithImpl<$Res,
        $Val extends StatCategoryResponse>
    implements $StatCategoryResponseCopyWith<$Res> {
  _$StatCategoryResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? fieldGoal = null,
    Object? freeThrow = null,
    Object? rebounds = null,
  }) {
    return _then(_value.copyWith(
      fieldGoal: null == fieldGoal
          ? _value.fieldGoal
          : fieldGoal // ignore: cast_nullable_to_non_nullable
              as List<Stats>,
      freeThrow: null == freeThrow
          ? _value.freeThrow
          : freeThrow // ignore: cast_nullable_to_non_nullable
              as List<Stats>,
      rebounds: null == rebounds
          ? _value.rebounds
          : rebounds // ignore: cast_nullable_to_non_nullable
              as List<Stats>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$StatCategoryResponseImplCopyWith<$Res>
    implements $StatCategoryResponseCopyWith<$Res> {
  factory _$$StatCategoryResponseImplCopyWith(_$StatCategoryResponseImpl value,
          $Res Function(_$StatCategoryResponseImpl) then) =
      __$$StatCategoryResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'Field Goal') List<Stats> fieldGoal,
      @JsonKey(name: 'Free Throw') List<Stats> freeThrow,
      @JsonKey(name: 'Rebounds') List<Stats> rebounds});
}

/// @nodoc
class __$$StatCategoryResponseImplCopyWithImpl<$Res>
    extends _$StatCategoryResponseCopyWithImpl<$Res, _$StatCategoryResponseImpl>
    implements _$$StatCategoryResponseImplCopyWith<$Res> {
  __$$StatCategoryResponseImplCopyWithImpl(_$StatCategoryResponseImpl _value,
      $Res Function(_$StatCategoryResponseImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? fieldGoal = null,
    Object? freeThrow = null,
    Object? rebounds = null,
  }) {
    return _then(_$StatCategoryResponseImpl(
      fieldGoal: null == fieldGoal
          ? _value._fieldGoal
          : fieldGoal // ignore: cast_nullable_to_non_nullable
              as List<Stats>,
      freeThrow: null == freeThrow
          ? _value._freeThrow
          : freeThrow // ignore: cast_nullable_to_non_nullable
              as List<Stats>,
      rebounds: null == rebounds
          ? _value._rebounds
          : rebounds // ignore: cast_nullable_to_non_nullable
              as List<Stats>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$StatCategoryResponseImpl implements _StatCategoryResponse {
  const _$StatCategoryResponseImpl(
      {@JsonKey(name: 'Field Goal') required final List<Stats> fieldGoal,
      @JsonKey(name: 'Free Throw') required final List<Stats> freeThrow,
      @JsonKey(name: 'Rebounds') required final List<Stats> rebounds})
      : _fieldGoal = fieldGoal,
        _freeThrow = freeThrow,
        _rebounds = rebounds;

  factory _$StatCategoryResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$StatCategoryResponseImplFromJson(json);

  final List<Stats> _fieldGoal;
  @override
  @JsonKey(name: 'Field Goal')
  List<Stats> get fieldGoal {
    if (_fieldGoal is EqualUnmodifiableListView) return _fieldGoal;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_fieldGoal);
  }

  final List<Stats> _freeThrow;
  @override
  @JsonKey(name: 'Free Throw')
  List<Stats> get freeThrow {
    if (_freeThrow is EqualUnmodifiableListView) return _freeThrow;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_freeThrow);
  }

  final List<Stats> _rebounds;
  @override
  @JsonKey(name: 'Rebounds')
  List<Stats> get rebounds {
    if (_rebounds is EqualUnmodifiableListView) return _rebounds;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_rebounds);
  }

  @override
  String toString() {
    return 'StatCategoryResponse(fieldGoal: $fieldGoal, freeThrow: $freeThrow, rebounds: $rebounds)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$StatCategoryResponseImpl &&
            const DeepCollectionEquality()
                .equals(other._fieldGoal, _fieldGoal) &&
            const DeepCollectionEquality()
                .equals(other._freeThrow, _freeThrow) &&
            const DeepCollectionEquality().equals(other._rebounds, _rebounds));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_fieldGoal),
      const DeepCollectionEquality().hash(_freeThrow),
      const DeepCollectionEquality().hash(_rebounds));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$StatCategoryResponseImplCopyWith<_$StatCategoryResponseImpl>
      get copyWith =>
          __$$StatCategoryResponseImplCopyWithImpl<_$StatCategoryResponseImpl>(
              this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$StatCategoryResponseImplToJson(
      this,
    );
  }
}

abstract class _StatCategoryResponse implements StatCategoryResponse {
  const factory _StatCategoryResponse(
          {@JsonKey(name: 'Field Goal') required final List<Stats> fieldGoal,
          @JsonKey(name: 'Free Throw') required final List<Stats> freeThrow,
          @JsonKey(name: 'Rebounds') required final List<Stats> rebounds}) =
      _$StatCategoryResponseImpl;

  factory _StatCategoryResponse.fromJson(Map<String, dynamic> json) =
      _$StatCategoryResponseImpl.fromJson;

  @override
  @JsonKey(name: 'Field Goal')
  List<Stats> get fieldGoal;
  @override
  @JsonKey(name: 'Free Throw')
  List<Stats> get freeThrow;
  @override
  @JsonKey(name: 'Rebounds')
  List<Stats> get rebounds;
  @override
  @JsonKey(ignore: true)
  _$$StatCategoryResponseImplCopyWith<_$StatCategoryResponseImpl>
      get copyWith => throw _privateConstructorUsedError;
}

PlayerStatResponse _$PlayerStatResponseFromJson(Map<String, dynamic> json) {
  return _PlayerStatResponse.fromJson(json);
}

/// @nodoc
mixin _$PlayerStatResponse {
  String get matchId => throw _privateConstructorUsedError;
  String get scoreboard => throw _privateConstructorUsedError;
  String get matchTitle => throw _privateConstructorUsedError;
  List<StatsByType> get statsByType => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $PlayerStatResponseCopyWith<PlayerStatResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PlayerStatResponseCopyWith<$Res> {
  factory $PlayerStatResponseCopyWith(
          PlayerStatResponse value, $Res Function(PlayerStatResponse) then) =
      _$PlayerStatResponseCopyWithImpl<$Res, PlayerStatResponse>;
  @useResult
  $Res call(
      {String matchId,
      String scoreboard,
      String matchTitle,
      List<StatsByType> statsByType});
}

/// @nodoc
class _$PlayerStatResponseCopyWithImpl<$Res, $Val extends PlayerStatResponse>
    implements $PlayerStatResponseCopyWith<$Res> {
  _$PlayerStatResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? matchId = null,
    Object? scoreboard = null,
    Object? matchTitle = null,
    Object? statsByType = null,
  }) {
    return _then(_value.copyWith(
      matchId: null == matchId
          ? _value.matchId
          : matchId // ignore: cast_nullable_to_non_nullable
              as String,
      scoreboard: null == scoreboard
          ? _value.scoreboard
          : scoreboard // ignore: cast_nullable_to_non_nullable
              as String,
      matchTitle: null == matchTitle
          ? _value.matchTitle
          : matchTitle // ignore: cast_nullable_to_non_nullable
              as String,
      statsByType: null == statsByType
          ? _value.statsByType
          : statsByType // ignore: cast_nullable_to_non_nullable
              as List<StatsByType>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$PlayerStatResponseImplCopyWith<$Res>
    implements $PlayerStatResponseCopyWith<$Res> {
  factory _$$PlayerStatResponseImplCopyWith(_$PlayerStatResponseImpl value,
          $Res Function(_$PlayerStatResponseImpl) then) =
      __$$PlayerStatResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String matchId,
      String scoreboard,
      String matchTitle,
      List<StatsByType> statsByType});
}

/// @nodoc
class __$$PlayerStatResponseImplCopyWithImpl<$Res>
    extends _$PlayerStatResponseCopyWithImpl<$Res, _$PlayerStatResponseImpl>
    implements _$$PlayerStatResponseImplCopyWith<$Res> {
  __$$PlayerStatResponseImplCopyWithImpl(_$PlayerStatResponseImpl _value,
      $Res Function(_$PlayerStatResponseImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? matchId = null,
    Object? scoreboard = null,
    Object? matchTitle = null,
    Object? statsByType = null,
  }) {
    return _then(_$PlayerStatResponseImpl(
      matchId: null == matchId
          ? _value.matchId
          : matchId // ignore: cast_nullable_to_non_nullable
              as String,
      scoreboard: null == scoreboard
          ? _value.scoreboard
          : scoreboard // ignore: cast_nullable_to_non_nullable
              as String,
      matchTitle: null == matchTitle
          ? _value.matchTitle
          : matchTitle // ignore: cast_nullable_to_non_nullable
              as String,
      statsByType: null == statsByType
          ? _value._statsByType
          : statsByType // ignore: cast_nullable_to_non_nullable
              as List<StatsByType>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$PlayerStatResponseImpl implements _PlayerStatResponse {
  const _$PlayerStatResponseImpl(
      {required this.matchId,
      required this.scoreboard,
      required this.matchTitle,
      required final List<StatsByType> statsByType})
      : _statsByType = statsByType;

  factory _$PlayerStatResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$PlayerStatResponseImplFromJson(json);

  @override
  final String matchId;
  @override
  final String scoreboard;
  @override
  final String matchTitle;
  final List<StatsByType> _statsByType;
  @override
  List<StatsByType> get statsByType {
    if (_statsByType is EqualUnmodifiableListView) return _statsByType;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_statsByType);
  }

  @override
  String toString() {
    return 'PlayerStatResponse(matchId: $matchId, scoreboard: $scoreboard, matchTitle: $matchTitle, statsByType: $statsByType)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PlayerStatResponseImpl &&
            (identical(other.matchId, matchId) || other.matchId == matchId) &&
            (identical(other.scoreboard, scoreboard) ||
                other.scoreboard == scoreboard) &&
            (identical(other.matchTitle, matchTitle) ||
                other.matchTitle == matchTitle) &&
            const DeepCollectionEquality()
                .equals(other._statsByType, _statsByType));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, matchId, scoreboard, matchTitle,
      const DeepCollectionEquality().hash(_statsByType));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$PlayerStatResponseImplCopyWith<_$PlayerStatResponseImpl> get copyWith =>
      __$$PlayerStatResponseImplCopyWithImpl<_$PlayerStatResponseImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PlayerStatResponseImplToJson(
      this,
    );
  }
}

abstract class _PlayerStatResponse implements PlayerStatResponse {
  const factory _PlayerStatResponse(
      {required final String matchId,
      required final String scoreboard,
      required final String matchTitle,
      required final List<StatsByType> statsByType}) = _$PlayerStatResponseImpl;

  factory _PlayerStatResponse.fromJson(Map<String, dynamic> json) =
      _$PlayerStatResponseImpl.fromJson;

  @override
  String get matchId;
  @override
  String get scoreboard;
  @override
  String get matchTitle;
  @override
  List<StatsByType> get statsByType;
  @override
  @JsonKey(ignore: true)
  _$$PlayerStatResponseImplCopyWith<_$PlayerStatResponseImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

StatsByType _$StatsByTypeFromJson(Map<String, dynamic> json) {
  return _StatsByType.fromJson(json);
}

/// @nodoc
mixin _$StatsByType {
  StatType get statType => throw _privateConstructorUsedError;
  int get count => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $StatsByTypeCopyWith<StatsByType> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $StatsByTypeCopyWith<$Res> {
  factory $StatsByTypeCopyWith(
          StatsByType value, $Res Function(StatsByType) then) =
      _$StatsByTypeCopyWithImpl<$Res, StatsByType>;
  @useResult
  $Res call({StatType statType, int count});

  $StatTypeCopyWith<$Res> get statType;
}

/// @nodoc
class _$StatsByTypeCopyWithImpl<$Res, $Val extends StatsByType>
    implements $StatsByTypeCopyWith<$Res> {
  _$StatsByTypeCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? statType = null,
    Object? count = null,
  }) {
    return _then(_value.copyWith(
      statType: null == statType
          ? _value.statType
          : statType // ignore: cast_nullable_to_non_nullable
              as StatType,
      count: null == count
          ? _value.count
          : count // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $StatTypeCopyWith<$Res> get statType {
    return $StatTypeCopyWith<$Res>(_value.statType, (value) {
      return _then(_value.copyWith(statType: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$StatsByTypeImplCopyWith<$Res>
    implements $StatsByTypeCopyWith<$Res> {
  factory _$$StatsByTypeImplCopyWith(
          _$StatsByTypeImpl value, $Res Function(_$StatsByTypeImpl) then) =
      __$$StatsByTypeImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({StatType statType, int count});

  @override
  $StatTypeCopyWith<$Res> get statType;
}

/// @nodoc
class __$$StatsByTypeImplCopyWithImpl<$Res>
    extends _$StatsByTypeCopyWithImpl<$Res, _$StatsByTypeImpl>
    implements _$$StatsByTypeImplCopyWith<$Res> {
  __$$StatsByTypeImplCopyWithImpl(
      _$StatsByTypeImpl _value, $Res Function(_$StatsByTypeImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? statType = null,
    Object? count = null,
  }) {
    return _then(_$StatsByTypeImpl(
      statType: null == statType
          ? _value.statType
          : statType // ignore: cast_nullable_to_non_nullable
              as StatType,
      count: null == count
          ? _value.count
          : count // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$StatsByTypeImpl implements _StatsByType {
  const _$StatsByTypeImpl({required this.statType, required this.count});

  factory _$StatsByTypeImpl.fromJson(Map<String, dynamic> json) =>
      _$$StatsByTypeImplFromJson(json);

  @override
  final StatType statType;
  @override
  final int count;

  @override
  String toString() {
    return 'StatsByType(statType: $statType, count: $count)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$StatsByTypeImpl &&
            (identical(other.statType, statType) ||
                other.statType == statType) &&
            (identical(other.count, count) || other.count == count));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, statType, count);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$StatsByTypeImplCopyWith<_$StatsByTypeImpl> get copyWith =>
      __$$StatsByTypeImplCopyWithImpl<_$StatsByTypeImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$StatsByTypeImplToJson(
      this,
    );
  }
}

abstract class _StatsByType implements StatsByType {
  const factory _StatsByType(
      {required final StatType statType,
      required final int count}) = _$StatsByTypeImpl;

  factory _StatsByType.fromJson(Map<String, dynamic> json) =
      _$StatsByTypeImpl.fromJson;

  @override
  StatType get statType;
  @override
  int get count;
  @override
  @JsonKey(ignore: true)
  _$$StatsByTypeImplCopyWith<_$StatsByTypeImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

StatType _$StatTypeFromJson(Map<String, dynamic> json) {
  return _StatType.fromJson(json);
}

/// @nodoc
mixin _$StatType {
  String get stattype => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $StatTypeCopyWith<StatType> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $StatTypeCopyWith<$Res> {
  factory $StatTypeCopyWith(StatType value, $Res Function(StatType) then) =
      _$StatTypeCopyWithImpl<$Res, StatType>;
  @useResult
  $Res call({String stattype});
}

/// @nodoc
class _$StatTypeCopyWithImpl<$Res, $Val extends StatType>
    implements $StatTypeCopyWith<$Res> {
  _$StatTypeCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? stattype = null,
  }) {
    return _then(_value.copyWith(
      stattype: null == stattype
          ? _value.stattype
          : stattype // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$StatTypeImplCopyWith<$Res>
    implements $StatTypeCopyWith<$Res> {
  factory _$$StatTypeImplCopyWith(
          _$StatTypeImpl value, $Res Function(_$StatTypeImpl) then) =
      __$$StatTypeImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String stattype});
}

/// @nodoc
class __$$StatTypeImplCopyWithImpl<$Res>
    extends _$StatTypeCopyWithImpl<$Res, _$StatTypeImpl>
    implements _$$StatTypeImplCopyWith<$Res> {
  __$$StatTypeImplCopyWithImpl(
      _$StatTypeImpl _value, $Res Function(_$StatTypeImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? stattype = null,
  }) {
    return _then(_$StatTypeImpl(
      stattype: null == stattype
          ? _value.stattype
          : stattype // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$StatTypeImpl implements _StatType {
  const _$StatTypeImpl({required this.stattype});

  factory _$StatTypeImpl.fromJson(Map<String, dynamic> json) =>
      _$$StatTypeImplFromJson(json);

  @override
  final String stattype;

  @override
  String toString() {
    return 'StatType(stattype: $stattype)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$StatTypeImpl &&
            (identical(other.stattype, stattype) ||
                other.stattype == stattype));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, stattype);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$StatTypeImplCopyWith<_$StatTypeImpl> get copyWith =>
      __$$StatTypeImplCopyWithImpl<_$StatTypeImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$StatTypeImplToJson(
      this,
    );
  }
}

abstract class _StatType implements StatType {
  const factory _StatType({required final String stattype}) = _$StatTypeImpl;

  factory _StatType.fromJson(Map<String, dynamic> json) =
      _$StatTypeImpl.fromJson;

  @override
  String get stattype;
  @override
  @JsonKey(ignore: true)
  _$$StatTypeImplCopyWith<_$StatTypeImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

HighlightReelsResponse _$HighlightReelsResponseFromJson(
    Map<String, dynamic> json) {
  return _HighlightReelsResponse.fromJson(json);
}

/// @nodoc
mixin _$HighlightReelsResponse {
  int get page => throw _privateConstructorUsedError;
  int get pageSize => throw _privateConstructorUsedError;
  int get total => throw _privateConstructorUsedError;
  int get totalPages => throw _privateConstructorUsedError;
  List<HighlightReel> get highlightReels => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $HighlightReelsResponseCopyWith<HighlightReelsResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $HighlightReelsResponseCopyWith<$Res> {
  factory $HighlightReelsResponseCopyWith(HighlightReelsResponse value,
          $Res Function(HighlightReelsResponse) then) =
      _$HighlightReelsResponseCopyWithImpl<$Res, HighlightReelsResponse>;
  @useResult
  $Res call(
      {int page,
      int pageSize,
      int total,
      int totalPages,
      List<HighlightReel> highlightReels});
}

/// @nodoc
class _$HighlightReelsResponseCopyWithImpl<$Res,
        $Val extends HighlightReelsResponse>
    implements $HighlightReelsResponseCopyWith<$Res> {
  _$HighlightReelsResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? page = null,
    Object? pageSize = null,
    Object? total = null,
    Object? totalPages = null,
    Object? highlightReels = null,
  }) {
    return _then(_value.copyWith(
      page: null == page
          ? _value.page
          : page // ignore: cast_nullable_to_non_nullable
              as int,
      pageSize: null == pageSize
          ? _value.pageSize
          : pageSize // ignore: cast_nullable_to_non_nullable
              as int,
      total: null == total
          ? _value.total
          : total // ignore: cast_nullable_to_non_nullable
              as int,
      totalPages: null == totalPages
          ? _value.totalPages
          : totalPages // ignore: cast_nullable_to_non_nullable
              as int,
      highlightReels: null == highlightReels
          ? _value.highlightReels
          : highlightReels // ignore: cast_nullable_to_non_nullable
              as List<HighlightReel>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$HighlightReelsResponseImplCopyWith<$Res>
    implements $HighlightReelsResponseCopyWith<$Res> {
  factory _$$HighlightReelsResponseImplCopyWith(
          _$HighlightReelsResponseImpl value,
          $Res Function(_$HighlightReelsResponseImpl) then) =
      __$$HighlightReelsResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int page,
      int pageSize,
      int total,
      int totalPages,
      List<HighlightReel> highlightReels});
}

/// @nodoc
class __$$HighlightReelsResponseImplCopyWithImpl<$Res>
    extends _$HighlightReelsResponseCopyWithImpl<$Res,
        _$HighlightReelsResponseImpl>
    implements _$$HighlightReelsResponseImplCopyWith<$Res> {
  __$$HighlightReelsResponseImplCopyWithImpl(
      _$HighlightReelsResponseImpl _value,
      $Res Function(_$HighlightReelsResponseImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? page = null,
    Object? pageSize = null,
    Object? total = null,
    Object? totalPages = null,
    Object? highlightReels = null,
  }) {
    return _then(_$HighlightReelsResponseImpl(
      page: null == page
          ? _value.page
          : page // ignore: cast_nullable_to_non_nullable
              as int,
      pageSize: null == pageSize
          ? _value.pageSize
          : pageSize // ignore: cast_nullable_to_non_nullable
              as int,
      total: null == total
          ? _value.total
          : total // ignore: cast_nullable_to_non_nullable
              as int,
      totalPages: null == totalPages
          ? _value.totalPages
          : totalPages // ignore: cast_nullable_to_non_nullable
              as int,
      highlightReels: null == highlightReels
          ? _value._highlightReels
          : highlightReels // ignore: cast_nullable_to_non_nullable
              as List<HighlightReel>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$HighlightReelsResponseImpl implements _HighlightReelsResponse {
  const _$HighlightReelsResponseImpl(
      {required this.page,
      required this.pageSize,
      required this.total,
      required this.totalPages,
      required final List<HighlightReel> highlightReels})
      : _highlightReels = highlightReels;

  factory _$HighlightReelsResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$HighlightReelsResponseImplFromJson(json);

  @override
  final int page;
  @override
  final int pageSize;
  @override
  final int total;
  @override
  final int totalPages;
  final List<HighlightReel> _highlightReels;
  @override
  List<HighlightReel> get highlightReels {
    if (_highlightReels is EqualUnmodifiableListView) return _highlightReels;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_highlightReels);
  }

  @override
  String toString() {
    return 'HighlightReelsResponse(page: $page, pageSize: $pageSize, total: $total, totalPages: $totalPages, highlightReels: $highlightReels)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$HighlightReelsResponseImpl &&
            (identical(other.page, page) || other.page == page) &&
            (identical(other.pageSize, pageSize) ||
                other.pageSize == pageSize) &&
            (identical(other.total, total) || other.total == total) &&
            (identical(other.totalPages, totalPages) ||
                other.totalPages == totalPages) &&
            const DeepCollectionEquality()
                .equals(other._highlightReels, _highlightReels));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, page, pageSize, total,
      totalPages, const DeepCollectionEquality().hash(_highlightReels));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$HighlightReelsResponseImplCopyWith<_$HighlightReelsResponseImpl>
      get copyWith => __$$HighlightReelsResponseImplCopyWithImpl<
          _$HighlightReelsResponseImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$HighlightReelsResponseImplToJson(
      this,
    );
  }
}

abstract class _HighlightReelsResponse implements HighlightReelsResponse {
  const factory _HighlightReelsResponse(
          {required final int page,
          required final int pageSize,
          required final int total,
          required final int totalPages,
          required final List<HighlightReel> highlightReels}) =
      _$HighlightReelsResponseImpl;

  factory _HighlightReelsResponse.fromJson(Map<String, dynamic> json) =
      _$HighlightReelsResponseImpl.fromJson;

  @override
  int get page;
  @override
  int get pageSize;
  @override
  int get total;
  @override
  int get totalPages;
  @override
  List<HighlightReel> get highlightReels;
  @override
  @JsonKey(ignore: true)
  _$$HighlightReelsResponseImplCopyWith<_$HighlightReelsResponseImpl>
      get copyWith => throw _privateConstructorUsedError;
}

HighlightReel _$HighlightReelFromJson(Map<String, dynamic> json) {
  return _HighlightReel.fromJson(json);
}

/// @nodoc
mixin _$HighlightReel {
  String get title => throw _privateConstructorUsedError;
  String get type => throw _privateConstructorUsedError;
  String get url => throw _privateConstructorUsedError;
  String get image => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $HighlightReelCopyWith<HighlightReel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $HighlightReelCopyWith<$Res> {
  factory $HighlightReelCopyWith(
          HighlightReel value, $Res Function(HighlightReel) then) =
      _$HighlightReelCopyWithImpl<$Res, HighlightReel>;
  @useResult
  $Res call({String title, String type, String url, String image});
}

/// @nodoc
class _$HighlightReelCopyWithImpl<$Res, $Val extends HighlightReel>
    implements $HighlightReelCopyWith<$Res> {
  _$HighlightReelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? title = null,
    Object? type = null,
    Object? url = null,
    Object? image = null,
  }) {
    return _then(_value.copyWith(
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
      url: null == url
          ? _value.url
          : url // ignore: cast_nullable_to_non_nullable
              as String,
      image: null == image
          ? _value.image
          : image // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$HighlightReelImplCopyWith<$Res>
    implements $HighlightReelCopyWith<$Res> {
  factory _$$HighlightReelImplCopyWith(
          _$HighlightReelImpl value, $Res Function(_$HighlightReelImpl) then) =
      __$$HighlightReelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String title, String type, String url, String image});
}

/// @nodoc
class __$$HighlightReelImplCopyWithImpl<$Res>
    extends _$HighlightReelCopyWithImpl<$Res, _$HighlightReelImpl>
    implements _$$HighlightReelImplCopyWith<$Res> {
  __$$HighlightReelImplCopyWithImpl(
      _$HighlightReelImpl _value, $Res Function(_$HighlightReelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? title = null,
    Object? type = null,
    Object? url = null,
    Object? image = null,
  }) {
    return _then(_$HighlightReelImpl(
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
      url: null == url
          ? _value.url
          : url // ignore: cast_nullable_to_non_nullable
              as String,
      image: null == image
          ? _value.image
          : image // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$HighlightReelImpl implements _HighlightReel {
  const _$HighlightReelImpl(
      {required this.title,
      required this.type,
      required this.url,
      required this.image});

  factory _$HighlightReelImpl.fromJson(Map<String, dynamic> json) =>
      _$$HighlightReelImplFromJson(json);

  @override
  final String title;
  @override
  final String type;
  @override
  final String url;
  @override
  final String image;

  @override
  String toString() {
    return 'HighlightReel(title: $title, type: $type, url: $url, image: $image)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$HighlightReelImpl &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.url, url) || other.url == url) &&
            (identical(other.image, image) || other.image == image));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, title, type, url, image);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$HighlightReelImplCopyWith<_$HighlightReelImpl> get copyWith =>
      __$$HighlightReelImplCopyWithImpl<_$HighlightReelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$HighlightReelImplToJson(
      this,
    );
  }
}

abstract class _HighlightReel implements HighlightReel {
  const factory _HighlightReel(
      {required final String title,
      required final String type,
      required final String url,
      required final String image}) = _$HighlightReelImpl;

  factory _HighlightReel.fromJson(Map<String, dynamic> json) =
      _$HighlightReelImpl.fromJson;

  @override
  String get title;
  @override
  String get type;
  @override
  String get url;
  @override
  String get image;
  @override
  @JsonKey(ignore: true)
  _$$HighlightReelImplCopyWith<_$HighlightReelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
