// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'player.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

PlayerProfileData _$PlayerProfileDataFromJson(Map<String, dynamic> json) {
  return _PlayerProfileData.fromJson(json);
}

/// @nodoc
mixin _$PlayerProfileData {
  String get name => throw _privateConstructorUsedError;
  String get age => throw _privateConstructorUsedError;
  String get position => throw _privateConstructorUsedError;
  String get imageUrl => throw _privateConstructorUsedError;
  String get height =>
      throw _privateConstructorUsedError; // extracted from profile
  String get weight =>
      throw _privateConstructorUsedError; // extracted from profile
  String get experience => throw _privateConstructorUsedError;
  @JsonKey(name: 'jerseyNumber')
  String get jerseyNumber => throw _privateConstructorUsedError;
  @JsonKey(name: 'homeTown')
  String get homeTown => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $PlayerProfileDataCopyWith<PlayerProfileData> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PlayerProfileDataCopyWith<$Res> {
  factory $PlayerProfileDataCopyWith(
          PlayerProfileData value, $Res Function(PlayerProfileData) then) =
      _$PlayerProfileDataCopyWithImpl<$Res, PlayerProfileData>;
  @useResult
  $Res call(
      {String name,
      String age,
      String position,
      String imageUrl,
      String height,
      String weight,
      String experience,
      @JsonKey(name: 'jerseyNumber') String jerseyNumber,
      @JsonKey(name: 'homeTown') String homeTown});
}

/// @nodoc
class _$PlayerProfileDataCopyWithImpl<$Res, $Val extends PlayerProfileData>
    implements $PlayerProfileDataCopyWith<$Res> {
  _$PlayerProfileDataCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? age = null,
    Object? position = null,
    Object? imageUrl = null,
    Object? height = null,
    Object? weight = null,
    Object? experience = null,
    Object? jerseyNumber = null,
    Object? homeTown = null,
  }) {
    return _then(_value.copyWith(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      age: null == age
          ? _value.age
          : age // ignore: cast_nullable_to_non_nullable
              as String,
      position: null == position
          ? _value.position
          : position // ignore: cast_nullable_to_non_nullable
              as String,
      imageUrl: null == imageUrl
          ? _value.imageUrl
          : imageUrl // ignore: cast_nullable_to_non_nullable
              as String,
      height: null == height
          ? _value.height
          : height // ignore: cast_nullable_to_non_nullable
              as String,
      weight: null == weight
          ? _value.weight
          : weight // ignore: cast_nullable_to_non_nullable
              as String,
      experience: null == experience
          ? _value.experience
          : experience // ignore: cast_nullable_to_non_nullable
              as String,
      jerseyNumber: null == jerseyNumber
          ? _value.jerseyNumber
          : jerseyNumber // ignore: cast_nullable_to_non_nullable
              as String,
      homeTown: null == homeTown
          ? _value.homeTown
          : homeTown // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$PlayerProfileDataImplCopyWith<$Res>
    implements $PlayerProfileDataCopyWith<$Res> {
  factory _$$PlayerProfileDataImplCopyWith(_$PlayerProfileDataImpl value,
          $Res Function(_$PlayerProfileDataImpl) then) =
      __$$PlayerProfileDataImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String name,
      String age,
      String position,
      String imageUrl,
      String height,
      String weight,
      String experience,
      @JsonKey(name: 'jerseyNumber') String jerseyNumber,
      @JsonKey(name: 'homeTown') String homeTown});
}

/// @nodoc
class __$$PlayerProfileDataImplCopyWithImpl<$Res>
    extends _$PlayerProfileDataCopyWithImpl<$Res, _$PlayerProfileDataImpl>
    implements _$$PlayerProfileDataImplCopyWith<$Res> {
  __$$PlayerProfileDataImplCopyWithImpl(_$PlayerProfileDataImpl _value,
      $Res Function(_$PlayerProfileDataImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? age = null,
    Object? position = null,
    Object? imageUrl = null,
    Object? height = null,
    Object? weight = null,
    Object? experience = null,
    Object? jerseyNumber = null,
    Object? homeTown = null,
  }) {
    return _then(_$PlayerProfileDataImpl(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      age: null == age
          ? _value.age
          : age // ignore: cast_nullable_to_non_nullable
              as String,
      position: null == position
          ? _value.position
          : position // ignore: cast_nullable_to_non_nullable
              as String,
      imageUrl: null == imageUrl
          ? _value.imageUrl
          : imageUrl // ignore: cast_nullable_to_non_nullable
              as String,
      height: null == height
          ? _value.height
          : height // ignore: cast_nullable_to_non_nullable
              as String,
      weight: null == weight
          ? _value.weight
          : weight // ignore: cast_nullable_to_non_nullable
              as String,
      experience: null == experience
          ? _value.experience
          : experience // ignore: cast_nullable_to_non_nullable
              as String,
      jerseyNumber: null == jerseyNumber
          ? _value.jerseyNumber
          : jerseyNumber // ignore: cast_nullable_to_non_nullable
              as String,
      homeTown: null == homeTown
          ? _value.homeTown
          : homeTown // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$PlayerProfileDataImpl implements _PlayerProfileData {
  const _$PlayerProfileDataImpl(
      {required this.name,
      required this.age,
      required this.position,
      required this.imageUrl,
      required this.height,
      required this.weight,
      required this.experience,
      @JsonKey(name: 'jerseyNumber') required this.jerseyNumber,
      @JsonKey(name: 'homeTown') required this.homeTown});

  factory _$PlayerProfileDataImpl.fromJson(Map<String, dynamic> json) =>
      _$$PlayerProfileDataImplFromJson(json);

  @override
  final String name;
  @override
  final String age;
  @override
  final String position;
  @override
  final String imageUrl;
  @override
  final String height;
// extracted from profile
  @override
  final String weight;
// extracted from profile
  @override
  final String experience;
  @override
  @JsonKey(name: 'jerseyNumber')
  final String jerseyNumber;
  @override
  @JsonKey(name: 'homeTown')
  final String homeTown;

  @override
  String toString() {
    return 'PlayerProfileData(name: $name, age: $age, position: $position, imageUrl: $imageUrl, height: $height, weight: $weight, experience: $experience, jerseyNumber: $jerseyNumber, homeTown: $homeTown)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PlayerProfileDataImpl &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.age, age) || other.age == age) &&
            (identical(other.position, position) ||
                other.position == position) &&
            (identical(other.imageUrl, imageUrl) ||
                other.imageUrl == imageUrl) &&
            (identical(other.height, height) || other.height == height) &&
            (identical(other.weight, weight) || other.weight == weight) &&
            (identical(other.experience, experience) ||
                other.experience == experience) &&
            (identical(other.jerseyNumber, jerseyNumber) ||
                other.jerseyNumber == jerseyNumber) &&
            (identical(other.homeTown, homeTown) ||
                other.homeTown == homeTown));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, name, age, position, imageUrl,
      height, weight, experience, jerseyNumber, homeTown);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$PlayerProfileDataImplCopyWith<_$PlayerProfileDataImpl> get copyWith =>
      __$$PlayerProfileDataImplCopyWithImpl<_$PlayerProfileDataImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PlayerProfileDataImplToJson(
      this,
    );
  }
}

abstract class _PlayerProfileData implements PlayerProfileData {
  const factory _PlayerProfileData(
          {required final String name,
          required final String age,
          required final String position,
          required final String imageUrl,
          required final String height,
          required final String weight,
          required final String experience,
          @JsonKey(name: 'jerseyNumber') required final String jerseyNumber,
          @JsonKey(name: 'homeTown') required final String homeTown}) =
      _$PlayerProfileDataImpl;

  factory _PlayerProfileData.fromJson(Map<String, dynamic> json) =
      _$PlayerProfileDataImpl.fromJson;

  @override
  String get name;
  @override
  String get age;
  @override
  String get position;
  @override
  String get imageUrl;
  @override
  String get height;
  @override // extracted from profile
  String get weight;
  @override // extracted from profile
  String get experience;
  @override
  @JsonKey(name: 'jerseyNumber')
  String get jerseyNumber;
  @override
  @JsonKey(name: 'homeTown')
  String get homeTown;
  @override
  @JsonKey(ignore: true)
  _$$PlayerProfileDataImplCopyWith<_$PlayerProfileDataImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
