// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'club_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$ClubRoasterEvent {
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
    required TResult Function(_ClubRoasterFetched value) roasters,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_ClubRoasterFetched value)? roasters,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_ClubRoasterFetched value)? roasters,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ClubRoasterEventCopyWith<$Res> {
  factory $ClubRoasterEventCopyWith(
          ClubRoasterEvent value, $Res Function(ClubRoasterEvent) then) =
      _$ClubRoasterEventCopyWithImpl<$Res, ClubRoasterEvent>;
}

/// @nodoc
class _$ClubRoasterEventCopyWithImpl<$Res, $Val extends ClubRoasterEvent>
    implements $ClubRoasterEventCopyWith<$Res> {
  _$ClubRoasterEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;
}

/// @nodoc
abstract class _$$ClubRoasterFetchedImplCopyWith<$Res> {
  factory _$$ClubRoasterFetchedImplCopyWith(_$ClubRoasterFetchedImpl value,
          $Res Function(_$ClubRoasterFetchedImpl) then) =
      __$$ClubRoasterFetchedImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$ClubRoasterFetchedImplCopyWithImpl<$Res>
    extends _$ClubRoasterEventCopyWithImpl<$Res, _$ClubRoasterFetchedImpl>
    implements _$$ClubRoasterFetchedImplCopyWith<$Res> {
  __$$ClubRoasterFetchedImplCopyWithImpl(_$ClubRoasterFetchedImpl _value,
      $Res Function(_$ClubRoasterFetchedImpl) _then)
      : super(_value, _then);
}

/// @nodoc

class _$ClubRoasterFetchedImpl implements _ClubRoasterFetched {
  const _$ClubRoasterFetchedImpl();

  @override
  String toString() {
    return 'ClubRoasterEvent.roasters()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$ClubRoasterFetchedImpl);
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
    required TResult Function(_ClubRoasterFetched value) roasters,
  }) {
    return roasters(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_ClubRoasterFetched value)? roasters,
  }) {
    return roasters?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_ClubRoasterFetched value)? roasters,
    required TResult orElse(),
  }) {
    if (roasters != null) {
      return roasters(this);
    }
    return orElse();
  }
}

abstract class _ClubRoasterFetched implements ClubRoasterEvent {
  const factory _ClubRoasterFetched() = _$ClubRoasterFetchedImpl;
}

/// @nodoc
mixin _$ClubRoastersState {
  ClubRoastersStatus get status => throw _privateConstructorUsedError;
  Failure? get failure => throw _privateConstructorUsedError;
  List<ClubRoasterData>? get clubRoasters => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $ClubRoastersStateCopyWith<ClubRoastersState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ClubRoastersStateCopyWith<$Res> {
  factory $ClubRoastersStateCopyWith(
          ClubRoastersState value, $Res Function(ClubRoastersState) then) =
      _$ClubRoastersStateCopyWithImpl<$Res, ClubRoastersState>;
  @useResult
  $Res call(
      {ClubRoastersStatus status,
      Failure? failure,
      List<ClubRoasterData>? clubRoasters});
}

/// @nodoc
class _$ClubRoastersStateCopyWithImpl<$Res, $Val extends ClubRoastersState>
    implements $ClubRoastersStateCopyWith<$Res> {
  _$ClubRoastersStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? failure = freezed,
    Object? clubRoasters = freezed,
  }) {
    return _then(_value.copyWith(
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as ClubRoastersStatus,
      failure: freezed == failure
          ? _value.failure
          : failure // ignore: cast_nullable_to_non_nullable
              as Failure?,
      clubRoasters: freezed == clubRoasters
          ? _value.clubRoasters
          : clubRoasters // ignore: cast_nullable_to_non_nullable
              as List<ClubRoasterData>?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ClubRoastersStateImplCopyWith<$Res>
    implements $ClubRoastersStateCopyWith<$Res> {
  factory _$$ClubRoastersStateImplCopyWith(_$ClubRoastersStateImpl value,
          $Res Function(_$ClubRoastersStateImpl) then) =
      __$$ClubRoastersStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {ClubRoastersStatus status,
      Failure? failure,
      List<ClubRoasterData>? clubRoasters});
}

/// @nodoc
class __$$ClubRoastersStateImplCopyWithImpl<$Res>
    extends _$ClubRoastersStateCopyWithImpl<$Res, _$ClubRoastersStateImpl>
    implements _$$ClubRoastersStateImplCopyWith<$Res> {
  __$$ClubRoastersStateImplCopyWithImpl(_$ClubRoastersStateImpl _value,
      $Res Function(_$ClubRoastersStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? failure = freezed,
    Object? clubRoasters = freezed,
  }) {
    return _then(_$ClubRoastersStateImpl(
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as ClubRoastersStatus,
      failure: freezed == failure
          ? _value.failure
          : failure // ignore: cast_nullable_to_non_nullable
              as Failure?,
      clubRoasters: freezed == clubRoasters
          ? _value._clubRoasters
          : clubRoasters // ignore: cast_nullable_to_non_nullable
              as List<ClubRoasterData>?,
    ));
  }
}

/// @nodoc

class _$ClubRoastersStateImpl implements _ClubRoastersState {
  const _$ClubRoastersStateImpl(
      {this.status = ClubRoastersStatus.initial,
      this.failure,
      final List<ClubRoasterData>? clubRoasters})
      : _clubRoasters = clubRoasters;

  @override
  @JsonKey()
  final ClubRoastersStatus status;
  @override
  final Failure? failure;
  final List<ClubRoasterData>? _clubRoasters;
  @override
  List<ClubRoasterData>? get clubRoasters {
    final value = _clubRoasters;
    if (value == null) return null;
    if (_clubRoasters is EqualUnmodifiableListView) return _clubRoasters;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  String toString() {
    return 'ClubRoastersState(status: $status, failure: $failure, clubRoasters: $clubRoasters)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ClubRoastersStateImpl &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.failure, failure) || other.failure == failure) &&
            const DeepCollectionEquality()
                .equals(other._clubRoasters, _clubRoasters));
  }

  @override
  int get hashCode => Object.hash(runtimeType, status, failure,
      const DeepCollectionEquality().hash(_clubRoasters));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ClubRoastersStateImplCopyWith<_$ClubRoastersStateImpl> get copyWith =>
      __$$ClubRoastersStateImplCopyWithImpl<_$ClubRoastersStateImpl>(
          this, _$identity);
}

abstract class _ClubRoastersState implements ClubRoastersState {
  const factory _ClubRoastersState(
      {final ClubRoastersStatus status,
      final Failure? failure,
      final List<ClubRoasterData>? clubRoasters}) = _$ClubRoastersStateImpl;

  @override
  ClubRoastersStatus get status;
  @override
  Failure? get failure;
  @override
  List<ClubRoasterData>? get clubRoasters;
  @override
  @JsonKey(ignore: true)
  _$$ClubRoastersStateImplCopyWith<_$ClubRoastersStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
