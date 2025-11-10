// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'roaster_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$RoasterEvent {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() roasters,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? roasters,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? roasters,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_RoastersFetched value) roasters,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_RoastersFetched value)? roasters,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_RoastersFetched value)? roasters,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RoasterEventCopyWith<$Res> {
  factory $RoasterEventCopyWith(
          RoasterEvent value, $Res Function(RoasterEvent) then) =
      _$RoasterEventCopyWithImpl<$Res, RoasterEvent>;
}

/// @nodoc
class _$RoasterEventCopyWithImpl<$Res, $Val extends RoasterEvent>
    implements $RoasterEventCopyWith<$Res> {
  _$RoasterEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;
}

/// @nodoc
abstract class _$$RoastersFetchedImplCopyWith<$Res> {
  factory _$$RoastersFetchedImplCopyWith(_$RoastersFetchedImpl value,
          $Res Function(_$RoastersFetchedImpl) then) =
      __$$RoastersFetchedImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$RoastersFetchedImplCopyWithImpl<$Res>
    extends _$RoasterEventCopyWithImpl<$Res, _$RoastersFetchedImpl>
    implements _$$RoastersFetchedImplCopyWith<$Res> {
  __$$RoastersFetchedImplCopyWithImpl(
      _$RoastersFetchedImpl _value, $Res Function(_$RoastersFetchedImpl) _then)
      : super(_value, _then);
}

/// @nodoc

class _$RoastersFetchedImpl implements _RoastersFetched {
  const _$RoastersFetchedImpl();

  @override
  String toString() {
    return 'RoasterEvent.roasters()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$RoastersFetchedImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() roasters,
  }) {
    return roasters();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? roasters,
  }) {
    return roasters?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? roasters,
    required TResult orElse(),
  }) {
    if (roasters != null) {
      return roasters();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_RoastersFetched value) roasters,
  }) {
    return roasters(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_RoastersFetched value)? roasters,
  }) {
    return roasters?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_RoastersFetched value)? roasters,
    required TResult orElse(),
  }) {
    if (roasters != null) {
      return roasters(this);
    }
    return orElse();
  }
}

abstract class _RoastersFetched implements RoasterEvent {
  const factory _RoastersFetched() = _$RoastersFetchedImpl;
}

/// @nodoc
mixin _$RoasterState {
  RoasterStatus get status => throw _privateConstructorUsedError;
  Failure? get failure => throw _privateConstructorUsedError;
  List<RoasterData>? get roasters => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $RoasterStateCopyWith<RoasterState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RoasterStateCopyWith<$Res> {
  factory $RoasterStateCopyWith(
          RoasterState value, $Res Function(RoasterState) then) =
      _$RoasterStateCopyWithImpl<$Res, RoasterState>;
  @useResult
  $Res call(
      {RoasterStatus status, Failure? failure, List<RoasterData>? roasters});
}

/// @nodoc
class _$RoasterStateCopyWithImpl<$Res, $Val extends RoasterState>
    implements $RoasterStateCopyWith<$Res> {
  _$RoasterStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? failure = freezed,
    Object? roasters = freezed,
  }) {
    return _then(_value.copyWith(
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as RoasterStatus,
      failure: freezed == failure
          ? _value.failure
          : failure // ignore: cast_nullable_to_non_nullable
              as Failure?,
      roasters: freezed == roasters
          ? _value.roasters
          : roasters // ignore: cast_nullable_to_non_nullable
              as List<RoasterData>?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$RoasterStateImplCopyWith<$Res>
    implements $RoasterStateCopyWith<$Res> {
  factory _$$RoasterStateImplCopyWith(
          _$RoasterStateImpl value, $Res Function(_$RoasterStateImpl) then) =
      __$$RoasterStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {RoasterStatus status, Failure? failure, List<RoasterData>? roasters});
}

/// @nodoc
class __$$RoasterStateImplCopyWithImpl<$Res>
    extends _$RoasterStateCopyWithImpl<$Res, _$RoasterStateImpl>
    implements _$$RoasterStateImplCopyWith<$Res> {
  __$$RoasterStateImplCopyWithImpl(
      _$RoasterStateImpl _value, $Res Function(_$RoasterStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? failure = freezed,
    Object? roasters = freezed,
  }) {
    return _then(_$RoasterStateImpl(
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as RoasterStatus,
      failure: freezed == failure
          ? _value.failure
          : failure // ignore: cast_nullable_to_non_nullable
              as Failure?,
      roasters: freezed == roasters
          ? _value._roasters
          : roasters // ignore: cast_nullable_to_non_nullable
              as List<RoasterData>?,
    ));
  }
}

/// @nodoc

class _$RoasterStateImpl implements _RoasterState {
  const _$RoasterStateImpl(
      {this.status = RoasterStatus.initial,
      this.failure,
      final List<RoasterData>? roasters})
      : _roasters = roasters;

  @override
  @JsonKey()
  final RoasterStatus status;
  @override
  final Failure? failure;
  final List<RoasterData>? _roasters;
  @override
  List<RoasterData>? get roasters {
    final value = _roasters;
    if (value == null) return null;
    if (_roasters is EqualUnmodifiableListView) return _roasters;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  String toString() {
    return 'RoasterState(status: $status, failure: $failure, roasters: $roasters)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RoasterStateImpl &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.failure, failure) || other.failure == failure) &&
            const DeepCollectionEquality().equals(other._roasters, _roasters));
  }

  @override
  int get hashCode => Object.hash(runtimeType, status, failure,
      const DeepCollectionEquality().hash(_roasters));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$RoasterStateImplCopyWith<_$RoasterStateImpl> get copyWith =>
      __$$RoasterStateImplCopyWithImpl<_$RoasterStateImpl>(this, _$identity);
}

abstract class _RoasterState implements RoasterState {
  const factory _RoasterState(
      {final RoasterStatus status,
      final Failure? failure,
      final List<RoasterData>? roasters}) = _$RoasterStateImpl;

  @override
  RoasterStatus get status;
  @override
  Failure? get failure;
  @override
  List<RoasterData>? get roasters;
  @override
  @JsonKey(ignore: true)
  _$$RoasterStateImplCopyWith<_$RoasterStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
