// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'stat_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$StatEvent {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() stats,
    required TResult Function(String playerId) getPlayerStats,
    required TResult Function(String playerId) getPlayerMedia,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? stats,
    TResult? Function(String playerId)? getPlayerStats,
    TResult? Function(String playerId)? getPlayerMedia,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? stats,
    TResult Function(String playerId)? getPlayerStats,
    TResult Function(String playerId)? getPlayerMedia,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_StatsFetched value) stats,
    required TResult Function(_PLayerStatsFetched value) getPlayerStats,
    required TResult Function(_PLayerMediaFetched value) getPlayerMedia,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_StatsFetched value)? stats,
    TResult? Function(_PLayerStatsFetched value)? getPlayerStats,
    TResult? Function(_PLayerMediaFetched value)? getPlayerMedia,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_StatsFetched value)? stats,
    TResult Function(_PLayerStatsFetched value)? getPlayerStats,
    TResult Function(_PLayerMediaFetched value)? getPlayerMedia,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $StatEventCopyWith<$Res> {
  factory $StatEventCopyWith(StatEvent value, $Res Function(StatEvent) then) =
      _$StatEventCopyWithImpl<$Res, StatEvent>;
}

/// @nodoc
class _$StatEventCopyWithImpl<$Res, $Val extends StatEvent>
    implements $StatEventCopyWith<$Res> {
  _$StatEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;
}

/// @nodoc
abstract class _$$StatsFetchedImplCopyWith<$Res> {
  factory _$$StatsFetchedImplCopyWith(
          _$StatsFetchedImpl value, $Res Function(_$StatsFetchedImpl) then) =
      __$$StatsFetchedImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$StatsFetchedImplCopyWithImpl<$Res>
    extends _$StatEventCopyWithImpl<$Res, _$StatsFetchedImpl>
    implements _$$StatsFetchedImplCopyWith<$Res> {
  __$$StatsFetchedImplCopyWithImpl(
      _$StatsFetchedImpl _value, $Res Function(_$StatsFetchedImpl) _then)
      : super(_value, _then);
}

/// @nodoc

class _$StatsFetchedImpl implements _StatsFetched {
  const _$StatsFetchedImpl();

  @override
  String toString() {
    return 'StatEvent.stats()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$StatsFetchedImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() stats,
    required TResult Function(String playerId) getPlayerStats,
    required TResult Function(String playerId) getPlayerMedia,
  }) {
    return stats();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? stats,
    TResult? Function(String playerId)? getPlayerStats,
    TResult? Function(String playerId)? getPlayerMedia,
  }) {
    return stats?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? stats,
    TResult Function(String playerId)? getPlayerStats,
    TResult Function(String playerId)? getPlayerMedia,
    required TResult orElse(),
  }) {
    if (stats != null) {
      return stats();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_StatsFetched value) stats,
    required TResult Function(_PLayerStatsFetched value) getPlayerStats,
    required TResult Function(_PLayerMediaFetched value) getPlayerMedia,
  }) {
    return stats(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_StatsFetched value)? stats,
    TResult? Function(_PLayerStatsFetched value)? getPlayerStats,
    TResult? Function(_PLayerMediaFetched value)? getPlayerMedia,
  }) {
    return stats?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_StatsFetched value)? stats,
    TResult Function(_PLayerStatsFetched value)? getPlayerStats,
    TResult Function(_PLayerMediaFetched value)? getPlayerMedia,
    required TResult orElse(),
  }) {
    if (stats != null) {
      return stats(this);
    }
    return orElse();
  }
}

abstract class _StatsFetched implements StatEvent {
  const factory _StatsFetched() = _$StatsFetchedImpl;
}

/// @nodoc
abstract class _$$PLayerStatsFetchedImplCopyWith<$Res> {
  factory _$$PLayerStatsFetchedImplCopyWith(_$PLayerStatsFetchedImpl value,
          $Res Function(_$PLayerStatsFetchedImpl) then) =
      __$$PLayerStatsFetchedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String playerId});
}

