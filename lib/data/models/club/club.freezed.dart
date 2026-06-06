// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'club.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

ClubRoasterResponse _$ClubRoasterResponseFromJson(Map<String, dynamic> json) {
  return _ClubRoasterResponse.fromJson(json);
}

/// @nodoc
mixin _$ClubRoasterResponse {
  List<ClubRoasterData> get data => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ClubRoasterResponseCopyWith<ClubRoasterResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ClubRoasterResponseCopyWith<$Res> {
  factory $ClubRoasterResponseCopyWith(
          ClubRoasterResponse value, $Res Function(ClubRoasterResponse) then) =
      _$ClubRoasterResponseCopyWithImpl<$Res, ClubRoasterResponse>;
  @useResult
  $Res call({List<ClubRoasterData> data});
}

/// @nodoc
class _$ClubRoasterResponseCopyWithImpl<$Res, $Val extends ClubRoasterResponse>
    implements $ClubRoasterResponseCopyWith<$Res> {
  _$ClubRoasterResponseCopyWithImpl(this._value, this._then);

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
              as List<ClubRoasterData>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ClubRoasterResponseImplCopyWith<$Res>
    implements $ClubRoasterResponseCopyWith<$Res> {
  factory _$$ClubRoasterResponseImplCopyWith(_$ClubRoasterResponseImpl value,
          $Res Function(_$ClubRoasterResponseImpl) then) =
      __$$ClubRoasterResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<ClubRoasterData> data});
}

/// @nodoc
class __$$ClubRoasterResponseImplCopyWithImpl<$Res>
    extends _$ClubRoasterResponseCopyWithImpl<$Res, _$ClubRoasterResponseImpl>
    implements _$$ClubRoasterResponseImplCopyWith<$Res> {
  __$$ClubRoasterResponseImplCopyWithImpl(_$ClubRoasterResponseImpl _value,
      $Res Function(_$ClubRoasterResponseImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? data = null,
  }) {
    return _then(_$ClubRoasterResponseImpl(
      data: null == data
          ? _value._data
          : data // ignore: cast_nullable_to_non_nullable
              as List<ClubRoasterData>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ClubRoasterResponseImpl implements _ClubRoasterResponse {
  const _$ClubRoasterResponseImpl({required final List<ClubRoasterData> data})
      : _data = data;

  factory _$ClubRoasterResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$ClubRoasterResponseImplFromJson(json);

  final List<ClubRoasterData> _data;
  @override
  List<ClubRoasterData> get data {
    if (_data is EqualUnmodifiableListView) return _data;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_data);
  }

  @override
  String toString() {
    return 'ClubRoasterResponse(data: $data)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ClubRoasterResponseImpl &&
            const DeepCollectionEquality().equals(other._data, _data));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_data));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ClubRoasterResponseImplCopyWith<_$ClubRoasterResponseImpl> get copyWith =>
      __$$ClubRoasterResponseImplCopyWithImpl<_$ClubRoasterResponseImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ClubRoasterResponseImplToJson(
      this,
    );
  }
}

abstract class _ClubRoasterResponse implements ClubRoasterResponse {
  const factory _ClubRoasterResponse(
      {required final List<ClubRoasterData> data}) = _$ClubRoasterResponseImpl;

  factory _ClubRoasterResponse.fromJson(Map<String, dynamic> json) =
      _$ClubRoasterResponseImpl.fromJson;

  @override
  List<ClubRoasterData> get data;
  @override
  @JsonKey(ignore: true)
  _$$ClubRoasterResponseImplCopyWith<_$ClubRoasterResponseImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

ClubRoasterData _$ClubRoasterDataFromJson(Map<String, dynamic> json) {
  return _ClubRoasterData.fromJson(json);
}

/// @nodoc
mixin _$ClubRoasterData {
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get leagueId => throw _privateConstructorUsedError;
  String? get imageUrl => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ClubRoasterDataCopyWith<ClubRoasterData> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ClubRoasterDataCopyWith<$Res> {
  factory $ClubRoasterDataCopyWith(
          ClubRoasterData value, $Res Function(ClubRoasterData) then) =
      _$ClubRoasterDataCopyWithImpl<$Res, ClubRoasterData>;
  @useResult
  $Res call({String id, String name, String leagueId, String? imageUrl});
}

/// @nodoc
class _$ClubRoasterDataCopyWithImpl<$Res, $Val extends ClubRoasterData>
    implements $ClubRoasterDataCopyWith<$Res> {
  _$ClubRoasterDataCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? leagueId = null,
    Object? imageUrl = freezed,
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
      leagueId: null == leagueId
          ? _value.leagueId
          : leagueId // ignore: cast_nullable_to_non_nullable
              as String,
      imageUrl: freezed == imageUrl
          ? _value.imageUrl
          : imageUrl // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ClubRoasterDataImplCopyWith<$Res>
    implements $ClubRoasterDataCopyWith<$Res> {
  factory _$$ClubRoasterDataImplCopyWith(_$ClubRoasterDataImpl value,
          $Res Function(_$ClubRoasterDataImpl) then) =
      __$$ClubRoasterDataImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String id, String name, String leagueId, String? imageUrl});
}

/// @nodoc
class __$$ClubRoasterDataImplCopyWithImpl<$Res>
    extends _$ClubRoasterDataCopyWithImpl<$Res, _$ClubRoasterDataImpl>
    implements _$$ClubRoasterDataImplCopyWith<$Res> {
  __$$ClubRoasterDataImplCopyWithImpl(
      _$ClubRoasterDataImpl _value, $Res Function(_$ClubRoasterDataImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? leagueId = null,
    Object? imageUrl = freezed,
  }) {
    return _then(_$ClubRoasterDataImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      leagueId: null == leagueId
          ? _value.leagueId
          : leagueId // ignore: cast_nullable_to_non_nullable
              as String,
      imageUrl: freezed == imageUrl
          ? _value.imageUrl
          : imageUrl // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ClubRoasterDataImpl implements _ClubRoasterData {
  const _$ClubRoasterDataImpl(
      {required this.id,
      required this.name,
      required this.leagueId,
      this.imageUrl});

  factory _$ClubRoasterDataImpl.fromJson(Map<String, dynamic> json) =>
      _$$ClubRoasterDataImplFromJson(json);

  @override
  final String id;
  @override
  final String name;
  @override
  final String leagueId;
  @override
  final String? imageUrl;

  @override
  String toString() {
    return 'ClubRoasterData(id: $id, name: $name, leagueId: $leagueId, imageUrl: $imageUrl)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ClubRoasterDataImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.leagueId, leagueId) ||
                other.leagueId == leagueId) &&
            (identical(other.imageUrl, imageUrl) ||
                other.imageUrl == imageUrl));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, name, leagueId, imageUrl);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ClubRoasterDataImplCopyWith<_$ClubRoasterDataImpl> get copyWith =>
      __$$ClubRoasterDataImplCopyWithImpl<_$ClubRoasterDataImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ClubRoasterDataImplToJson(
      this,
    );
  }
}

abstract class _ClubRoasterData implements ClubRoasterData {
  const factory _ClubRoasterData(
      {required final String id,
      required final String name,
      required final String leagueId,
      final String? imageUrl}) = _$ClubRoasterDataImpl;

  factory _ClubRoasterData.fromJson(Map<String, dynamic> json) =
      _$ClubRoasterDataImpl.fromJson;

  @override
  String get id;
  @override
  String get name;
  @override
  String get leagueId;
  @override
  String? get imageUrl;
  @override
  @JsonKey(ignore: true)
  _$$ClubRoasterDataImplCopyWith<_$ClubRoasterDataImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
