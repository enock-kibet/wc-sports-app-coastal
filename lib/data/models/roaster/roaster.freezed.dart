// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'roaster.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

RoasterResponse _$RoasterResponseFromJson(Map<String, dynamic> json) {
  return _RoasterResponse.fromJson(json);
}

/// @nodoc
mixin _$RoasterResponse {
  List<RoasterData> get data => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $RoasterResponseCopyWith<RoasterResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RoasterResponseCopyWith<$Res> {
  factory $RoasterResponseCopyWith(
          RoasterResponse value, $Res Function(RoasterResponse) then) =
      _$RoasterResponseCopyWithImpl<$Res, RoasterResponse>;
  @useResult
  $Res call({List<RoasterData> data});
}

/// @nodoc
class _$RoasterResponseCopyWithImpl<$Res, $Val extends RoasterResponse>
    implements $RoasterResponseCopyWith<$Res> {
  _$RoasterResponseCopyWithImpl(this._value, this._then);

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
              as List<RoasterData>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$RoasterResponseImplCopyWith<$Res>
    implements $RoasterResponseCopyWith<$Res> {
  factory _$$RoasterResponseImplCopyWith(_$RoasterResponseImpl value,
          $Res Function(_$RoasterResponseImpl) then) =
      __$$RoasterResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<RoasterData> data});
}

/// @nodoc
class __$$RoasterResponseImplCopyWithImpl<$Res>
    extends _$RoasterResponseCopyWithImpl<$Res, _$RoasterResponseImpl>
    implements _$$RoasterResponseImplCopyWith<$Res> {
  __$$RoasterResponseImplCopyWithImpl(
      _$RoasterResponseImpl _value, $Res Function(_$RoasterResponseImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? data = null,
  }) {
    return _then(_$RoasterResponseImpl(
      data: null == data
          ? _value._data
          : data // ignore: cast_nullable_to_non_nullable
              as List<RoasterData>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$RoasterResponseImpl implements _RoasterResponse {
  const _$RoasterResponseImpl({required final List<RoasterData> data})
      : _data = data;

  factory _$RoasterResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$RoasterResponseImplFromJson(json);

  final List<RoasterData> _data;
  @override
  List<RoasterData> get data {
    if (_data is EqualUnmodifiableListView) return _data;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_data);
  }

  @override
  String toString() {
    return 'RoasterResponse(data: $data)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RoasterResponseImpl &&
            const DeepCollectionEquality().equals(other._data, _data));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_data));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$RoasterResponseImplCopyWith<_$RoasterResponseImpl> get copyWith =>
      __$$RoasterResponseImplCopyWithImpl<_$RoasterResponseImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$RoasterResponseImplToJson(
      this,
    );
  }
}

abstract class _RoasterResponse implements RoasterResponse {
  const factory _RoasterResponse({required final List<RoasterData> data}) =
      _$RoasterResponseImpl;

  factory _RoasterResponse.fromJson(Map<String, dynamic> json) =
      _$RoasterResponseImpl.fromJson;