/// @nodoc
class __$$PLayerStatsFetchedImplCopyWithImpl<$Res>
    extends _$StatEventCopyWithImpl<$Res, _$PLayerStatsFetchedImpl>
    implements _$$PLayerStatsFetchedImplCopyWith<$Res> {
  __$$PLayerStatsFetchedImplCopyWithImpl(_$PLayerStatsFetchedImpl _value,
      $Res Function(_$PLayerStatsFetchedImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? playerId = null,
  }) {
    return _then(_$PLayerStatsFetchedImpl(
      playerId: null == playerId
          ? _value.playerId
          : playerId // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$PLayerStatsFetchedImpl implements _PLayerStatsFetched {
  const _$PLayerStatsFetchedImpl({required this.playerId});

  @override
  final String playerId;

  @override
  String toString() {
    return 'StatEvent.getPlayerStats(playerId: $playerId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PLayerStatsFetchedImpl &&
            (identical(other.playerId, playerId) ||
                other.playerId == playerId));
  }

  @override
  int get hashCode => Object.hash(runtimeType, playerId);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$PLayerStatsFetchedImplCopyWith<_$PLayerStatsFetchedImpl> get copyWith =>
      __$$PLayerStatsFetchedImplCopyWithImpl<_$PLayerStatsFetchedImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() stats,
    required TResult Function(String playerId) getPlayerStats,
    required TResult Function(String playerId) getPlayerMedia,
  }) {
    return getPlayerStats(playerId);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? stats,
    TResult? Function(String playerId)? getPlayerStats,
    TResult? Function(String playerId)? getPlayerMedia,
  }) {
    return getPlayerStats?.call(playerId);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? stats,
    TResult Function(String playerId)? getPlayerStats,
    TResult Function(String playerId)? getPlayerMedia,
    required TResult orElse(),
  }) {
    if (getPlayerStats != null) {
      return getPlayerStats(playerId);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_StatsFetched value) stats,
    required TResult Function(_PLayerStatsFetched value) getPlayerStats,
    required TResult Function(_PLayerMediaFetched value) getPlayerMedia,
  }) {
    return getPlayerStats(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_StatsFetched value)? stats,
    TResult? Function(_PLayerStatsFetched value)? getPlayerStats,
    TResult? Function(_PLayerMediaFetched value)? getPlayerMedia,
  }) {
    return getPlayerStats?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_StatsFetched value)? stats,
    TResult Function(_PLayerStatsFetched value)? getPlayerStats,
    TResult Function(_PLayerMediaFetched value)? getPlayerMedia,
    required TResult orElse(),
  }) {
    if (getPlayerStats != null) {
      return getPlayerStats(this);
    }
    return orElse();
  }
}

abstract class _PLayerStatsFetched implements StatEvent {
  const factory _PLayerStatsFetched({required final String playerId}) =
      _$PLayerStatsFetchedImpl;

  String get playerId;
  @JsonKey(ignore: true)
  _$$PLayerStatsFetchedImplCopyWith<_$PLayerStatsFetchedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$PLayerMediaFetchedImplCopyWith<$Res> {
  factory _$$PLayerMediaFetchedImplCopyWith(_$PLayerMediaFetchedImpl value,
          $Res Function(_$PLayerMediaFetchedImpl) then) =
      __$$PLayerMediaFetchedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String playerId});
}

