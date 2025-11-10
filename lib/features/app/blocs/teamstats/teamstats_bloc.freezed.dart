// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'teamstats_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$TeamStatsEvent {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() standings,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? standings,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? standings,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_TeamStatsFetched value) standings,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_TeamStatsFetched value)? standings,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_TeamStatsFetched value)? standings,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TeamStatsEventCopyWith<$Res> {
  factory $TeamStatsEventCopyWith(
          TeamStatsEvent value, $Res Function(TeamStatsEvent) then) =
      _$TeamStatsEventCopyWithImpl<$Res, TeamStatsEvent>;
}

/// @nodoc
class _$TeamStatsEventCopyWithImpl<$Res, $Val extends TeamStatsEvent>
    implements $TeamStatsEventCopyWith<$Res> {
  _$TeamStatsEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;
}

/// @nodoc
abstract class _$$TeamStatsFetchedImplCopyWith<$Res> {
  factory _$$TeamStatsFetchedImplCopyWith(_$TeamStatsFetchedImpl value,
          $Res Function(_$TeamStatsFetchedImpl) then) =
      __$$TeamStatsFetchedImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$TeamStatsFetchedImplCopyWithImpl<$Res>
    extends _$TeamStatsEventCopyWithImpl<$Res, _$TeamStatsFetchedImpl>
    implements _$$TeamStatsFetchedImplCopyWith<$Res> {
  __$$TeamStatsFetchedImplCopyWithImpl(_$TeamStatsFetchedImpl _value,
      $Res Function(_$TeamStatsFetchedImpl) _then)
      : super(_value, _then);
}

/// @nodoc

class _$TeamStatsFetchedImpl implements _TeamStatsFetched {
  const _$TeamStatsFetchedImpl();

  @override
  String toString() {
    return 'TeamStatsEvent.standings()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$TeamStatsFetchedImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() standings,
  }) {
    return standings();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? standings,
  }) {
    return standings?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? standings,
    required TResult orElse(),
  }) {
    if (standings != null) {
      return standings();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_TeamStatsFetched value) standings,
  }) {
    return standings(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_TeamStatsFetched value)? standings,
  }) {
    return standings?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_TeamStatsFetched value)? standings,
    required TResult orElse(),
  }) {
    if (standings != null) {
      return standings(this);
    }
    return orElse();
  }
}

abstract class _TeamStatsFetched implements TeamStatsEvent {
  const factory _TeamStatsFetched() = _$TeamStatsFetchedImpl;
}

/// @nodoc
mixin _$TeamStatsState {
  TeamStatsStatus get status => throw _privateConstructorUsedError;
  Failure? get failure => throw _privateConstructorUsedError;
  List<TeamStatsData>? get teamstats => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $TeamStatsStateCopyWith<TeamStatsState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TeamStatsStateCopyWith<$Res> {
  factory $TeamStatsStateCopyWith(
          TeamStatsState value, $Res Function(TeamStatsState) then) =
      _$TeamStatsStateCopyWithImpl<$Res, TeamStatsState>;
  @useResult
  $Res call(
      {TeamStatsStatus status,
      Failure? failure,
      List<TeamStatsData>? teamstats});
}

/// @nodoc
class _$TeamStatsStateCopyWithImpl<$Res, $Val extends TeamStatsState>
    implements $TeamStatsStateCopyWith<$Res> {
  _$TeamStatsStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? failure = freezed,
    Object? teamstats = freezed,
  }) {
    return _then(_value.copyWith(
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as TeamStatsStatus,
      failure: freezed == failure
          ? _value.failure
          : failure // ignore: cast_nullable_to_non_nullable
              as Failure?,
      teamstats: freezed == teamstats
          ? _value.teamstats
          : teamstats // ignore: cast_nullable_to_non_nullable
              as List<TeamStatsData>?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$TeamStatsStateImplCopyWith<$Res>
    implements $TeamStatsStateCopyWith<$Res> {
  factory _$$TeamStatsStateImplCopyWith(_$TeamStatsStateImpl value,
          $Res Function(_$TeamStatsStateImpl) then) =
      __$$TeamStatsStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {TeamStatsStatus status,
      Failure? failure,
      List<TeamStatsData>? teamstats});
}

/// @nodoc
class __$$TeamStatsStateImplCopyWithImpl<$Res>
    extends _$TeamStatsStateCopyWithImpl<$Res, _$TeamStatsStateImpl>
    implements _$$TeamStatsStateImplCopyWith<$Res> {
  __$$TeamStatsStateImplCopyWithImpl(
      _$TeamStatsStateImpl _value, $Res Function(_$TeamStatsStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? failure = freezed,
    Object? teamstats = freezed,
  }) {
    return _then(_$TeamStatsStateImpl(
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as TeamStatsStatus,
      failure: freezed == failure
          ? _value.failure
          : failure // ignore: cast_nullable_to_non_nullable
              as Failure?,
      teamstats: freezed == teamstats
          ? _value._teamstats
          : teamstats // ignore: cast_nullable_to_non_nullable
              as List<TeamStatsData>?,
    ));
  }
}

/// @nodoc

class _$TeamStatsStateImpl implements _TeamStatsState {
  const _$TeamStatsStateImpl(
      {this.status = TeamStatsStatus.initial,
      this.failure,
      final List<TeamStatsData>? teamstats})
      : _teamstats = teamstats;

  @override
  @JsonKey()
  final TeamStatsStatus status;
  @override
  final Failure? failure;
  final List<TeamStatsData>? _teamstats;
  @override
  List<TeamStatsData>? get teamstats {
    final value = _teamstats;
    if (value == null) return null;
    if (_teamstats is EqualUnmodifiableListView) return _teamstats;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  String toString() {
    return 'TeamStatsState(status: $status, failure: $failure, teamstats: $teamstats)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TeamStatsStateImpl &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.failure, failure) || other.failure == failure) &&
            const DeepCollectionEquality()
                .equals(other._teamstats, _teamstats));
  }

  @override
  int get hashCode => Object.hash(runtimeType, status, failure,
      const DeepCollectionEquality().hash(_teamstats));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$TeamStatsStateImplCopyWith<_$TeamStatsStateImpl> get copyWith =>
      __$$TeamStatsStateImplCopyWithImpl<_$TeamStatsStateImpl>(
          this, _$identity);
}

abstract class _TeamStatsState implements TeamStatsState {
  const factory _TeamStatsState(
      {final TeamStatsStatus status,
      final Failure? failure,
      final List<TeamStatsData>? teamstats}) = _$TeamStatsStateImpl;

  @override
  TeamStatsStatus get status;
  @override
  Failure? get failure;
  @override
  List<TeamStatsData>? get teamstats;
  @override
  @JsonKey(ignore: true)
  _$$TeamStatsStateImplCopyWith<_$TeamStatsStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
