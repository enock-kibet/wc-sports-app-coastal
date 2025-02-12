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
    required TResult Function(String search) searchMatch,
    required TResult Function(DateTime date) datedMatch,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? matches,
    TResult? Function(String search)? searchMatch,
    TResult? Function(DateTime date)? datedMatch,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? matches,
    TResult Function(String search)? searchMatch,
    TResult Function(DateTime date)? datedMatch,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_MatchesFetched value) matches,
    required TResult Function(_MatchesSearched value) searchMatch,
    required TResult Function(_MatchesDated value) datedMatch,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_MatchesFetched value)? matches,
    TResult? Function(_MatchesSearched value)? searchMatch,
    TResult? Function(_MatchesDated value)? datedMatch,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_MatchesFetched value)? matches,
    TResult Function(_MatchesSearched value)? searchMatch,
    TResult Function(_MatchesDated value)? datedMatch,
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
    required TResult Function(String search) searchMatch,
    required TResult Function(DateTime date) datedMatch,
  }) {
    return matches();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? matches,
    TResult? Function(String search)? searchMatch,
    TResult? Function(DateTime date)? datedMatch,
  }) {
    return matches?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? matches,
    TResult Function(String search)? searchMatch,
    TResult Function(DateTime date)? datedMatch,
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
    required TResult Function(_MatchesSearched value) searchMatch,
    required TResult Function(_MatchesDated value) datedMatch,
  }) {
    return matches(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_MatchesFetched value)? matches,
    TResult? Function(_MatchesSearched value)? searchMatch,
    TResult? Function(_MatchesDated value)? datedMatch,
  }) {
    return matches?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_MatchesFetched value)? matches,
    TResult Function(_MatchesSearched value)? searchMatch,
    TResult Function(_MatchesDated value)? datedMatch,
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
abstract class _$$MatchesSearchedImplCopyWith<$Res> {
  factory _$$MatchesSearchedImplCopyWith(_$MatchesSearchedImpl value,
          $Res Function(_$MatchesSearchedImpl) then) =
      __$$MatchesSearchedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String search});
}

/// @nodoc
class __$$MatchesSearchedImplCopyWithImpl<$Res>
    extends _$MatchEventCopyWithImpl<$Res, _$MatchesSearchedImpl>
    implements _$$MatchesSearchedImplCopyWith<$Res> {
  __$$MatchesSearchedImplCopyWithImpl(
      _$MatchesSearchedImpl _value, $Res Function(_$MatchesSearchedImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? search = null,
  }) {
    return _then(_$MatchesSearchedImpl(
      search: null == search
          ? _value.search
          : search // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$MatchesSearchedImpl implements _MatchesSearched {
  const _$MatchesSearchedImpl({required this.search});

  @override
  final String search;

  @override
  String toString() {
    return 'MatchEvent.searchMatch(search: $search)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MatchesSearchedImpl &&
            (identical(other.search, search) || other.search == search));
  }

  @override
  int get hashCode => Object.hash(runtimeType, search);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$MatchesSearchedImplCopyWith<_$MatchesSearchedImpl> get copyWith =>
      __$$MatchesSearchedImplCopyWithImpl<_$MatchesSearchedImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() matches,
    required TResult Function(String search) searchMatch,
    required TResult Function(DateTime date) datedMatch,
  }) {
    return searchMatch(search);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? matches,
    TResult? Function(String search)? searchMatch,
    TResult? Function(DateTime date)? datedMatch,
  }) {
    return searchMatch?.call(search);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? matches,
    TResult Function(String search)? searchMatch,
    TResult Function(DateTime date)? datedMatch,
    required TResult orElse(),
  }) {
    if (searchMatch != null) {
      return searchMatch(search);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_MatchesFetched value) matches,
    required TResult Function(_MatchesSearched value) searchMatch,
    required TResult Function(_MatchesDated value) datedMatch,
  }) {
    return searchMatch(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_MatchesFetched value)? matches,
    TResult? Function(_MatchesSearched value)? searchMatch,
    TResult? Function(_MatchesDated value)? datedMatch,
  }) {
    return searchMatch?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_MatchesFetched value)? matches,
    TResult Function(_MatchesSearched value)? searchMatch,
    TResult Function(_MatchesDated value)? datedMatch,
    required TResult orElse(),
  }) {
    if (searchMatch != null) {
      return searchMatch(this);
    }
    return orElse();
  }
}

abstract class _MatchesSearched implements MatchEvent {
  const factory _MatchesSearched({required final String search}) =
      _$MatchesSearchedImpl;