  @override
  List<RoasterData> get data;
  @override
  @JsonKey(ignore: true)
  _$$RoasterResponseImplCopyWith<_$RoasterResponseImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

RoasterData _$RoasterDataFromJson(Map<String, dynamic> json) {
  return _RoasterData.fromJson(json);
}

/// @nodoc
mixin _$RoasterData {
  String get playerId => throw _privateConstructorUsedError;
  String get playerName => throw _privateConstructorUsedError;
  String get position => throw _privateConstructorUsedError;
  String get imageUrl => throw _privateConstructorUsedError;
  String get playerHeight => throw _privateConstructorUsedError;
  String get playerWeight => throw _privateConstructorUsedError;
  String get playerNumber => throw _privateConstructorUsedError;
  Map<String, dynamic> get stats => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $RoasterDataCopyWith<RoasterData> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RoasterDataCopyWith<$Res> {
  factory $RoasterDataCopyWith(
          RoasterData value, $Res Function(RoasterData) then) =
      _$RoasterDataCopyWithImpl<$Res, RoasterData>;
  @useResult
  $Res call(
      {String playerId,
      String playerName,
      String position,
      String imageUrl,
      String playerHeight,
      String playerWeight,
      String playerNumber,
      Map<String, dynamic> stats});
}

/// @nodoc
class _$RoasterDataCopyWithImpl<$Res, $Val extends RoasterData>
    implements $RoasterDataCopyWith<$Res> {
  _$RoasterDataCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? playerId = null,
    Object? playerName = null,
    Object? position = null,
    Object? imageUrl = null,
    Object? playerHeight = null,
    Object? playerWeight = null,
    Object? playerNumber = null,
    Object? stats = null,
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
      position: null == position
          ? _value.position
          : position // ignore: cast_nullable_to_non_nullable
              as String,
      imageUrl: null == imageUrl
          ? _value.imageUrl
          : imageUrl // ignore: cast_nullable_to_non_nullable
              as String,
      playerHeight: null == playerHeight
          ? _value.playerHeight
          : playerHeight // ignore: cast_nullable_to_non_nullable
              as String,
      playerWeight: null == playerWeight
          ? _value.playerWeight
          : playerWeight // ignore: cast_nullable_to_non_nullable
              as String,
      playerNumber: null == playerNumber
          ? _value.playerNumber
          : playerNumber // ignore: cast_nullable_to_non_nullable
              as String,
      stats: null == stats
          ? _value.stats
          : stats // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$RoasterDataImplCopyWith<$Res>
    implements $RoasterDataCopyWith<$Res> {
  factory _$$RoasterDataImplCopyWith(
          _$RoasterDataImpl value, $Res Function(_$RoasterDataImpl) then) =
      __$$RoasterDataImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String playerId,
      String playerName,
      String position,
      String imageUrl,
      String playerHeight,
      String playerWeight,
      String playerNumber,
      Map<String, dynamic> stats});
}

/// @nodoc
class __$$RoasterDataImplCopyWithImpl<$Res>
    extends _$RoasterDataCopyWithImpl<$Res, _$RoasterDataImpl>
    implements _$$RoasterDataImplCopyWith<$Res> {
  __$$RoasterDataImplCopyWithImpl(
      _$RoasterDataImpl _value, $Res Function(_$RoasterDataImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? playerId = null,
    Object? playerName = null,
    Object? position = null,
    Object? imageUrl = null,
    Object? playerHeight = null,
    Object? playerWeight = null,
    Object? playerNumber = null,
    Object? stats = null,
  }) {
    return _then(_$RoasterDataImpl(
      playerId: null == playerId
          ? _value.playerId
          : playerId // ignore: cast_nullable_to_non_nullable
              as String,
      playerName: null == playerName
          ? _value.playerName
          : playerName // ignore: cast_nullable_to_non_nullable
              as String,
      position: null == position
          ? _value.position
          : position // ignore: cast_nullable_to_non_nullable
              as String,
      imageUrl: null == imageUrl
          ? _value.imageUrl
          : imageUrl // ignore: cast_nullable_to_non_nullable
              as String,
      playerHeight: null == playerHeight
          ? _value.playerHeight
          : playerHeight // ignore: cast_nullable_to_non_nullable
              as String,
      playerWeight: null == playerWeight
          ? _value.playerWeight
          : playerWeight // ignore: cast_nullable_to_non_nullable
              as String,
      playerNumber: null == playerNumber
          ? _value.playerNumber
          : playerNumber // ignore: cast_nullable_to_non_nullable
              as String,
      stats: null == stats
          ? _value._stats
          : stats // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$RoasterDataImpl implements _RoasterData {
  const _$RoasterDataImpl(
      {required this.playerId,
      required this.playerName,
      required this.position,
      required this.imageUrl,
      required this.playerHeight,
      required this.playerWeight,
      required this.playerNumber,
      required final Map<String, dynamic> stats})
      : _stats = stats;

  factory _$RoasterDataImpl.fromJson(Map<String, dynamic> json) =>
      _$$RoasterDataImplFromJson(json);

  @override
  final String playerId;
  @override
  final String playerName;
  @override
  final String position;
  @override
  final String imageUrl;
  @override
  final String playerHeight;
  @override
  final String playerWeight;
  @override
  final String playerNumber;
  final Map<String, dynamic> _stats;
  @override
  Map<String, dynamic> get stats {
    if (_stats is EqualUnmodifiableMapView) return _stats;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_stats);
  }

  @override
  String toString() {
    return 'RoasterData(playerId: $playerId, playerName: $playerName, position: $position, imageUrl: $imageUrl, playerHeight: $playerHeight, playerWeight: $playerWeight, playerNumber: $playerNumber, stats: $stats)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RoasterDataImpl &&
            (identical(other.playerId, playerId) ||
                other.playerId == playerId) &&
            (identical(other.playerName, playerName) ||
                other.playerName == playerName) &&
            (identical(other.position, position) ||
                other.position == position) &&
            (identical(other.imageUrl, imageUrl) ||
                other.imageUrl == imageUrl) &&
            (identical(other.playerHeight, playerHeight) ||
                other.playerHeight == playerHeight) &&
            (identical(other.playerWeight, playerWeight) ||
                other.playerWeight == playerWeight) &&
            (identical(other.playerNumber, playerNumber) ||
                other.playerNumber == playerNumber) &&
            const DeepCollectionEquality().equals(other._stats, _stats));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      playerId,
      playerName,
      position,
      imageUrl,
      playerHeight,
      playerWeight,
      playerNumber,
      const DeepCollectionEquality().hash(_stats));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$RoasterDataImplCopyWith<_$RoasterDataImpl> get copyWith =>
      __$$RoasterDataImplCopyWithImpl<_$RoasterDataImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$RoasterDataImplToJson(
      this,
    );
  }
}

abstract class _RoasterData implements RoasterData {
  const factory _RoasterData(
      {required final String playerId,
      required final String playerName,
      required final String position,
      required final String imageUrl,
      required final String playerHeight,
      required final String playerWeight,
      required final String playerNumber,
      required final Map<String, dynamic> stats}) = _$RoasterDataImpl;

  factory _RoasterData.fromJson(Map<String, dynamic> json) =
      _$RoasterDataImpl.fromJson;

  @override
  String get playerId;
  @override
  String get playerName;
  @override
  String get position;
  @override
  String get imageUrl;
  @override
  String get playerHeight;
  @override
  String get playerWeight;
  @override
  String get playerNumber;
  @override
  Map<String, dynamic> get stats;
  @override
  @JsonKey(ignore: true)
  _$$RoasterDataImplCopyWith<_$RoasterDataImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