/// @nodoc
class __$$PLayerMediaFetchedImplCopyWithImpl<$Res>
    extends _$StatEventCopyWithImpl<$Res, _$PLayerMediaFetchedImpl>
    implements _$$PLayerMediaFetchedImplCopyWith<$Res> {
  __$$PLayerMediaFetchedImplCopyWithImpl(_$PLayerMediaFetchedImpl _value,
      $Res Function(_$PLayerMediaFetchedImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? playerId = null,
  }) {
    return _then(_$PLayerMediaFetchedImpl(
      playerId: null == playerId
          ? _value.playerId
          : playerId // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$PLayerMediaFetchedImpl implements _PLayerMediaFetched {
  const _$PLayerMediaFetchedImpl({required this.playerId});

  @override
  final String playerId;

  @override
  String toString() {
    return 'StatEvent.getPlayerMedia(playerId: $playerId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PLayerMediaFetchedImpl &&
            (identical(other.playerId, playerId) ||
                other.playerId == playerId));
  }

  @override
  int get hashCode => Object.hash(runtimeType, playerId);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$PLayerMediaFetchedImplCopyWith<_$PLayerMediaFetchedImpl> get copyWith =>
      __$$PLayerMediaFetchedImplCopyWithImpl<_$PLayerMediaFetchedImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() stats,
    required TResult Function(String playerId) getPlayerStats,
    required TResult Function(String playerId) getPlayerMedia,
  }) {
    return getPlayerMedia(playerId);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? stats,
    TResult? Function(String playerId)? getPlayerStats,
    TResult? Function(String playerId)? getPlayerMedia,
  }) {
    return getPlayerMedia?.call(playerId);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? stats,
    TResult Function(String playerId)? getPlayerStats,
    TResult Function(String playerId)? getPlayerMedia,
    required TResult orElse(),
  }) {
    if (getPlayerMedia != null) {
      return getPlayerMedia(playerId);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_StatsFetched value) stats,
    required TResult Function(_PLayerStatsFetched value) getPlayerStats,
    required TResult Function(_PLayerMediaFetched value) getPlayerMedia,
  }) {
    return getPlayerMedia(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_StatsFetched value)? stats,
    TResult? Function(_PLayerStatsFetched value)? getPlayerStats,
    TResult? Function(_PLayerMediaFetched value)? getPlayerMedia,
  }) {
    return getPlayerMedia?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_StatsFetched value)? stats,
    TResult Function(_PLayerStatsFetched value)? getPlayerStats,
    TResult Function(_PLayerMediaFetched value)? getPlayerMedia,
    required TResult orElse(),
  }) {
    if (getPlayerMedia != null) {
      return getPlayerMedia(this);
    }
    return orElse();
  }
}

abstract class _PLayerMediaFetched implements StatEvent {
  const factory _PLayerMediaFetched({required final String playerId}) =
      _$PLayerMediaFetchedImpl;

