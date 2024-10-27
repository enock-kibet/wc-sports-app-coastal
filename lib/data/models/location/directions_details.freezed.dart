// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'directions_details.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

DirectionDetailsInfo _$DirectionDetailsInfoFromJson(Map<String, dynamic> json) {
  return _DirectionDetailsInfo.fromJson(json);
}

/// @nodoc
mixin _$DirectionDetailsInfo {
  @JsonKey(name: "distance_value")
  int? get distanceValue => throw _privateConstructorUsedError;
  @JsonKey(name: "duration_value")
  int? get durationValue => throw _privateConstructorUsedError;
  @JsonKey(name: "e_points")
  String? get ePoints => throw _privateConstructorUsedError;
  @JsonKey(name: "distance_text")
  String? get distanceText => throw _privateConstructorUsedError;
  @JsonKey(name: "duration_text")
  String? get durationText => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $DirectionDetailsInfoCopyWith<DirectionDetailsInfo> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DirectionDetailsInfoCopyWith<$Res> {
  factory $DirectionDetailsInfoCopyWith(DirectionDetailsInfo value,
          $Res Function(DirectionDetailsInfo) then) =
      _$DirectionDetailsInfoCopyWithImpl<$Res, DirectionDetailsInfo>;
  @useResult
  $Res call(
      {@JsonKey(name: "distance_value") int? distanceValue,
      @JsonKey(name: "duration_value") int? durationValue,
      @JsonKey(name: "e_points") String? ePoints,
      @JsonKey(name: "distance_text") String? distanceText,
      @JsonKey(name: "duration_text") String? durationText});
}

/// @nodoc
class _$DirectionDetailsInfoCopyWithImpl<$Res,
        $Val extends DirectionDetailsInfo>
    implements $DirectionDetailsInfoCopyWith<$Res> {
  _$DirectionDetailsInfoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? distanceValue = freezed,
    Object? durationValue = freezed,
    Object? ePoints = freezed,
    Object? distanceText = freezed,
    Object? durationText = freezed,
  }) {
    return _then(_value.copyWith(
      distanceValue: freezed == distanceValue
          ? _value.distanceValue
          : distanceValue // ignore: cast_nullable_to_non_nullable
              as int?,
      durationValue: freezed == durationValue
          ? _value.durationValue
          : durationValue // ignore: cast_nullable_to_non_nullable
              as int?,
      ePoints: freezed == ePoints
          ? _value.ePoints
          : ePoints // ignore: cast_nullable_to_non_nullable
              as String?,
      distanceText: freezed == distanceText
          ? _value.distanceText
          : distanceText // ignore: cast_nullable_to_non_nullable
              as String?,
      durationText: freezed == durationText
          ? _value.durationText
          : durationText // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$DirectionDetailsInfoImplCopyWith<$Res>
    implements $DirectionDetailsInfoCopyWith<$Res> {
  factory _$$DirectionDetailsInfoImplCopyWith(_$DirectionDetailsInfoImpl value,
          $Res Function(_$DirectionDetailsInfoImpl) then) =
      __$$DirectionDetailsInfoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: "distance_value") int? distanceValue,
      @JsonKey(name: "duration_value") int? durationValue,
      @JsonKey(name: "e_points") String? ePoints,
      @JsonKey(name: "distance_text") String? distanceText,
      @JsonKey(name: "duration_text") String? durationText});
}

