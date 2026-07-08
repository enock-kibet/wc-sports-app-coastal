// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'match-recarp.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

MatchModel _$MatchModelFromJson(Map<String, dynamic> json) {
  return _MatchModel.fromJson(json);
}

/// @nodoc
mixin _$MatchModel {
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  ClubModel get clubOne => throw _privateConstructorUsedError;
  ClubModel get clubTwo => throw _privateConstructorUsedError;
  MatchDateModel get matchDate => throw _privateConstructorUsedError;
  VenueModel get venue => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  String get matchWinner => throw _privateConstructorUsedError;
  String get clubOneScore => throw _privateConstructorUsedError;
  String get clubTwoScore => throw _privateConstructorUsedError;
  bool get matchStatus => throw _privateConstructorUsedError;
  List<IntervalScoreModel> get intervalScores =>
      throw _privateConstructorUsedError;
  List<PlayerBoxScoreModel> get playerStatistics =>
      throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $MatchModelCopyWith<MatchModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MatchModelCopyWith<$Res> {
  factory $MatchModelCopyWith(
          MatchModel value, $Res Function(MatchModel) then) =
      _$MatchModelCopyWithImpl<$Res, MatchModel>;
  @useResult
  $Res call(
      {String id,
      String name,
      ClubModel clubOne,
      ClubModel clubTwo,
      MatchDateModel matchDate,
      VenueModel venue,
      String description,
      String matchWinner,
      String clubOneScore,
      String clubTwoScore,
      bool matchStatus,
      List<IntervalScoreModel> intervalScores,
      List<PlayerBoxScoreModel> playerStatistics});

  $ClubModelCopyWith<$Res> get clubOne;
  $ClubModelCopyWith<$Res> get clubTwo;
  $MatchDateModelCopyWith<$Res> get matchDate;
  $VenueModelCopyWith<$Res> get venue;
}

/// @nodoc
class _$MatchModelCopyWithImpl<$Res, $Val extends MatchModel>
    implements $MatchModelCopyWith<$Res> {
  _$MatchModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? clubOne = null,
    Object? clubTwo = null,
    Object? matchDate = null,
    Object? venue = null,
    Object? description = null,
    Object? matchWinner = null,
    Object? clubOneScore = null,
    Object? clubTwoScore = null,
    Object? matchStatus = null,
    Object? intervalScores = null,
    Object? playerStatistics = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      clubOne: null == clubOne
          ? _value.clubOne
          : clubOne // ignore: cast_nullable_to_non_nullable
              as ClubModel,
      clubTwo: null == clubTwo
          ? _value.clubTwo
          : clubTwo // ignore: cast_nullable_to_non_nullable
              as ClubModel,
      matchDate: null == matchDate
          ? _value.matchDate
          : matchDate // ignore: cast_nullable_to_non_nullable
              as MatchDateModel,
      venue: null == venue
          ? _value.venue
          : venue // ignore: cast_nullable_to_non_nullable
              as VenueModel,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      matchWinner: null == matchWinner
          ? _value.matchWinner
          : matchWinner // ignore: cast_nullable_to_non_nullable
              as String,
      clubOneScore: null == clubOneScore
          ? _value.clubOneScore
          : clubOneScore // ignore: cast_nullable_to_non_nullable
              as String,
      clubTwoScore: null == clubTwoScore
          ? _value.clubTwoScore
          : clubTwoScore // ignore: cast_nullable_to_non_nullable
              as String,
      matchStatus: null == matchStatus
          ? _value.matchStatus
          : matchStatus // ignore: cast_nullable_to_non_nullable
              as bool,
      intervalScores: null == intervalScores
          ? _value.intervalScores
          : intervalScores // ignore: cast_nullable_to_non_nullable
              as List<IntervalScoreModel>,
      playerStatistics: null == playerStatistics
          ? _value.playerStatistics
          : playerStatistics // ignore: cast_nullable_to_non_nullable
              as List<PlayerBoxScoreModel>,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $ClubModelCopyWith<$Res> get clubOne {
    return $ClubModelCopyWith<$Res>(_value.clubOne, (value) {
      return _then(_value.copyWith(clubOne: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $ClubModelCopyWith<$Res> get clubTwo {
    return $ClubModelCopyWith<$Res>(_value.clubTwo, (value) {
      return _then(_value.copyWith(clubTwo: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $MatchDateModelCopyWith<$Res> get matchDate {
    return $MatchDateModelCopyWith<$Res>(_value.matchDate, (value) {
      return _then(_value.copyWith(matchDate: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $VenueModelCopyWith<$Res> get venue {
    return $VenueModelCopyWith<$Res>(_value.venue, (value) {
      return _then(_value.copyWith(venue: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$MatchModelImplCopyWith<$Res>
    implements $MatchModelCopyWith<$Res> {
  factory _$$MatchModelImplCopyWith(
          _$MatchModelImpl value, $Res Function(_$MatchModelImpl) then) =
      __$$MatchModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String name,
      ClubModel clubOne,
      ClubModel clubTwo,
      MatchDateModel matchDate,
      VenueModel venue,
      String description,
      String matchWinner,
      String clubOneScore,
      String clubTwoScore,
      bool matchStatus,
      List<IntervalScoreModel> intervalScores,
      List<PlayerBoxScoreModel> playerStatistics});

  @override
  $ClubModelCopyWith<$Res> get clubOne;
  @override
  $ClubModelCopyWith<$Res> get clubTwo;
  @override
  $MatchDateModelCopyWith<$Res> get matchDate;
  @override
  $VenueModelCopyWith<$Res> get venue;
}

/// @nodoc
class __$$MatchModelImplCopyWithImpl<$Res>
    extends _$MatchModelCopyWithImpl<$Res, _$MatchModelImpl>
    implements _$$MatchModelImplCopyWith<$Res> {
  __$$MatchModelImplCopyWithImpl(
      _$MatchModelImpl _value, $Res Function(_$MatchModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? clubOne = null,
    Object? clubTwo = null,
    Object? matchDate = null,
    Object? venue = null,
    Object? description = null,
    Object? matchWinner = null,
    Object? clubOneScore = null,
    Object? clubTwoScore = null,
    Object? matchStatus = null,
    Object? intervalScores = null,
    Object? playerStatistics = null,
  }) {
    return _then(_$MatchModelImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      clubOne: null == clubOne
          ? _value.clubOne
          : clubOne // ignore: cast_nullable_to_non_nullable
              as ClubModel,
      clubTwo: null == clubTwo
          ? _value.clubTwo
          : clubTwo // ignore: cast_nullable_to_non_nullable
              as ClubModel,
      matchDate: null == matchDate
          ? _value.matchDate
          : matchDate // ignore: cast_nullable_to_non_nullable
              as MatchDateModel,
      venue: null == venue
          ? _value.venue
          : venue // ignore: cast_nullable_to_non_nullable
              as VenueModel,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      matchWinner: null == matchWinner
          ? _value.matchWinner
          : matchWinner // ignore: cast_nullable_to_non_nullable
              as String,
      clubOneScore: null == clubOneScore
          ? _value.clubOneScore
          : clubOneScore // ignore: cast_nullable_to_non_nullable
              as String,
      clubTwoScore: null == clubTwoScore
          ? _value.clubTwoScore
          : clubTwoScore // ignore: cast_nullable_to_non_nullable
              as String,
      matchStatus: null == matchStatus
          ? _value.matchStatus
          : matchStatus // ignore: cast_nullable_to_non_nullable
              as bool,
      intervalScores: null == intervalScores
          ? _value._intervalScores
          : intervalScores // ignore: cast_nullable_to_non_nullable
              as List<IntervalScoreModel>,
      playerStatistics: null == playerStatistics
          ? _value._playerStatistics
          : playerStatistics // ignore: cast_nullable_to_non_nullable
              as List<PlayerBoxScoreModel>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$MatchModelImpl implements _MatchModel {
  const _$MatchModelImpl(
      {required this.id,
      required this.name,
      required this.clubOne,
      required this.clubTwo,
      required this.matchDate,
      required this.venue,
      required this.description,
      required this.matchWinner,
      required this.clubOneScore,
      required this.clubTwoScore,
      required this.matchStatus,
      final List<IntervalScoreModel> intervalScores = const [],
      final List<PlayerBoxScoreModel> playerStatistics = const []})
      : _intervalScores = intervalScores,
        _playerStatistics = playerStatistics;

  factory _$MatchModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$MatchModelImplFromJson(json);

  @override
  final String id;
  @override
  final String name;
  @override
  final ClubModel clubOne;
  @override
  final ClubModel clubTwo;
  @override
  final MatchDateModel matchDate;
  @override
  final VenueModel venue;
  @override
  final String description;
  @override
  final String matchWinner;
  @override
  final String clubOneScore;
  @override
  final String clubTwoScore;
  @override
  final bool matchStatus;
  final List<IntervalScoreModel> _intervalScores;
  @override
  @JsonKey()
  List<IntervalScoreModel> get intervalScores {
    if (_intervalScores is EqualUnmodifiableListView) return _intervalScores;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_intervalScores);
  }

  final List<PlayerBoxScoreModel> _playerStatistics;
  @override
  @JsonKey()
  List<PlayerBoxScoreModel> get playerStatistics {
    if (_playerStatistics is EqualUnmodifiableListView)
      return _playerStatistics;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_playerStatistics);
  }

  @override
  String toString() {
    return 'MatchModel(id: $id, name: $name, clubOne: $clubOne, clubTwo: $clubTwo, matchDate: $matchDate, venue: $venue, description: $description, matchWinner: $matchWinner, clubOneScore: $clubOneScore, clubTwoScore: $clubTwoScore, matchStatus: $matchStatus, intervalScores: $intervalScores, playerStatistics: $playerStatistics)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MatchModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.clubOne, clubOne) || other.clubOne == clubOne) &&
            (identical(other.clubTwo, clubTwo) || other.clubTwo == clubTwo) &&
            (identical(other.matchDate, matchDate) ||
                other.matchDate == matchDate) &&
            (identical(other.venue, venue) || other.venue == venue) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.matchWinner, matchWinner) ||
                other.matchWinner == matchWinner) &&
            (identical(other.clubOneScore, clubOneScore) ||
                other.clubOneScore == clubOneScore) &&
            (identical(other.clubTwoScore, clubTwoScore) ||
                other.clubTwoScore == clubTwoScore) &&
            (identical(other.matchStatus, matchStatus) ||
                other.matchStatus == matchStatus) &&
            const DeepCollectionEquality()
                .equals(other._intervalScores, _intervalScores) &&
            const DeepCollectionEquality()
                .equals(other._playerStatistics, _playerStatistics));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      name,
      clubOne,
      clubTwo,
      matchDate,
      venue,
      description,
      matchWinner,
      clubOneScore,
      clubTwoScore,
      matchStatus,
      const DeepCollectionEquality().hash(_intervalScores),
      const DeepCollectionEquality().hash(_playerStatistics));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$MatchModelImplCopyWith<_$MatchModelImpl> get copyWith =>
      __$$MatchModelImplCopyWithImpl<_$MatchModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$MatchModelImplToJson(
      this,
    );
  }
}

abstract class _MatchModel implements MatchModel {
  const factory _MatchModel(
      {required final String id,
      required final String name,
      required final ClubModel clubOne,
      required final ClubModel clubTwo,
      required final MatchDateModel matchDate,
      required final VenueModel venue,
      required final String description,
      required final String matchWinner,
      required final String clubOneScore,
      required final String clubTwoScore,
      required final bool matchStatus,
      final List<IntervalScoreModel> intervalScores,
      final List<PlayerBoxScoreModel> playerStatistics}) = _$MatchModelImpl;

  factory _MatchModel.fromJson(Map<String, dynamic> json) =
      _$MatchModelImpl.fromJson;

  @override
  String get id;
  @override
  String get name;
  @override
  ClubModel get clubOne;
  @override
  ClubModel get clubTwo;
  @override
  MatchDateModel get matchDate;
  @override
  VenueModel get venue;
  @override
  String get description;
  @override
  String get matchWinner;
  @override
  String get clubOneScore;
  @override
  String get clubTwoScore;
  @override
  bool get matchStatus;
  @override
  List<IntervalScoreModel> get intervalScores;
  @override
  List<PlayerBoxScoreModel> get playerStatistics;
  @override
  @JsonKey(ignore: true)
  _$$MatchModelImplCopyWith<_$MatchModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

ClubModel _$ClubModelFromJson(Map<String, dynamic> json) {
  return _ClubModel.fromJson(json);
}

/// @nodoc
mixin _$ClubModel {
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String? get pic => throw _privateConstructorUsedError;
  List<StatModel> get stats => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ClubModelCopyWith<ClubModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ClubModelCopyWith<$Res> {
  factory $ClubModelCopyWith(ClubModel value, $Res Function(ClubModel) then) =
      _$ClubModelCopyWithImpl<$Res, ClubModel>;
  @useResult
  $Res call({String id, String name, String? pic, List<StatModel> stats});
}

/// @nodoc
class _$ClubModelCopyWithImpl<$Res, $Val extends ClubModel>
    implements $ClubModelCopyWith<$Res> {
  _$ClubModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? pic = freezed,
    Object? stats = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      pic: freezed == pic
          ? _value.pic
          : pic // ignore: cast_nullable_to_non_nullable
              as String?,
      stats: null == stats
          ? _value.stats
          : stats // ignore: cast_nullable_to_non_nullable
              as List<StatModel>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ClubModelImplCopyWith<$Res>
    implements $ClubModelCopyWith<$Res> {
  factory _$$ClubModelImplCopyWith(
          _$ClubModelImpl value, $Res Function(_$ClubModelImpl) then) =
      __$$ClubModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String id, String name, String? pic, List<StatModel> stats});
}

/// @nodoc
class __$$ClubModelImplCopyWithImpl<$Res>
    extends _$ClubModelCopyWithImpl<$Res, _$ClubModelImpl>
    implements _$$ClubModelImplCopyWith<$Res> {
  __$$ClubModelImplCopyWithImpl(
      _$ClubModelImpl _value, $Res Function(_$ClubModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? pic = freezed,
    Object? stats = null,
  }) {
    return _then(_$ClubModelImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      pic: freezed == pic
          ? _value.pic
          : pic // ignore: cast_nullable_to_non_nullable
              as String?,
      stats: null == stats
          ? _value._stats
          : stats // ignore: cast_nullable_to_non_nullable
              as List<StatModel>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ClubModelImpl implements _ClubModel {
  const _$ClubModelImpl(
      {required this.id,
      required this.name,
      this.pic,
      final List<StatModel> stats = const []})
      : _stats = stats;

  factory _$ClubModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$ClubModelImplFromJson(json);

  @override
  final String id;
  @override
  final String name;
  @override
  final String? pic;
  final List<StatModel> _stats;
  @override
  @JsonKey()
  List<StatModel> get stats {
    if (_stats is EqualUnmodifiableListView) return _stats;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_stats);
  }

  @override
  String toString() {
    return 'ClubModel(id: $id, name: $name, pic: $pic, stats: $stats)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ClubModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.pic, pic) || other.pic == pic) &&
            const DeepCollectionEquality().equals(other._stats, _stats));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, id, name, pic, const DeepCollectionEquality().hash(_stats));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ClubModelImplCopyWith<_$ClubModelImpl> get copyWith =>
      __$$ClubModelImplCopyWithImpl<_$ClubModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ClubModelImplToJson(
      this,
    );
  }
}

abstract class _ClubModel implements ClubModel {
  const factory _ClubModel(
      {required final String id,
      required final String name,
      final String? pic,
      final List<StatModel> stats}) = _$ClubModelImpl;

  factory _ClubModel.fromJson(Map<String, dynamic> json) =
      _$ClubModelImpl.fromJson;

  @override
  String get id;
  @override
  String get name;
  @override
  String? get pic;
  @override
  List<StatModel> get stats;
  @override
  @JsonKey(ignore: true)
  _$$ClubModelImplCopyWith<_$ClubModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

StatModel _$StatModelFromJson(Map<String, dynamic> json) {
  return _StatModel.fromJson(json);
}

/// @nodoc
mixin _$StatModel {
  String get stat => throw _privateConstructorUsedError;
  int get statValue => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $StatModelCopyWith<StatModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $StatModelCopyWith<$Res> {
  factory $StatModelCopyWith(StatModel value, $Res Function(StatModel) then) =
      _$StatModelCopyWithImpl<$Res, StatModel>;
  @useResult
  $Res call({String stat, int statValue});
}

/// @nodoc
class _$StatModelCopyWithImpl<$Res, $Val extends StatModel>
    implements $StatModelCopyWith<$Res> {
  _$StatModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? stat = null,
    Object? statValue = null,
  }) {
    return _then(_value.copyWith(
      stat: null == stat
          ? _value.stat
          : stat // ignore: cast_nullable_to_non_nullable
              as String,
      statValue: null == statValue
          ? _value.statValue
          : statValue // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$StatModelImplCopyWith<$Res>
    implements $StatModelCopyWith<$Res> {
  factory _$$StatModelImplCopyWith(
          _$StatModelImpl value, $Res Function(_$StatModelImpl) then) =
      __$$StatModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String stat, int statValue});
}

/// @nodoc
class __$$StatModelImplCopyWithImpl<$Res>
    extends _$StatModelCopyWithImpl<$Res, _$StatModelImpl>
    implements _$$StatModelImplCopyWith<$Res> {
  __$$StatModelImplCopyWithImpl(
      _$StatModelImpl _value, $Res Function(_$StatModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? stat = null,
    Object? statValue = null,
  }) {
    return _then(_$StatModelImpl(
      stat: null == stat
          ? _value.stat
          : stat // ignore: cast_nullable_to_non_nullable
              as String,
      statValue: null == statValue
          ? _value.statValue
          : statValue // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$StatModelImpl implements _StatModel {
  const _$StatModelImpl({required this.stat, required this.statValue});

  factory _$StatModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$StatModelImplFromJson(json);

  @override
  final String stat;
  @override
  final int statValue;

  @override
  String toString() {
    return 'StatModel(stat: $stat, statValue: $statValue)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$StatModelImpl &&
            (identical(other.stat, stat) || other.stat == stat) &&
            (identical(other.statValue, statValue) ||
                other.statValue == statValue));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, stat, statValue);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$StatModelImplCopyWith<_$StatModelImpl> get copyWith =>
      __$$StatModelImplCopyWithImpl<_$StatModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$StatModelImplToJson(
      this,
    );
  }
}

abstract class _StatModel implements StatModel {
  const factory _StatModel(
      {required final String stat,
      required final int statValue}) = _$StatModelImpl;

  factory _StatModel.fromJson(Map<String, dynamic> json) =
      _$StatModelImpl.fromJson;

  @override
  String get stat;
  @override
  int get statValue;
  @override
  @JsonKey(ignore: true)
  _$$StatModelImplCopyWith<_$StatModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

MatchDateModel _$MatchDateModelFromJson(Map<String, dynamic> json) {
  return _MatchDateModel.fromJson(json);
}

/// @nodoc
mixin _$MatchDateModel {
  String get id => throw _privateConstructorUsedError;
  DateTime get date => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $MatchDateModelCopyWith<MatchDateModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MatchDateModelCopyWith<$Res> {
  factory $MatchDateModelCopyWith(
          MatchDateModel value, $Res Function(MatchDateModel) then) =
      _$MatchDateModelCopyWithImpl<$Res, MatchDateModel>;
  @useResult
  $Res call({String id, DateTime date});
}

/// @nodoc
class _$MatchDateModelCopyWithImpl<$Res, $Val extends MatchDateModel>
    implements $MatchDateModelCopyWith<$Res> {
  _$MatchDateModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? date = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      date: null == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$MatchDateModelImplCopyWith<$Res>
    implements $MatchDateModelCopyWith<$Res> {
  factory _$$MatchDateModelImplCopyWith(_$MatchDateModelImpl value,
          $Res Function(_$MatchDateModelImpl) then) =
      __$$MatchDateModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String id, DateTime date});
}

/// @nodoc
class __$$MatchDateModelImplCopyWithImpl<$Res>
    extends _$MatchDateModelCopyWithImpl<$Res, _$MatchDateModelImpl>
    implements _$$MatchDateModelImplCopyWith<$Res> {
  __$$MatchDateModelImplCopyWithImpl(
      _$MatchDateModelImpl _value, $Res Function(_$MatchDateModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? date = null,
  }) {
    return _then(_$MatchDateModelImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      date: null == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$MatchDateModelImpl implements _MatchDateModel {
  const _$MatchDateModelImpl({required this.id, required this.date});

  factory _$MatchDateModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$MatchDateModelImplFromJson(json);

  @override
  final String id;
  @override
  final DateTime date;

  @override
  String toString() {
    return 'MatchDateModel(id: $id, date: $date)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MatchDateModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.date, date) || other.date == date));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, date);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$MatchDateModelImplCopyWith<_$MatchDateModelImpl> get copyWith =>
      __$$MatchDateModelImplCopyWithImpl<_$MatchDateModelImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$MatchDateModelImplToJson(
      this,
    );
  }
}

abstract class _MatchDateModel implements MatchDateModel {
  const factory _MatchDateModel(
      {required final String id,
      required final DateTime date}) = _$MatchDateModelImpl;

  factory _MatchDateModel.fromJson(Map<String, dynamic> json) =
      _$MatchDateModelImpl.fromJson;

  @override
  String get id;
  @override
  DateTime get date;
  @override
  @JsonKey(ignore: true)
  _$$MatchDateModelImplCopyWith<_$MatchDateModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

VenueModel _$VenueModelFromJson(Map<String, dynamic> json) {
  return _VenueModel.fromJson(json);
}

/// @nodoc
mixin _$VenueModel {
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get location => throw _privateConstructorUsedError;
  double get latitude => throw _privateConstructorUsedError;
  double get longitude => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $VenueModelCopyWith<VenueModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $VenueModelCopyWith<$Res> {
  factory $VenueModelCopyWith(
          VenueModel value, $Res Function(VenueModel) then) =
      _$VenueModelCopyWithImpl<$Res, VenueModel>;
  @useResult
  $Res call(
      {String id,
      String name,
      String location,
      double latitude,
      double longitude});
}

/// @nodoc
class _$VenueModelCopyWithImpl<$Res, $Val extends VenueModel>
    implements $VenueModelCopyWith<$Res> {
  _$VenueModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? location = null,
    Object? latitude = null,
    Object? longitude = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      location: null == location
          ? _value.location
          : location // ignore: cast_nullable_to_non_nullable
              as String,
      latitude: null == latitude
          ? _value.latitude
          : latitude // ignore: cast_nullable_to_non_nullable
              as double,
      longitude: null == longitude
          ? _value.longitude
          : longitude // ignore: cast_nullable_to_non_nullable
              as double,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$VenueModelImplCopyWith<$Res>
    implements $VenueModelCopyWith<$Res> {
  factory _$$VenueModelImplCopyWith(
          _$VenueModelImpl value, $Res Function(_$VenueModelImpl) then) =
      __$$VenueModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String name,
      String location,
      double latitude,
      double longitude});
}

/// @nodoc
class __$$VenueModelImplCopyWithImpl<$Res>
    extends _$VenueModelCopyWithImpl<$Res, _$VenueModelImpl>
    implements _$$VenueModelImplCopyWith<$Res> {
  __$$VenueModelImplCopyWithImpl(
      _$VenueModelImpl _value, $Res Function(_$VenueModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? location = null,
    Object? latitude = null,
    Object? longitude = null,
  }) {
    return _then(_$VenueModelImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      location: null == location
          ? _value.location
          : location // ignore: cast_nullable_to_non_nullable
              as String,
      latitude: null == latitude
          ? _value.latitude
          : latitude // ignore: cast_nullable_to_non_nullable
              as double,
      longitude: null == longitude
          ? _value.longitude
          : longitude // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$VenueModelImpl implements _VenueModel {
  const _$VenueModelImpl(
      {required this.id,
      required this.name,
      required this.location,
      required this.latitude,
      required this.longitude});

  factory _$VenueModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$VenueModelImplFromJson(json);

  @override
  final String id;
  @override
  final String name;
  @override
  final String location;
  @override
  final double latitude;
  @override
  final double longitude;

  @override
  String toString() {
    return 'VenueModel(id: $id, name: $name, location: $location, latitude: $latitude, longitude: $longitude)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$VenueModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.location, location) ||
                other.location == location) &&
            (identical(other.latitude, latitude) ||
                other.latitude == latitude) &&
            (identical(other.longitude, longitude) ||
                other.longitude == longitude));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, id, name, location, latitude, longitude);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$VenueModelImplCopyWith<_$VenueModelImpl> get copyWith =>
      __$$VenueModelImplCopyWithImpl<_$VenueModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$VenueModelImplToJson(
      this,
    );
  }
}

abstract class _VenueModel implements VenueModel {
  const factory _VenueModel(
      {required final String id,
      required final String name,
      required final String location,
      required final double latitude,
      required final double longitude}) = _$VenueModelImpl;

  factory _VenueModel.fromJson(Map<String, dynamic> json) =
      _$VenueModelImpl.fromJson;

  @override
  String get id;
  @override
  String get name;
  @override
  String get location;
  @override
  double get latitude;
  @override
  double get longitude;
  @override
  @JsonKey(ignore: true)
  _$$VenueModelImplCopyWith<_$VenueModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

IntervalScoreModel _$IntervalScoreModelFromJson(Map<String, dynamic> json) {
  return _IntervalScoreModel.fromJson(json);
}

/// @nodoc
mixin _$IntervalScoreModel {
  int get sequencePosition => throw _privateConstructorUsedError;
  String get interval => throw _privateConstructorUsedError;
  String get clubOne => throw _privateConstructorUsedError;
  String get homeTeamScore => throw _privateConstructorUsedError;
  String get clubTwo => throw _privateConstructorUsedError;
  String get awayTeamScore => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $IntervalScoreModelCopyWith<IntervalScoreModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $IntervalScoreModelCopyWith<$Res> {
  factory $IntervalScoreModelCopyWith(
          IntervalScoreModel value, $Res Function(IntervalScoreModel) then) =
      _$IntervalScoreModelCopyWithImpl<$Res, IntervalScoreModel>;
  @useResult
  $Res call(
      {int sequencePosition,
      String interval,
      String clubOne,
      String homeTeamScore,
      String clubTwo,
      String awayTeamScore});
}

/// @nodoc
class _$IntervalScoreModelCopyWithImpl<$Res, $Val extends IntervalScoreModel>
    implements $IntervalScoreModelCopyWith<$Res> {
  _$IntervalScoreModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? sequencePosition = null,
    Object? interval = null,
    Object? clubOne = null,
    Object? homeTeamScore = null,
    Object? clubTwo = null,
    Object? awayTeamScore = null,
  }) {
    return _then(_value.copyWith(
      sequencePosition: null == sequencePosition
          ? _value.sequencePosition
          : sequencePosition // ignore: cast_nullable_to_non_nullable
              as int,
      interval: null == interval
          ? _value.interval
          : interval // ignore: cast_nullable_to_non_nullable
              as String,
      clubOne: null == clubOne
          ? _value.clubOne
          : clubOne // ignore: cast_nullable_to_non_nullable
              as String,
      homeTeamScore: null == homeTeamScore
          ? _value.homeTeamScore
          : homeTeamScore // ignore: cast_nullable_to_non_nullable
              as String,
      clubTwo: null == clubTwo
          ? _value.clubTwo
          : clubTwo // ignore: cast_nullable_to_non_nullable
              as String,
      awayTeamScore: null == awayTeamScore
          ? _value.awayTeamScore
          : awayTeamScore // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$IntervalScoreModelImplCopyWith<$Res>
    implements $IntervalScoreModelCopyWith<$Res> {
  factory _$$IntervalScoreModelImplCopyWith(_$IntervalScoreModelImpl value,
          $Res Function(_$IntervalScoreModelImpl) then) =
      __$$IntervalScoreModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int sequencePosition,
      String interval,
      String clubOne,
      String homeTeamScore,
      String clubTwo,
      String awayTeamScore});
}

/// @nodoc
class __$$IntervalScoreModelImplCopyWithImpl<$Res>
    extends _$IntervalScoreModelCopyWithImpl<$Res, _$IntervalScoreModelImpl>
    implements _$$IntervalScoreModelImplCopyWith<$Res> {
  __$$IntervalScoreModelImplCopyWithImpl(_$IntervalScoreModelImpl _value,
      $Res Function(_$IntervalScoreModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? sequencePosition = null,
    Object? interval = null,
    Object? clubOne = null,
    Object? homeTeamScore = null,
    Object? clubTwo = null,
    Object? awayTeamScore = null,
  }) {
    return _then(_$IntervalScoreModelImpl(
      sequencePosition: null == sequencePosition
          ? _value.sequencePosition
          : sequencePosition // ignore: cast_nullable_to_non_nullable
              as int,
      interval: null == interval
          ? _value.interval
          : interval // ignore: cast_nullable_to_non_nullable
              as String,
      clubOne: null == clubOne
          ? _value.clubOne
          : clubOne // ignore: cast_nullable_to_non_nullable
              as String,
      homeTeamScore: null == homeTeamScore
          ? _value.homeTeamScore
          : homeTeamScore // ignore: cast_nullable_to_non_nullable
              as String,
      clubTwo: null == clubTwo
          ? _value.clubTwo
          : clubTwo // ignore: cast_nullable_to_non_nullable
              as String,
      awayTeamScore: null == awayTeamScore
          ? _value.awayTeamScore
          : awayTeamScore // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$IntervalScoreModelImpl implements _IntervalScoreModel {
  const _$IntervalScoreModelImpl(
      {required this.sequencePosition,
      required this.interval,
      required this.clubOne,
      required this.homeTeamScore,
      required this.clubTwo,
      required this.awayTeamScore});

  factory _$IntervalScoreModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$IntervalScoreModelImplFromJson(json);

  @override
  final int sequencePosition;
  @override
  final String interval;
  @override
  final String clubOne;
  @override
  final String homeTeamScore;
  @override
  final String clubTwo;
  @override
  final String awayTeamScore;

  @override
  String toString() {
    return 'IntervalScoreModel(sequencePosition: $sequencePosition, interval: $interval, clubOne: $clubOne, homeTeamScore: $homeTeamScore, clubTwo: $clubTwo, awayTeamScore: $awayTeamScore)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$IntervalScoreModelImpl &&
            (identical(other.sequencePosition, sequencePosition) ||
                other.sequencePosition == sequencePosition) &&
            (identical(other.interval, interval) ||
                other.interval == interval) &&
            (identical(other.clubOne, clubOne) || other.clubOne == clubOne) &&
            (identical(other.homeTeamScore, homeTeamScore) ||
                other.homeTeamScore == homeTeamScore) &&
            (identical(other.clubTwo, clubTwo) || other.clubTwo == clubTwo) &&
            (identical(other.awayTeamScore, awayTeamScore) ||
                other.awayTeamScore == awayTeamScore));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, sequencePosition, interval,
      clubOne, homeTeamScore, clubTwo, awayTeamScore);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$IntervalScoreModelImplCopyWith<_$IntervalScoreModelImpl> get copyWith =>
      __$$IntervalScoreModelImplCopyWithImpl<_$IntervalScoreModelImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$IntervalScoreModelImplToJson(
      this,
    );
  }
}

abstract class _IntervalScoreModel implements IntervalScoreModel {
  const factory _IntervalScoreModel(
      {required final int sequencePosition,
      required final String interval,
      required final String clubOne,
      required final String homeTeamScore,
      required final String clubTwo,
      required final String awayTeamScore}) = _$IntervalScoreModelImpl;

  factory _IntervalScoreModel.fromJson(Map<String, dynamic> json) =
      _$IntervalScoreModelImpl.fromJson;

  @override
  int get sequencePosition;
  @override
  String get interval;
  @override
  String get clubOne;
  @override
  String get homeTeamScore;
  @override
  String get clubTwo;
  @override
  String get awayTeamScore;
  @override
  @JsonKey(ignore: true)
  _$$IntervalScoreModelImplCopyWith<_$IntervalScoreModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

PlayerBoxScoreModel _$PlayerBoxScoreModelFromJson(Map<String, dynamic> json) {
  return _PlayerBoxScoreModel.fromJson(json);
}

/// @nodoc
mixin _$PlayerBoxScoreModel {
  String get playerId => throw _privateConstructorUsedError;
  String get playerName => throw _privateConstructorUsedError;
  String get clubId => throw _privateConstructorUsedError;
  String get clubName => throw _privateConstructorUsedError;
  String get teamSide => throw _privateConstructorUsedError;
  bool get isStarter => throw _privateConstructorUsedError;
  int get points => throw _privateConstructorUsedError;
  int get assists => throw _privateConstructorUsedError;
  int get offensiveRebounds => throw _privateConstructorUsedError;
  int get defensiveRebounds => throw _privateConstructorUsedError;
  int get totalRebounds => throw _privateConstructorUsedError;
  int get steals => throw _privateConstructorUsedError;
  int get blocks => throw _privateConstructorUsedError;
  int get turnovers => throw _privateConstructorUsedError;
  int get personalFouls => throw _privateConstructorUsedError;
  int get technicalFouls => throw _privateConstructorUsedError;
  int get fieldGoalsMade => throw _privateConstructorUsedError;
  int get fieldGoalsAttempted => throw _privateConstructorUsedError;
  int get freeThrowsMade => throw _privateConstructorUsedError;
  int get freeThrowsAttempted => throw _privateConstructorUsedError;
  int get threePointersMade => throw _privateConstructorUsedError;
  int get threePointersAttempted => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $PlayerBoxScoreModelCopyWith<PlayerBoxScoreModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PlayerBoxScoreModelCopyWith<$Res> {
  factory $PlayerBoxScoreModelCopyWith(
          PlayerBoxScoreModel value, $Res Function(PlayerBoxScoreModel) then) =
      _$PlayerBoxScoreModelCopyWithImpl<$Res, PlayerBoxScoreModel>;
  @useResult
  $Res call(
      {String playerId,
      String playerName,
      String clubId,
      String clubName,
      String teamSide,
      bool isStarter,
      int points,
      int assists,
      int offensiveRebounds,
      int defensiveRebounds,
      int totalRebounds,
      int steals,
      int blocks,
      int turnovers,
      int personalFouls,
      int technicalFouls,
      int fieldGoalsMade,
      int fieldGoalsAttempted,
      int freeThrowsMade,
      int freeThrowsAttempted,
      int threePointersMade,
      int threePointersAttempted});
}

/// @nodoc
class _$PlayerBoxScoreModelCopyWithImpl<$Res, $Val extends PlayerBoxScoreModel>
    implements $PlayerBoxScoreModelCopyWith<$Res> {
  _$PlayerBoxScoreModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? playerId = null,
    Object? playerName = null,
    Object? clubId = null,
    Object? clubName = null,
    Object? teamSide = null,
    Object? isStarter = null,
    Object? points = null,
    Object? assists = null,
    Object? offensiveRebounds = null,
    Object? defensiveRebounds = null,
    Object? totalRebounds = null,
    Object? steals = null,
    Object? blocks = null,
    Object? turnovers = null,
    Object? personalFouls = null,
    Object? technicalFouls = null,
    Object? fieldGoalsMade = null,
    Object? fieldGoalsAttempted = null,
    Object? freeThrowsMade = null,
    Object? freeThrowsAttempted = null,
    Object? threePointersMade = null,
    Object? threePointersAttempted = null,
  }) {
    return _then(_value.copyWith(
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
      clubName: null == clubName
          ? _value.clubName
          : clubName // ignore: cast_nullable_to_non_nullable
              as String,
      teamSide: null == teamSide
          ? _value.teamSide
          : teamSide // ignore: cast_nullable_to_non_nullable
              as String,
      isStarter: null == isStarter
          ? _value.isStarter
          : isStarter // ignore: cast_nullable_to_non_nullable
              as bool,
      points: null == points
          ? _value.points
          : points // ignore: cast_nullable_to_non_nullable
              as int,
      assists: null == assists
          ? _value.assists
          : assists // ignore: cast_nullable_to_non_nullable
              as int,
      offensiveRebounds: null == offensiveRebounds
          ? _value.offensiveRebounds
          : offensiveRebounds // ignore: cast_nullable_to_non_nullable
              as int,
      defensiveRebounds: null == defensiveRebounds
          ? _value.defensiveRebounds
          : defensiveRebounds // ignore: cast_nullable_to_non_nullable
              as int,
      totalRebounds: null == totalRebounds
          ? _value.totalRebounds
          : totalRebounds // ignore: cast_nullable_to_non_nullable
              as int,
      steals: null == steals
          ? _value.steals
          : steals // ignore: cast_nullable_to_non_nullable
              as int,
      blocks: null == blocks
          ? _value.blocks
          : blocks // ignore: cast_nullable_to_non_nullable
              as int,
      turnovers: null == turnovers
          ? _value.turnovers
          : turnovers // ignore: cast_nullable_to_non_nullable
              as int,
      personalFouls: null == personalFouls
          ? _value.personalFouls
          : personalFouls // ignore: cast_nullable_to_non_nullable
              as int,
      technicalFouls: null == technicalFouls
          ? _value.technicalFouls
          : technicalFouls // ignore: cast_nullable_to_non_nullable
              as int,
      fieldGoalsMade: null == fieldGoalsMade
          ? _value.fieldGoalsMade
          : fieldGoalsMade // ignore: cast_nullable_to_non_nullable
              as int,
      fieldGoalsAttempted: null == fieldGoalsAttempted
          ? _value.fieldGoalsAttempted
          : fieldGoalsAttempted // ignore: cast_nullable_to_non_nullable
              as int,
      freeThrowsMade: null == freeThrowsMade
          ? _value.freeThrowsMade
          : freeThrowsMade // ignore: cast_nullable_to_non_nullable
              as int,
      freeThrowsAttempted: null == freeThrowsAttempted
          ? _value.freeThrowsAttempted
          : freeThrowsAttempted // ignore: cast_nullable_to_non_nullable
              as int,
      threePointersMade: null == threePointersMade
          ? _value.threePointersMade
          : threePointersMade // ignore: cast_nullable_to_non_nullable
              as int,
      threePointersAttempted: null == threePointersAttempted
          ? _value.threePointersAttempted
          : threePointersAttempted // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$PlayerBoxScoreModelImplCopyWith<$Res>
    implements $PlayerBoxScoreModelCopyWith<$Res> {
  factory _$$PlayerBoxScoreModelImplCopyWith(_$PlayerBoxScoreModelImpl value,
          $Res Function(_$PlayerBoxScoreModelImpl) then) =
      __$$PlayerBoxScoreModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String playerId,
      String playerName,
      String clubId,
      String clubName,
      String teamSide,
      bool isStarter,
      int points,
      int assists,
      int offensiveRebounds,
      int defensiveRebounds,
      int totalRebounds,
      int steals,
      int blocks,
      int turnovers,
      int personalFouls,
      int technicalFouls,
      int fieldGoalsMade,
      int fieldGoalsAttempted,
      int freeThrowsMade,
      int freeThrowsAttempted,
      int threePointersMade,
      int threePointersAttempted});
}

/// @nodoc
class __$$PlayerBoxScoreModelImplCopyWithImpl<$Res>
    extends _$PlayerBoxScoreModelCopyWithImpl<$Res, _$PlayerBoxScoreModelImpl>
    implements _$$PlayerBoxScoreModelImplCopyWith<$Res> {
  __$$PlayerBoxScoreModelImplCopyWithImpl(_$PlayerBoxScoreModelImpl _value,
      $Res Function(_$PlayerBoxScoreModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? playerId = null,
    Object? playerName = null,
    Object? clubId = null,
    Object? clubName = null,
    Object? teamSide = null,
    Object? isStarter = null,
    Object? points = null,
    Object? assists = null,
    Object? offensiveRebounds = null,
    Object? defensiveRebounds = null,
    Object? totalRebounds = null,
    Object? steals = null,
    Object? blocks = null,
    Object? turnovers = null,
    Object? personalFouls = null,
    Object? technicalFouls = null,
    Object? fieldGoalsMade = null,
    Object? fieldGoalsAttempted = null,
    Object? freeThrowsMade = null,
    Object? freeThrowsAttempted = null,
    Object? threePointersMade = null,
    Object? threePointersAttempted = null,
  }) {
    return _then(_$PlayerBoxScoreModelImpl(
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
      clubName: null == clubName
          ? _value.clubName
          : clubName // ignore: cast_nullable_to_non_nullable
              as String,
      teamSide: null == teamSide
          ? _value.teamSide
          : teamSide // ignore: cast_nullable_to_non_nullable
              as String,
      isStarter: null == isStarter
          ? _value.isStarter
          : isStarter // ignore: cast_nullable_to_non_nullable
              as bool,
      points: null == points
          ? _value.points
          : points // ignore: cast_nullable_to_non_nullable
              as int,
      assists: null == assists
          ? _value.assists
          : assists // ignore: cast_nullable_to_non_nullable
              as int,
      offensiveRebounds: null == offensiveRebounds
          ? _value.offensiveRebounds
          : offensiveRebounds // ignore: cast_nullable_to_non_nullable
              as int,
      defensiveRebounds: null == defensiveRebounds
          ? _value.defensiveRebounds
          : defensiveRebounds // ignore: cast_nullable_to_non_nullable
              as int,
      totalRebounds: null == totalRebounds
          ? _value.totalRebounds
          : totalRebounds // ignore: cast_nullable_to_non_nullable
              as int,
      steals: null == steals
          ? _value.steals
          : steals // ignore: cast_nullable_to_non_nullable
              as int,
      blocks: null == blocks
          ? _value.blocks
          : blocks // ignore: cast_nullable_to_non_nullable
              as int,
      turnovers: null == turnovers
          ? _value.turnovers
          : turnovers // ignore: cast_nullable_to_non_nullable
              as int,
      personalFouls: null == personalFouls
          ? _value.personalFouls
          : personalFouls // ignore: cast_nullable_to_non_nullable
              as int,
      technicalFouls: null == technicalFouls
          ? _value.technicalFouls
          : technicalFouls // ignore: cast_nullable_to_non_nullable
              as int,
      fieldGoalsMade: null == fieldGoalsMade
          ? _value.fieldGoalsMade
          : fieldGoalsMade // ignore: cast_nullable_to_non_nullable
              as int,
      fieldGoalsAttempted: null == fieldGoalsAttempted
          ? _value.fieldGoalsAttempted
          : fieldGoalsAttempted // ignore: cast_nullable_to_non_nullable
              as int,
      freeThrowsMade: null == freeThrowsMade
          ? _value.freeThrowsMade
          : freeThrowsMade // ignore: cast_nullable_to_non_nullable
              as int,
      freeThrowsAttempted: null == freeThrowsAttempted
          ? _value.freeThrowsAttempted
          : freeThrowsAttempted // ignore: cast_nullable_to_non_nullable
              as int,
      threePointersMade: null == threePointersMade
          ? _value.threePointersMade
          : threePointersMade // ignore: cast_nullable_to_non_nullable
              as int,
      threePointersAttempted: null == threePointersAttempted
          ? _value.threePointersAttempted
          : threePointersAttempted // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$PlayerBoxScoreModelImpl implements _PlayerBoxScoreModel {
  const _$PlayerBoxScoreModelImpl(
      {required this.playerId,
      required this.playerName,
      required this.clubId,
      required this.clubName,
      required this.teamSide,
      required this.isStarter,
      this.points = 0,
      this.assists = 0,
      this.offensiveRebounds = 0,
      this.defensiveRebounds = 0,
      this.totalRebounds = 0,
      this.steals = 0,
      this.blocks = 0,
      this.turnovers = 0,
      this.personalFouls = 0,
      this.technicalFouls = 0,
      this.fieldGoalsMade = 0,
      this.fieldGoalsAttempted = 0,
      this.freeThrowsMade = 0,
      this.freeThrowsAttempted = 0,
      this.threePointersMade = 0,
      this.threePointersAttempted = 0});

  factory _$PlayerBoxScoreModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$PlayerBoxScoreModelImplFromJson(json);

  @override
  final String playerId;
  @override
  final String playerName;
  @override
  final String clubId;
  @override
  final String clubName;
  @override
  final String teamSide;
  @override
  final bool isStarter;
  @override
  @JsonKey()
  final int points;
  @override
  @JsonKey()
  final int assists;
  @override
  @JsonKey()
  final int offensiveRebounds;
  @override
  @JsonKey()
  final int defensiveRebounds;
  @override
  @JsonKey()
  final int totalRebounds;
  @override
  @JsonKey()
  final int steals;
  @override
  @JsonKey()
  final int blocks;
  @override
  @JsonKey()
  final int turnovers;
  @override
  @JsonKey()
  final int personalFouls;
  @override
  @JsonKey()
  final int technicalFouls;
  @override
  @JsonKey()
  final int fieldGoalsMade;
  @override
  @JsonKey()
  final int fieldGoalsAttempted;
  @override
  @JsonKey()
  final int freeThrowsMade;
  @override
  @JsonKey()
  final int freeThrowsAttempted;
  @override
  @JsonKey()
  final int threePointersMade;
  @override
  @JsonKey()
  final int threePointersAttempted;

  @override
  String toString() {
    return 'PlayerBoxScoreModel(playerId: $playerId, playerName: $playerName, clubId: $clubId, clubName: $clubName, teamSide: $teamSide, isStarter: $isStarter, points: $points, assists: $assists, offensiveRebounds: $offensiveRebounds, defensiveRebounds: $defensiveRebounds, totalRebounds: $totalRebounds, steals: $steals, blocks: $blocks, turnovers: $turnovers, personalFouls: $personalFouls, technicalFouls: $technicalFouls, fieldGoalsMade: $fieldGoalsMade, fieldGoalsAttempted: $fieldGoalsAttempted, freeThrowsMade: $freeThrowsMade, freeThrowsAttempted: $freeThrowsAttempted, threePointersMade: $threePointersMade, threePointersAttempted: $threePointersAttempted)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PlayerBoxScoreModelImpl &&
            (identical(other.playerId, playerId) ||
                other.playerId == playerId) &&
            (identical(other.playerName, playerName) ||
                other.playerName == playerName) &&
            (identical(other.clubId, clubId) || other.clubId == clubId) &&
            (identical(other.clubName, clubName) ||
                other.clubName == clubName) &&
            (identical(other.teamSide, teamSide) ||
                other.teamSide == teamSide) &&
            (identical(other.isStarter, isStarter) ||
                other.isStarter == isStarter) &&
            (identical(other.points, points) || other.points == points) &&
            (identical(other.assists, assists) || other.assists == assists) &&
            (identical(other.offensiveRebounds, offensiveRebounds) ||
                other.offensiveRebounds == offensiveRebounds) &&
            (identical(other.defensiveRebounds, defensiveRebounds) ||
                other.defensiveRebounds == defensiveRebounds) &&
            (identical(other.totalRebounds, totalRebounds) ||
                other.totalRebounds == totalRebounds) &&
            (identical(other.steals, steals) || other.steals == steals) &&
            (identical(other.blocks, blocks) || other.blocks == blocks) &&
            (identical(other.turnovers, turnovers) ||
                other.turnovers == turnovers) &&
            (identical(other.personalFouls, personalFouls) ||
                other.personalFouls == personalFouls) &&
            (identical(other.technicalFouls, technicalFouls) ||
                other.technicalFouls == technicalFouls) &&
            (identical(other.fieldGoalsMade, fieldGoalsMade) ||
                other.fieldGoalsMade == fieldGoalsMade) &&
            (identical(other.fieldGoalsAttempted, fieldGoalsAttempted) ||
                other.fieldGoalsAttempted == fieldGoalsAttempted) &&
            (identical(other.freeThrowsMade, freeThrowsMade) ||
                other.freeThrowsMade == freeThrowsMade) &&
            (identical(other.freeThrowsAttempted, freeThrowsAttempted) ||
                other.freeThrowsAttempted == freeThrowsAttempted) &&
            (identical(other.threePointersMade, threePointersMade) ||
                other.threePointersMade == threePointersMade) &&
            (identical(other.threePointersAttempted, threePointersAttempted) ||
                other.threePointersAttempted == threePointersAttempted));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hashAll([
        runtimeType,
        playerId,
        playerName,
        clubId,
        clubName,
        teamSide,
        isStarter,
        points,
        assists,
        offensiveRebounds,
        defensiveRebounds,
        totalRebounds,
        steals,
        blocks,
        turnovers,
        personalFouls,
        technicalFouls,
        fieldGoalsMade,
        fieldGoalsAttempted,
        freeThrowsMade,
        freeThrowsAttempted,
        threePointersMade,
        threePointersAttempted
      ]);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$PlayerBoxScoreModelImplCopyWith<_$PlayerBoxScoreModelImpl> get copyWith =>
      __$$PlayerBoxScoreModelImplCopyWithImpl<_$PlayerBoxScoreModelImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PlayerBoxScoreModelImplToJson(
      this,
    );
  }
}

abstract class _PlayerBoxScoreModel implements PlayerBoxScoreModel {
  const factory _PlayerBoxScoreModel(
      {required final String playerId,
      required final String playerName,
      required final String clubId,
      required final String clubName,
      required final String teamSide,
      required final bool isStarter,
      final int points,
      final int assists,
      final int offensiveRebounds,
      final int defensiveRebounds,
      final int totalRebounds,
      final int steals,
      final int blocks,
      final int turnovers,
      final int personalFouls,
      final int technicalFouls,
      final int fieldGoalsMade,
      final int fieldGoalsAttempted,
      final int freeThrowsMade,
      final int freeThrowsAttempted,
      final int threePointersMade,
      final int threePointersAttempted}) = _$PlayerBoxScoreModelImpl;

  factory _PlayerBoxScoreModel.fromJson(Map<String, dynamic> json) =
      _$PlayerBoxScoreModelImpl.fromJson;

  @override
  String get playerId;
  @override
  String get playerName;
  @override
  String get clubId;
  @override
  String get clubName;
  @override
  String get teamSide;
  @override
  bool get isStarter;
  @override
  int get points;
  @override
  int get assists;
  @override
  int get offensiveRebounds;
  @override
  int get defensiveRebounds;
  @override
  int get totalRebounds;
  @override
  int get steals;
  @override
  int get blocks;
  @override
  int get turnovers;
  @override
  int get personalFouls;
  @override
  int get technicalFouls;
  @override
  int get fieldGoalsMade;
  @override
  int get fieldGoalsAttempted;
  @override
  int get freeThrowsMade;
  @override
  int get freeThrowsAttempted;
  @override
  int get threePointersMade;
  @override
  int get threePointersAttempted;
  @override
  @JsonKey(ignore: true)
  _$$PlayerBoxScoreModelImplCopyWith<_$PlayerBoxScoreModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
