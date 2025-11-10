// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'pickupaddress.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

PickupAddress _$PickupAddressFromJson(Map<String, dynamic> json) {
  return _PickupAddress.fromJson(json);
}

/// @nodoc
mixin _$PickupAddress {
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get locality => throw _privateConstructorUsedError;
  String get city => throw _privateConstructorUsedError;
  String get country => throw _privateConstructorUsedError;
  String get phone => throw _privateConstructorUsedError;
  double? get latitude => throw _privateConstructorUsedError;
  double? get longitude => throw _privateConstructorUsedError;
  bool? get isDefault => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $PickupAddressCopyWith<PickupAddress> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PickupAddressCopyWith<$Res> {
  factory $PickupAddressCopyWith(
          PickupAddress value, $Res Function(PickupAddress) then) =
      _$PickupAddressCopyWithImpl<$Res, PickupAddress>;
  @useResult
  $Res call(
      {String id,
      String name,
      String locality,
      String city,
      String country,
      String phone,
      double? latitude,
      double? longitude,
      bool? isDefault});
}

/// @nodoc
class _$PickupAddressCopyWithImpl<$Res, $Val extends PickupAddress>
    implements $PickupAddressCopyWith<$Res> {
  _$PickupAddressCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? locality = null,
    Object? city = null,
    Object? country = null,
    Object? phone = null,
    Object? latitude = freezed,
    Object? longitude = freezed,
    Object? isDefault = freezed,
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
      locality: null == locality
          ? _value.locality
          : locality // ignore: cast_nullable_to_non_nullable
              as String,
      city: null == city
          ? _value.city
          : city // ignore: cast_nullable_to_non_nullable
              as String,
      country: null == country
          ? _value.country
          : country // ignore: cast_nullable_to_non_nullable
              as String,
      phone: null == phone
          ? _value.phone
          : phone // ignore: cast_nullable_to_non_nullable
              as String,
      latitude: freezed == latitude
          ? _value.latitude
          : latitude // ignore: cast_nullable_to_non_nullable
              as double?,
      longitude: freezed == longitude
          ? _value.longitude
          : longitude // ignore: cast_nullable_to_non_nullable
              as double?,
      isDefault: freezed == isDefault
          ? _value.isDefault
          : isDefault // ignore: cast_nullable_to_non_nullable
              as bool?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$PickupAddressImplCopyWith<$Res>
    implements $PickupAddressCopyWith<$Res> {
  factory _$$PickupAddressImplCopyWith(
          _$PickupAddressImpl value, $Res Function(_$PickupAddressImpl) then) =
      __$$PickupAddressImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String name,
      String locality,
      String city,
      String country,
      String phone,
      double? latitude,
      double? longitude,
      bool? isDefault});
}

/// @nodoc
class __$$PickupAddressImplCopyWithImpl<$Res>
    extends _$PickupAddressCopyWithImpl<$Res, _$PickupAddressImpl>
    implements _$$PickupAddressImplCopyWith<$Res> {
  __$$PickupAddressImplCopyWithImpl(
      _$PickupAddressImpl _value, $Res Function(_$PickupAddressImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? locality = null,
    Object? city = null,
    Object? country = null,
    Object? phone = null,
    Object? latitude = freezed,
    Object? longitude = freezed,
    Object? isDefault = freezed,
  }) {
    return _then(_$PickupAddressImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      locality: null == locality
          ? _value.locality
          : locality // ignore: cast_nullable_to_non_nullable
              as String,
      city: null == city
          ? _value.city
          : city // ignore: cast_nullable_to_non_nullable
              as String,
      country: null == country
          ? _value.country
          : country // ignore: cast_nullable_to_non_nullable
              as String,
      phone: null == phone
          ? _value.phone
          : phone // ignore: cast_nullable_to_non_nullable
              as String,
      latitude: freezed == latitude
          ? _value.latitude
          : latitude // ignore: cast_nullable_to_non_nullable
              as double?,
      longitude: freezed == longitude
          ? _value.longitude
          : longitude // ignore: cast_nullable_to_non_nullable
              as double?,
      isDefault: freezed == isDefault
          ? _value.isDefault
          : isDefault // ignore: cast_nullable_to_non_nullable
              as bool?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$PickupAddressImpl implements _PickupAddress {
  const _$PickupAddressImpl(
      {required this.id,
      required this.name,
      required this.locality,
      required this.city,
      required this.country,
      required this.phone,
      required this.latitude,
      required this.longitude,
      required this.isDefault});

  factory _$PickupAddressImpl.fromJson(Map<String, dynamic> json) =>
      _$$PickupAddressImplFromJson(json);

  @override
  final String id;
  @override
  final String name;
  @override
  final String locality;
  @override
  final String city;
  @override
  final String country;
  @override
  final String phone;
  @override
  final double? latitude;
  @override
  final double? longitude;
  @override
  final bool? isDefault;

  @override
  String toString() {
    return 'PickupAddress(id: $id, name: $name, locality: $locality, city: $city, country: $country, phone: $phone, latitude: $latitude, longitude: $longitude, isDefault: $isDefault)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PickupAddressImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.locality, locality) ||
                other.locality == locality) &&
            (identical(other.city, city) || other.city == city) &&
            (identical(other.country, country) || other.country == country) &&
            (identical(other.phone, phone) || other.phone == phone) &&
            (identical(other.latitude, latitude) ||
                other.latitude == latitude) &&
            (identical(other.longitude, longitude) ||
                other.longitude == longitude) &&
            (identical(other.isDefault, isDefault) ||
                other.isDefault == isDefault));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, name, locality, city,
      country, phone, latitude, longitude, isDefault);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$PickupAddressImplCopyWith<_$PickupAddressImpl> get copyWith =>
      __$$PickupAddressImplCopyWithImpl<_$PickupAddressImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PickupAddressImplToJson(
      this,
    );
  }
}

abstract class _PickupAddress implements PickupAddress {
  const factory _PickupAddress(
      {required final String id,
      required final String name,
      required final String locality,
      required final String city,
      required final String country,
      required final String phone,
      required final double? latitude,
      required final double? longitude,
      required final bool? isDefault}) = _$PickupAddressImpl;

  factory _PickupAddress.fromJson(Map<String, dynamic> json) =
      _$PickupAddressImpl.fromJson;

  @override
  String get id;
  @override
  String get name;
  @override
  String get locality;
  @override
  String get city;
  @override
  String get country;
  @override
  String get phone;
  @override
  double? get latitude;
  @override
  double? get longitude;
  @override
  bool? get isDefault;
  @override
  @JsonKey(ignore: true)
  _$$PickupAddressImplCopyWith<_$PickupAddressImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
