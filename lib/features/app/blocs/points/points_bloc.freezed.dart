// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'points_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$PointsEvent {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() points,
    required TResult Function(dynamic request) addPoints,
    required TResult Function(dynamic request) transferPoints,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? points,
    TResult? Function(dynamic request)? addPoints,
    TResult? Function(dynamic request)? transferPoints,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? points,
    TResult Function(dynamic request)? addPoints,
    TResult Function(dynamic request)? transferPoints,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_PointsFetched value) points,
    required TResult Function(_AddPoints value) addPoints,
    required TResult Function(_TransferPoints value) transferPoints,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_PointsFetched value)? points,
    TResult? Function(_AddPoints value)? addPoints,
    TResult? Function(_TransferPoints value)? transferPoints,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_PointsFetched value)? points,
    TResult Function(_AddPoints value)? addPoints,
    TResult Function(_TransferPoints value)? transferPoints,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PointsEventCopyWith<$Res> {
  factory $PointsEventCopyWith(
          PointsEvent value, $Res Function(PointsEvent) then) =
      _$PointsEventCopyWithImpl<$Res, PointsEvent>;
}

/// @nodoc
class _$PointsEventCopyWithImpl<$Res, $Val extends PointsEvent>
    implements $PointsEventCopyWith<$Res> {
  _$PointsEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;
}

/// @nodoc
abstract class _$$PointsFetchedImplCopyWith<$Res> {
  factory _$$PointsFetchedImplCopyWith(
          _$PointsFetchedImpl value, $Res Function(_$PointsFetchedImpl) then) =
      __$$PointsFetchedImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$PointsFetchedImplCopyWithImpl<$Res>
    extends _$PointsEventCopyWithImpl<$Res, _$PointsFetchedImpl>
    implements _$$PointsFetchedImplCopyWith<$Res> {
  __$$PointsFetchedImplCopyWithImpl(
      _$PointsFetchedImpl _value, $Res Function(_$PointsFetchedImpl) _then)
      : super(_value, _then);
}

/// @nodoc

class _$PointsFetchedImpl implements _PointsFetched {
  const _$PointsFetchedImpl();

  @override
  String toString() {
    return 'PointsEvent.points()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$PointsFetchedImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() points,
    required TResult Function(dynamic request) addPoints,
    required TResult Function(dynamic request) transferPoints,
  }) {
    return points();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? points,
    TResult? Function(dynamic request)? addPoints,
    TResult? Function(dynamic request)? transferPoints,
  }) {
    return points?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? points,
    TResult Function(dynamic request)? addPoints,
    TResult Function(dynamic request)? transferPoints,
    required TResult orElse(),
  }) {
    if (points != null) {
      return points();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_PointsFetched value) points,
    required TResult Function(_AddPoints value) addPoints,
    required TResult Function(_TransferPoints value) transferPoints,
  }) {
    return points(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_PointsFetched value)? points,
    TResult? Function(_AddPoints value)? addPoints,
    TResult? Function(_TransferPoints value)? transferPoints,
  }) {
    return points?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_PointsFetched value)? points,
    TResult Function(_AddPoints value)? addPoints,
    TResult Function(_TransferPoints value)? transferPoints,
    required TResult orElse(),
  }) {
    if (points != null) {
      return points(this);
    }
    return orElse();
  }
}

abstract class _PointsFetched implements PointsEvent {
  const factory _PointsFetched() = _$PointsFetchedImpl;
}

/// @nodoc
abstract class _$$AddPointsImplCopyWith<$Res> {
  factory _$$AddPointsImplCopyWith(
          _$AddPointsImpl value, $Res Function(_$AddPointsImpl) then) =
      __$$AddPointsImplCopyWithImpl<$Res>;
  @useResult
  $Res call({dynamic request});
}

/// @nodoc
class __$$AddPointsImplCopyWithImpl<$Res>
    extends _$PointsEventCopyWithImpl<$Res, _$AddPointsImpl>
    implements _$$AddPointsImplCopyWith<$Res> {
  __$$AddPointsImplCopyWithImpl(
      _$AddPointsImpl _value, $Res Function(_$AddPointsImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? request = freezed,
  }) {
    return _then(_$AddPointsImpl(
      request: freezed == request
          ? _value.request
          : request // ignore: cast_nullable_to_non_nullable
              as dynamic,
    ));
  }
}

/// @nodoc

class _$AddPointsImpl implements _AddPoints {
  const _$AddPointsImpl({required this.request});

  @override
  final dynamic request;

