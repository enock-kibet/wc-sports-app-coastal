// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'match_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$MatchEvent {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() matches,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? matches,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? matches,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_MatchesFetched value) matches,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_MatchesFetched value)? matches,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_MatchesFetched value)? matches,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MatchEventCopyWith<$Res> {
  factory $MatchEventCopyWith(
          MatchEvent value, $Res Function(MatchEvent) then) =
      _$MatchEventCopyWithImpl<$Res, MatchEvent>;
}

/// @nodoc
class _$MatchEventCopyWithImpl<$Res, $Val extends MatchEvent>
    implements $MatchEventCopyWith<$Res> {
  _$MatchEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;
}

/// @nodoc
abstract class _$$MatchesFetchedImplCopyWith<$Res> {
  factory _$$MatchesFetchedImplCopyWith(_$MatchesFetchedImpl value,
          $Res Function(_$MatchesFetchedImpl) then) =
      __$$MatchesFetchedImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$MatchesFetchedImplCopyWithImpl<$Res>
    extends _$MatchEventCopyWithImpl<$Res, _$MatchesFetchedImpl>
    implements _$$MatchesFetchedImplCopyWith<$Res> {
  __$$MatchesFetchedImplCopyWithImpl(
      _$MatchesFetchedImpl _value, $Res Function(_$MatchesFetchedImpl) _then)
      : super(_value, _then);
}

/// @nodoc

class _$MatchesFetchedImpl implements _MatchesFetched {
  const _$MatchesFetchedImpl();

  @override
  String toString() {
    return 'MatchEvent.matches()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$MatchesFetchedImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() matches,
  }) {
    return matches();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? matches,
  }) {
    return matches?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? matches,
    required TResult orElse(),
  }) {
    if (matches != null) {
      return matches();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_MatchesFetched value) matches,
  }) {
    return matches(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_MatchesFetched value)? matches,
  }) {
    return matches?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_MatchesFetched value)? matches,
    required TResult orElse(),
  }) {
    if (matches != null) {
      return matches(this);
    }
    return orElse();
  }
}

abstract class _MatchesFetched implements MatchEvent {
  const factory _MatchesFetched() = _$MatchesFetchedImpl;
}

/// @nodoc
mixin _$MatchState {
  MatchStatus get status => throw _privateConstructorUsedError;
  Failure? get failure => throw _privateConstructorUsedError;
  List<dynamic> get matches => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $MatchStateCopyWith<MatchState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MatchStateCopyWith<$Res> {
  factory $MatchStateCopyWith(
          MatchState value, $Res Function(MatchState) then) =
      _$MatchStateCopyWithImpl<$Res, MatchState>;
  @useResult
  $Res call({MatchStatus status, Failure? failure, List<dynamic> matches});
}

/// @nodoc
class _$MatchStateCopyWithImpl<$Res, $Val extends MatchState>
    implements $MatchStateCopyWith<$Res> {
  _$MatchStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? failure = freezed,
    Object? matches = null,
  }) {
    return _then(_value.copyWith(
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as MatchStatus,
      failure: freezed == failure
          ? _value.failure
          : failure // ignore: cast_nullable_to_non_nullable
              as Failure?,
      matches: null == matches
          ? _value.matches
          : matches // ignore: cast_nullable_to_non_nullable
              as List<dynamic>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$MatchStateImplCopyWith<$Res>
    implements $MatchStateCopyWith<$Res> {
  factory _$$MatchStateImplCopyWith(
          _$MatchStateImpl value, $Res Function(_$MatchStateImpl) then) =
      __$$MatchStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({MatchStatus status, Failure? failure, List<dynamic> matches});
}

/// @nodoc
class __$$MatchStateImplCopyWithImpl<$Res>
    extends _$MatchStateCopyWithImpl<$Res, _$MatchStateImpl>
    implements _$$MatchStateImplCopyWith<$Res> {
  __$$MatchStateImplCopyWithImpl(
      _$MatchStateImpl _value, $Res Function(_$MatchStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? failure = freezed,
    Object? matches = null,
  }) {
    return _then(_$MatchStateImpl(
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as MatchStatus,
      failure: freezed == failure
          ? _value.failure
          : failure // ignore: cast_nullable_to_non_nullable
              as Failure?,
      matches: null == matches
          ? _value._matches
          : matches // ignore: cast_nullable_to_non_nullable
              as List<dynamic>,
    ));
  }
}

/// @nodoc

class _$MatchStateImpl implements _MatchState {
  const _$MatchStateImpl(
      {this.status = MatchStatus.initial,
      this.failure,
      final List<dynamic> matches = const []})
      : _matches = matches;

  @override
  @JsonKey()
  final MatchStatus status;
  @override
  final Failure? failure;
  final List<dynamic> _matches;
  @override
  @JsonKey()
  List<dynamic> get matches {
    if (_matches is EqualUnmodifiableListView) return _matches;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_matches);
  }

  @override
  String toString() {
    return 'MatchState(status: $status, failure: $failure, matches: $matches)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MatchStateImpl &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.failure, failure) || other.failure == failure) &&
            const DeepCollectionEquality().equals(other._matches, _matches));
  }

  @override
  int get hashCode => Object.hash(runtimeType, status, failure,
      const DeepCollectionEquality().hash(_matches));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$MatchStateImplCopyWith<_$MatchStateImpl> get copyWith =>
      __$$MatchStateImplCopyWithImpl<_$MatchStateImpl>(this, _$identity);
}

abstract class _MatchState implements MatchState {
  const factory _MatchState(
      {final MatchStatus status,
      final Failure? failure,
      final List<dynamic> matches}) = _$MatchStateImpl;

  @override
  MatchStatus get status;
  @override
  Failure? get failure;
  @override
  List<dynamic> get matches;
  @override
  @JsonKey(ignore: true)
  _$$MatchStateImplCopyWith<_$MatchStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