  String get search;
  @JsonKey(ignore: true)
  _$$MatchesSearchedImplCopyWith<_$MatchesSearchedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$MatchesDatedImplCopyWith<$Res> {
  factory _$$MatchesDatedImplCopyWith(
          _$MatchesDatedImpl value, $Res Function(_$MatchesDatedImpl) then) =
      __$$MatchesDatedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({DateTime date});
}

/// @nodoc
class __$$MatchesDatedImplCopyWithImpl<$Res>
    extends _$MatchEventCopyWithImpl<$Res, _$MatchesDatedImpl>
    implements _$$MatchesDatedImplCopyWith<$Res> {
  __$$MatchesDatedImplCopyWithImpl(
      _$MatchesDatedImpl _value, $Res Function(_$MatchesDatedImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? date = null,
  }) {
    return _then(_$MatchesDatedImpl(
      date: null == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// @nodoc

class _$MatchesDatedImpl implements _MatchesDated {
  const _$MatchesDatedImpl({required this.date});

  @override
  final DateTime date;

  @override
  String toString() {
    return 'MatchEvent.datedMatch(date: $date)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MatchesDatedImpl &&
            (identical(other.date, date) || other.date == date));
  }

  @override
  int get hashCode => Object.hash(runtimeType, date);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$MatchesDatedImplCopyWith<_$MatchesDatedImpl> get copyWith =>
      __$$MatchesDatedImplCopyWithImpl<_$MatchesDatedImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() matches,
    required TResult Function(String search) searchMatch,
    required TResult Function(DateTime date) datedMatch,
  }) {
    return datedMatch(date);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? matches,
    TResult? Function(String search)? searchMatch,
    TResult? Function(DateTime date)? datedMatch,
  }) {
    return datedMatch?.call(date);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? matches,
    TResult Function(String search)? searchMatch,
    TResult Function(DateTime date)? datedMatch,
    required TResult orElse(),
  }) {
    if (datedMatch != null) {
      return datedMatch(date);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_MatchesFetched value) matches,
    required TResult Function(_MatchesSearched value) searchMatch,
    required TResult Function(_MatchesDated value) datedMatch,
  }) {
    return datedMatch(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_MatchesFetched value)? matches,
    TResult? Function(_MatchesSearched value)? searchMatch,
    TResult? Function(_MatchesDated value)? datedMatch,
  }) {
    return datedMatch?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_MatchesFetched value)? matches,
    TResult Function(_MatchesSearched value)? searchMatch,
    TResult Function(_MatchesDated value)? datedMatch,
    required TResult orElse(),
  }) {
    if (datedMatch != null) {
      return datedMatch(this);
    }
    return orElse();
  }
}

abstract class _MatchesDated implements MatchEvent {
  const factory _MatchesDated({required final DateTime date}) =
      _$MatchesDatedImpl;

  DateTime get date;
  @JsonKey(ignore: true)
  _$$MatchesDatedImplCopyWith<_$MatchesDatedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$MatchState {
  MatchStatus get status => throw _privateConstructorUsedError;
  Failure? get failure => throw _privateConstructorUsedError;
  List<MatchType> get matches => throw _privateConstructorUsedError;
  List<MatchType> get datedMatches => throw _privateConstructorUsedError;
  List<MatchType> get searchedMatches => throw _privateConstructorUsedError;

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
  $Res call(
      {MatchStatus status,
      Failure? failure,
      List<MatchType> matches,
      List<MatchType> datedMatches,
      List<MatchType> searchedMatches});
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
    Object? datedMatches = null,
    Object? searchedMatches = null,
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
              as List<MatchType>,
      datedMatches: null == datedMatches
          ? _value.datedMatches
          : datedMatches // ignore: cast_nullable_to_non_nullable
              as List<MatchType>,
      searchedMatches: null == searchedMatches
          ? _value.searchedMatches
          : searchedMatches // ignore: cast_nullable_to_non_nullable
              as List<MatchType>,
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
  $Res call(
      {MatchStatus status,
      Failure? failure,
      List<MatchType> matches,
      List<MatchType> datedMatches,
      List<MatchType> searchedMatches});
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
    Object? datedMatches = null,
    Object? searchedMatches = null,
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
              as List<MatchType>,
      datedMatches: null == datedMatches
          ? _value._datedMatches
          : datedMatches // ignore: cast_nullable_to_non_nullable
              as List<MatchType>,
      searchedMatches: null == searchedMatches
          ? _value._searchedMatches
          : searchedMatches // ignore: cast_nullable_to_non_nullable
              as List<MatchType>,
    ));
  }
}

/// @nodoc

class _$MatchStateImpl implements _MatchState {
  const _$MatchStateImpl(
      {this.status = MatchStatus.initial,
      this.failure,
      final List<MatchType> matches = const [],
      final List<MatchType> datedMatches = const [],
      final List<MatchType> searchedMatches = const []})
      : _matches = matches,
        _datedMatches = datedMatches,
        _searchedMatches = searchedMatches;

  @override
  @JsonKey()
  final MatchStatus status;
  @override
  final Failure? failure;
  final List<MatchType> _matches;
  @override
  @JsonKey()
  List<MatchType> get matches {
    if (_matches is EqualUnmodifiableListView) return _matches;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_matches);
  }

  final List<MatchType> _datedMatches;
  @override
  @JsonKey()
  List<MatchType> get datedMatches {
    if (_datedMatches is EqualUnmodifiableListView) return _datedMatches;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_datedMatches);
  }

  final List<MatchType> _searchedMatches;
  @override
  @JsonKey()
  List<MatchType> get searchedMatches {
    if (_searchedMatches is EqualUnmodifiableListView) return _searchedMatches;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_searchedMatches);
  }

  @override
  String toString() {
    return 'MatchState(status: $status, failure: $failure, matches: $matches, datedMatches: $datedMatches, searchedMatches: $searchedMatches)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MatchStateImpl &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.failure, failure) || other.failure == failure) &&
            const DeepCollectionEquality().equals(other._matches, _matches) &&
            const DeepCollectionEquality()
                .equals(other._datedMatches, _datedMatches) &&
            const DeepCollectionEquality()
                .equals(other._searchedMatches, _searchedMatches));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      status,
      failure,
      const DeepCollectionEquality().hash(_matches),
      const DeepCollectionEquality().hash(_datedMatches),
      const DeepCollectionEquality().hash(_searchedMatches));

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
      final List<MatchType> matches,
      final List<MatchType> datedMatches,
      final List<MatchType> searchedMatches}) = _$MatchStateImpl;

  @override
  MatchStatus get status;
  @override
  Failure? get failure;
  @override
  List<MatchType> get matches;
  @override
  List<MatchType> get datedMatches;
  @override
  List<MatchType> get searchedMatches;
  @override
  @JsonKey(ignore: true)
  _$$MatchStateImplCopyWith<_$MatchStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