  @override
  String toString() {
    return 'PointsEvent.addPoints(request: $request)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AddPointsImpl &&
            const DeepCollectionEquality().equals(other.request, request));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(request));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$AddPointsImplCopyWith<_$AddPointsImpl> get copyWith =>
      __$$AddPointsImplCopyWithImpl<_$AddPointsImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() points,
    required TResult Function(dynamic request) addPoints,
    required TResult Function(dynamic request) transferPoints,
  }) {
    return addPoints(request);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? points,
    TResult? Function(dynamic request)? addPoints,
    TResult? Function(dynamic request)? transferPoints,
  }) {
    return addPoints?.call(request);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? points,
    TResult Function(dynamic request)? addPoints,
    TResult Function(dynamic request)? transferPoints,
    required TResult orElse(),
  }) {
    if (addPoints != null) {
      return addPoints(request);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_PointsFetched value) points,
    required TResult Function(_AddPoints value) addPoints,
    required TResult Function(_TransferPoints value) transferPoints,
  }) {
    return addPoints(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_PointsFetched value)? points,
    TResult? Function(_AddPoints value)? addPoints,
    TResult? Function(_TransferPoints value)? transferPoints,
  }) {
    return addPoints?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_PointsFetched value)? points,
    TResult Function(_AddPoints value)? addPoints,
    TResult Function(_TransferPoints value)? transferPoints,
    required TResult orElse(),
  }) {
    if (addPoints != null) {
      return addPoints(this);
    }
    return orElse();
  }
}

abstract class _AddPoints implements PointsEvent {
  const factory _AddPoints({required final dynamic request}) = _$AddPointsImpl;

  dynamic get request;
  @JsonKey(ignore: true)
  _$$AddPointsImplCopyWith<_$AddPointsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$TransferPointsImplCopyWith<$Res> {
  factory _$$TransferPointsImplCopyWith(_$TransferPointsImpl value,
          $Res Function(_$TransferPointsImpl) then) =
      __$$TransferPointsImplCopyWithImpl<$Res>;
  @useResult
  $Res call({dynamic request});
}

/// @nodoc
class __$$TransferPointsImplCopyWithImpl<$Res>
    extends _$PointsEventCopyWithImpl<$Res, _$TransferPointsImpl>
    implements _$$TransferPointsImplCopyWith<$Res> {
  __$$TransferPointsImplCopyWithImpl(
      _$TransferPointsImpl _value, $Res Function(_$TransferPointsImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? request = freezed,
  }) {
    return _then(_$TransferPointsImpl(
      request: freezed == request
          ? _value.request
          : request // ignore: cast_nullable_to_non_nullable
              as dynamic,
    ));
  }
}

/// @nodoc

class _$TransferPointsImpl implements _TransferPoints {
  const _$TransferPointsImpl({required this.request});

  @override
  final dynamic request;

  @override
  String toString() {
    return 'PointsEvent.transferPoints(request: $request)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TransferPointsImpl &&
            const DeepCollectionEquality().equals(other.request, request));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(request));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$TransferPointsImplCopyWith<_$TransferPointsImpl> get copyWith =>
      __$$TransferPointsImplCopyWithImpl<_$TransferPointsImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() points,
    required TResult Function(dynamic request) addPoints,
    required TResult Function(dynamic request) transferPoints,
  }) {
    return transferPoints(request);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? points,
    TResult? Function(dynamic request)? addPoints,
    TResult? Function(dynamic request)? transferPoints,
  }) {
    return transferPoints?.call(request);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? points,
    TResult Function(dynamic request)? addPoints,
    TResult Function(dynamic request)? transferPoints,
    required TResult orElse(),
  }) {
    if (transferPoints != null) {
      return transferPoints(request);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_PointsFetched value) points,
    required TResult Function(_AddPoints value) addPoints,
    required TResult Function(_TransferPoints value) transferPoints,
  }) {
    return transferPoints(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_PointsFetched value)? points,
    TResult? Function(_AddPoints value)? addPoints,
    TResult? Function(_TransferPoints value)? transferPoints,
  }) {
    return transferPoints?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_PointsFetched value)? points,
    TResult Function(_AddPoints value)? addPoints,
    TResult Function(_TransferPoints value)? transferPoints,
    required TResult orElse(),
  }) {
    if (transferPoints != null) {
      return transferPoints(this);
    }
    return orElse();
  }
}

abstract class _TransferPoints implements PointsEvent {
  const factory _TransferPoints({required final dynamic request}) =
      _$TransferPointsImpl;