  String get playerId;
  @JsonKey(ignore: true)
  _$$PLayerMediaFetchedImplCopyWith<_$PLayerMediaFetchedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$StatState {
  StatStatus get status => throw _privateConstructorUsedError;
  Failure? get failure => throw _privateConstructorUsedError;
  Map<String, List<Stats>>? get stats => throw _privateConstructorUsedError;
  List<PlayerStatResponse>? get playerStats =>
      throw _privateConstructorUsedError;
  List<HighlightReel>? get playerMedia => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $StatStateCopyWith<StatState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $StatStateCopyWith<$Res> {
  factory $StatStateCopyWith(StatState value, $Res Function(StatState) then) =
      _$StatStateCopyWithImpl<$Res, StatState>;
  @useResult
  $Res call(
      {StatStatus status,
      Failure? failure,
      Map<String, List<Stats>>? stats,
      List<PlayerStatResponse>? playerStats,
      List<HighlightReel>? playerMedia});
}

/// @nodoc
class _$StatStateCopyWithImpl<$Res, $Val extends StatState>
    implements $StatStateCopyWith<$Res> {
  _$StatStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? failure = freezed,
    Object? stats = freezed,
    Object? playerStats = freezed,
    Object? playerMedia = freezed,
  }) {
    return _then(_value.copyWith(
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as StatStatus,
      failure: freezed == failure
          ? _value.failure
          : failure // ignore: cast_nullable_to_non_nullable
              as Failure?,
      stats: freezed == stats
          ? _value.stats
          : stats // ignore: cast_nullable_to_non_nullable
              as Map<String, List<Stats>>?,
      playerStats: freezed == playerStats
          ? _value.playerStats
          : playerStats // ignore: cast_nullable_to_non_nullable
              as List<PlayerStatResponse>?,
      playerMedia: freezed == playerMedia
          ? _value.playerMedia
          : playerMedia // ignore: cast_nullable_to_non_nullable
              as List<HighlightReel>?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$StatStateImplCopyWith<$Res>
    implements $StatStateCopyWith<$Res> {
  factory _$$StatStateImplCopyWith(
          _$StatStateImpl value, $Res Function(_$StatStateImpl) then) =
      __$$StatStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {StatStatus status,
      Failure? failure,
      Map<String, List<Stats>>? stats,
      List<PlayerStatResponse>? playerStats,
      List<HighlightReel>? playerMedia});
}

/// @nodoc
class __$$StatStateImplCopyWithImpl<$Res>
    extends _$StatStateCopyWithImpl<$Res, _$StatStateImpl>
    implements _$$StatStateImplCopyWith<$Res> {
  __$$StatStateImplCopyWithImpl(
      _$StatStateImpl _value, $Res Function(_$StatStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? failure = freezed,
    Object? stats = freezed,
    Object? playerStats = freezed,
    Object? playerMedia = freezed,
  }) {
    return _then(_$StatStateImpl(
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as StatStatus,
      failure: freezed == failure
          ? _value.failure
          : failure // ignore: cast_nullable_to_non_nullable
              as Failure?,
      stats: freezed == stats
          ? _value._stats
          : stats // ignore: cast_nullable_to_non_nullable
              as Map<String, List<Stats>>?,
      playerStats: freezed == playerStats
          ? _value._playerStats
          : playerStats // ignore: cast_nullable_to_non_nullable
              as List<PlayerStatResponse>?,
      playerMedia: freezed == playerMedia
          ? _value._playerMedia
          : playerMedia // ignore: cast_nullable_to_non_nullable
              as List<HighlightReel>?,
    ));
  }
}

/// @nodoc

class _$StatStateImpl implements _StatState {
  const _$StatStateImpl(
      {this.status = StatStatus.initial,
      this.failure,
      final Map<String, List<Stats>>? stats,
      final List<PlayerStatResponse>? playerStats,
      final List<HighlightReel>? playerMedia})
      : _stats = stats,
        _playerStats = playerStats,
        _playerMedia = playerMedia;

  @override
  @JsonKey()
  final StatStatus status;
  @override
  final Failure? failure;
  final Map<String, List<Stats>>? _stats;
  @override
  Map<String, List<Stats>>? get stats {
    final value = _stats;
    if (value == null) return null;
    if (_stats is EqualUnmodifiableMapView) return _stats;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

  final List<PlayerStatResponse>? _playerStats;
  @override
  List<PlayerStatResponse>? get playerStats {
    final value = _playerStats;
    if (value == null) return null;
    if (_playerStats is EqualUnmodifiableListView) return _playerStats;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  final List<HighlightReel>? _playerMedia;
  @override
  List<HighlightReel>? get playerMedia {
    final value = _playerMedia;
    if (value == null) return null;
    if (_playerMedia is EqualUnmodifiableListView) return _playerMedia;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  String toString() {
    return 'StatState(status: $status, failure: $failure, stats: $stats, playerStats: $playerStats, playerMedia: $playerMedia)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$StatStateImpl &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.failure, failure) || other.failure == failure) &&
            const DeepCollectionEquality().equals(other._stats, _stats) &&
            const DeepCollectionEquality()
                .equals(other._playerStats, _playerStats) &&
            const DeepCollectionEquality()
                .equals(other._playerMedia, _playerMedia));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      status,
      failure,
      const DeepCollectionEquality().hash(_stats),
      const DeepCollectionEquality().hash(_playerStats),
      const DeepCollectionEquality().hash(_playerMedia));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$StatStateImplCopyWith<_$StatStateImpl> get copyWith =>
      __$$StatStateImplCopyWithImpl<_$StatStateImpl>(this, _$identity);
}

abstract class _StatState implements StatState {
  const factory _StatState(
      {final StatStatus status,
      final Failure? failure,
      final Map<String, List<Stats>>? stats,
      final List<PlayerStatResponse>? playerStats,
      final List<HighlightReel>? playerMedia}) = _$StatStateImpl;

  @override
  StatStatus get status;
  @override
  Failure? get failure;
  @override
  Map<String, List<Stats>>? get stats;
  @override
  List<PlayerStatResponse>? get playerStats;
  @override
  List<HighlightReel>? get playerMedia;
  @override
  @JsonKey(ignore: true)
  _$$StatStateImplCopyWith<_$StatStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