/// @nodoc
class __$$DirectionDetailsInfoImplCopyWithImpl<$Res>
    extends _$DirectionDetailsInfoCopyWithImpl<$Res, _$DirectionDetailsInfoImpl>
    implements _$$DirectionDetailsInfoImplCopyWith<$Res> {
  __$$DirectionDetailsInfoImplCopyWithImpl(_$DirectionDetailsInfoImpl _value,
      $Res Function(_$DirectionDetailsInfoImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? distanceValue = freezed,
    Object? durationValue = freezed,
    Object? ePoints = freezed,
    Object? distanceText = freezed,
    Object? durationText = freezed,
  }) {
    return _then(_$DirectionDetailsInfoImpl(
      distanceValue: freezed == distanceValue
          ? _value.distanceValue
          : distanceValue // ignore: cast_nullable_to_non_nullable
              as int?,
      durationValue: freezed == durationValue
          ? _value.durationValue
          : durationValue // ignore: cast_nullable_to_non_nullable
              as int?,
      ePoints: freezed == ePoints
          ? _value.ePoints
          : ePoints // ignore: cast_nullable_to_non_nullable
              as String?,
      distanceText: freezed == distanceText
          ? _value.distanceText
          : distanceText // ignore: cast_nullable_to_non_nullable
              as String?,
      durationText: freezed == durationText
          ? _value.durationText
          : durationText // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$DirectionDetailsInfoImpl implements _DirectionDetailsInfo {
  const _$DirectionDetailsInfoImpl(
      {@JsonKey(name: "distance_value") this.distanceValue,
      @JsonKey(name: "duration_value") this.durationValue,
      @JsonKey(name: "e_points") this.ePoints,
      @JsonKey(name: "distance_text") this.distanceText,
      @JsonKey(name: "duration_text") this.durationText});

  factory _$DirectionDetailsInfoImpl.fromJson(Map<String, dynamic> json) =>
      _$$DirectionDetailsInfoImplFromJson(json);

  @override
  @JsonKey(name: "distance_value")
  final int? distanceValue;
  @override
  @JsonKey(name: "duration_value")
  final int? durationValue;
  @override
  @JsonKey(name: "e_points")
  final String? ePoints;
  @override
  @JsonKey(name: "distance_text")
  final String? distanceText;
  @override
  @JsonKey(name: "duration_text")
  final String? durationText;

  @override
  String toString() {
    return 'DirectionDetailsInfo(distanceValue: $distanceValue, durationValue: $durationValue, ePoints: $ePoints, distanceText: $distanceText, durationText: $durationText)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DirectionDetailsInfoImpl &&
            (identical(other.distanceValue, distanceValue) ||
                other.distanceValue == distanceValue) &&
            (identical(other.durationValue, durationValue) ||
                other.durationValue == durationValue) &&
            (identical(other.ePoints, ePoints) || other.ePoints == ePoints) &&
            (identical(other.distanceText, distanceText) ||
                other.distanceText == distanceText) &&
            (identical(other.durationText, durationText) ||
                other.durationText == durationText));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, distanceValue, durationValue,
      ePoints, distanceText, durationText);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$DirectionDetailsInfoImplCopyWith<_$DirectionDetailsInfoImpl>
      get copyWith =>
          __$$DirectionDetailsInfoImplCopyWithImpl<_$DirectionDetailsInfoImpl>(
              this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$DirectionDetailsInfoImplToJson(
      this,
    );
  }
}

abstract class _DirectionDetailsInfo implements DirectionDetailsInfo {
  const factory _DirectionDetailsInfo(
          {@JsonKey(name: "distance_value") final int? distanceValue,
          @JsonKey(name: "duration_value") final int? durationValue,
          @JsonKey(name: "e_points") final String? ePoints,
          @JsonKey(name: "distance_text") final String? distanceText,
          @JsonKey(name: "duration_text") final String? durationText}) =
      _$DirectionDetailsInfoImpl;

  factory _DirectionDetailsInfo.fromJson(Map<String, dynamic> json) =
      _$DirectionDetailsInfoImpl.fromJson;

  @override
  @JsonKey(name: "distance_value")
  int? get distanceValue;
  @override
  @JsonKey(name: "duration_value")
  int? get durationValue;
  @override
  @JsonKey(name: "e_points")
  String? get ePoints;
  @override
  @JsonKey(name: "distance_text")
  String? get distanceText;
  @override
  @JsonKey(name: "duration_text")
  String? get durationText;
  @override
  @JsonKey(ignore: true)
  _$$DirectionDetailsInfoImplCopyWith<_$DirectionDetailsInfoImpl>
      get copyWith => throw _privateConstructorUsedError;
}