  dynamic get request;
  @JsonKey(ignore: true)
  _$$TransferPointsImplCopyWith<_$TransferPointsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$PointsState {
  PointsStatus get status => throw _privateConstructorUsedError;
  Failure? get failure => throw _privateConstructorUsedError;
  String? get message => throw _privateConstructorUsedError;
  String get balance => throw _privateConstructorUsedError;
  List<PointsData> get points => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $PointsStateCopyWith<PointsState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PointsStateCopyWith<$Res> {
  factory $PointsStateCopyWith(
          PointsState value, $Res Function(PointsState) then) =
      _$PointsStateCopyWithImpl<$Res, PointsState>;
  @useResult
  $Res call(
      {PointsStatus status,
      Failure? failure,
      String? message,
      String balance,
      List<PointsData> points});
}

/// @nodoc
class _$PointsStateCopyWithImpl<$Res, $Val extends PointsState>
    implements $PointsStateCopyWith<$Res> {
  _$PointsStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? failure = freezed,
    Object? message = freezed,
    Object? balance = null,
    Object? points = null,
  }) {
    return _then(_value.copyWith(
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as PointsStatus,
      failure: freezed == failure
          ? _value.failure
          : failure // ignore: cast_nullable_to_non_nullable
              as Failure?,
      message: freezed == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String?,
      balance: null == balance
          ? _value.balance
          : balance // ignore: cast_nullable_to_non_nullable
              as String,
      points: null == points
          ? _value.points
          : points // ignore: cast_nullable_to_non_nullable
              as List<PointsData>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$PointsStateImplCopyWith<$Res>
    implements $PointsStateCopyWith<$Res> {
  factory _$$PointsStateImplCopyWith(
          _$PointsStateImpl value, $Res Function(_$PointsStateImpl) then) =
      __$$PointsStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {PointsStatus status,
      Failure? failure,
      String? message,
      String balance,
      List<PointsData> points});
}

/// @nodoc
class __$$PointsStateImplCopyWithImpl<$Res>
    extends _$PointsStateCopyWithImpl<$Res, _$PointsStateImpl>
    implements _$$PointsStateImplCopyWith<$Res> {
  __$$PointsStateImplCopyWithImpl(
      _$PointsStateImpl _value, $Res Function(_$PointsStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? failure = freezed,
    Object? message = freezed,
    Object? balance = null,
    Object? points = null,
  }) {
    return _then(_$PointsStateImpl(
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as PointsStatus,
      failure: freezed == failure
          ? _value.failure
          : failure // ignore: cast_nullable_to_non_nullable
              as Failure?,
      message: freezed == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String?,
      balance: null == balance
          ? _value.balance
          : balance // ignore: cast_nullable_to_non_nullable
              as String,
      points: null == points
          ? _value._points
          : points // ignore: cast_nullable_to_non_nullable
              as List<PointsData>,
    ));
  }
}

/// @nodoc

class _$PointsStateImpl implements _PointsState {
  const _$PointsStateImpl(
      {this.status = PointsStatus.initial,
      this.failure,
      this.message,
      this.balance = '',
      final List<PointsData> points = const []})
      : _points = points;

  @override
  @JsonKey()
  final PointsStatus status;
  @override
  final Failure? failure;
  @override
  final String? message;
  @override
  @JsonKey()
  final String balance;
  final List<PointsData> _points;
  @override
  @JsonKey()
  List<PointsData> get points {
    if (_points is EqualUnmodifiableListView) return _points;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_points);
  }

  @override
  String toString() {
    return 'PointsState(status: $status, failure: $failure, message: $message, balance: $balance, points: $points)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PointsStateImpl &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.failure, failure) || other.failure == failure) &&
            (identical(other.message, message) || other.message == message) &&
            (identical(other.balance, balance) || other.balance == balance) &&
            const DeepCollectionEquality().equals(other._points, _points));
  }

  @override
  int get hashCode => Object.hash(runtimeType, status, failure, message,
      balance, const DeepCollectionEquality().hash(_points));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$PointsStateImplCopyWith<_$PointsStateImpl> get copyWith =>
      __$$PointsStateImplCopyWithImpl<_$PointsStateImpl>(this, _$identity);
}

abstract class _PointsState implements PointsState {
  const factory _PointsState(
      {final PointsStatus status,
      final Failure? failure,
      final String? message,
      final String balance,
      final List<PointsData> points}) = _$PointsStateImpl;

  @override
  PointsStatus get status;
  @override
  Failure? get failure;
  @override
  String? get message;
  @override
  String get balance;
  @override
  List<PointsData> get points;
  @override
  @JsonKey(ignore: true)
  _$$PointsStateImplCopyWith<_$PointsStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
