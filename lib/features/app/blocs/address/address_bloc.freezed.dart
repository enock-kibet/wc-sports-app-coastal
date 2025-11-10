// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'address_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$AddressEvent {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(dynamic request) getAddresses,
    required TResult Function() getPickupAddresses,
    required TResult Function(dynamic request) addAddress,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(dynamic request)? getAddresses,
    TResult? Function()? getPickupAddresses,
    TResult? Function(dynamic request)? addAddress,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(dynamic request)? getAddresses,
    TResult Function()? getPickupAddresses,
    TResult Function(dynamic request)? addAddress,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_AddressFetchedCart value) getAddresses,
    required TResult Function(_PickupAddressFetch value) getPickupAddresses,
    required TResult Function(_AddressAdd value) addAddress,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_AddressFetchedCart value)? getAddresses,
    TResult? Function(_PickupAddressFetch value)? getPickupAddresses,
    TResult? Function(_AddressAdd value)? addAddress,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_AddressFetchedCart value)? getAddresses,
    TResult Function(_PickupAddressFetch value)? getPickupAddresses,
    TResult Function(_AddressAdd value)? addAddress,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AddressEventCopyWith<$Res> {
  factory $AddressEventCopyWith(
          AddressEvent value, $Res Function(AddressEvent) then) =
      _$AddressEventCopyWithImpl<$Res, AddressEvent>;
}

/// @nodoc
class _$AddressEventCopyWithImpl<$Res, $Val extends AddressEvent>
    implements $AddressEventCopyWith<$Res> {
  _$AddressEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;
}

/// @nodoc
abstract class _$$AddressFetchedCartImplCopyWith<$Res> {
  factory _$$AddressFetchedCartImplCopyWith(_$AddressFetchedCartImpl value,
          $Res Function(_$AddressFetchedCartImpl) then) =
      __$$AddressFetchedCartImplCopyWithImpl<$Res>;
  @useResult
  $Res call({dynamic request});
}

/// @nodoc
class __$$AddressFetchedCartImplCopyWithImpl<$Res>
    extends _$AddressEventCopyWithImpl<$Res, _$AddressFetchedCartImpl>
    implements _$$AddressFetchedCartImplCopyWith<$Res> {
  __$$AddressFetchedCartImplCopyWithImpl(_$AddressFetchedCartImpl _value,
      $Res Function(_$AddressFetchedCartImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? request = freezed,
  }) {
    return _then(_$AddressFetchedCartImpl(
      request: freezed == request
          ? _value.request
          : request // ignore: cast_nullable_to_non_nullable
              as dynamic,
    ));
  }
}

/// @nodoc

class _$AddressFetchedCartImpl implements _AddressFetchedCart {
  const _$AddressFetchedCartImpl({required this.request});

  @override
  final dynamic request;

  @override
  String toString() {
    return 'AddressEvent.getAddresses(request: $request)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AddressFetchedCartImpl &&
            const DeepCollectionEquality().equals(other.request, request));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(request));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$AddressFetchedCartImplCopyWith<_$AddressFetchedCartImpl> get copyWith =>
      __$$AddressFetchedCartImplCopyWithImpl<_$AddressFetchedCartImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(dynamic request) getAddresses,
    required TResult Function() getPickupAddresses,
    required TResult Function(dynamic request) addAddress,
  }) {
    return getAddresses(request);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(dynamic request)? getAddresses,
    TResult? Function()? getPickupAddresses,
    TResult? Function(dynamic request)? addAddress,
  }) {
    return getAddresses?.call(request);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(dynamic request)? getAddresses,
    TResult Function()? getPickupAddresses,
    TResult Function(dynamic request)? addAddress,
    required TResult orElse(),
  }) {
    if (getAddresses != null) {
      return getAddresses(request);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_AddressFetchedCart value) getAddresses,
    required TResult Function(_PickupAddressFetch value) getPickupAddresses,
    required TResult Function(_AddressAdd value) addAddress,
  }) {
    return getAddresses(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_AddressFetchedCart value)? getAddresses,
    TResult? Function(_PickupAddressFetch value)? getPickupAddresses,
    TResult? Function(_AddressAdd value)? addAddress,
  }) {
    return getAddresses?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_AddressFetchedCart value)? getAddresses,
    TResult Function(_PickupAddressFetch value)? getPickupAddresses,
    TResult Function(_AddressAdd value)? addAddress,
    required TResult orElse(),
  }) {
    if (getAddresses != null) {
      return getAddresses(this);
    }
    return orElse();
  }
}

abstract class _AddressFetchedCart implements AddressEvent {
  const factory _AddressFetchedCart({required final dynamic request}) =
      _$AddressFetchedCartImpl;

  dynamic get request;
  @JsonKey(ignore: true)
  _$$AddressFetchedCartImplCopyWith<_$AddressFetchedCartImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$PickupAddressFetchImplCopyWith<$Res> {
  factory _$$PickupAddressFetchImplCopyWith(_$PickupAddressFetchImpl value,
          $Res Function(_$PickupAddressFetchImpl) then) =
      __$$PickupAddressFetchImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$PickupAddressFetchImplCopyWithImpl<$Res>
    extends _$AddressEventCopyWithImpl<$Res, _$PickupAddressFetchImpl>
    implements _$$PickupAddressFetchImplCopyWith<$Res> {
  __$$PickupAddressFetchImplCopyWithImpl(_$PickupAddressFetchImpl _value,
      $Res Function(_$PickupAddressFetchImpl) _then)
      : super(_value, _then);
}

/// @nodoc

class _$PickupAddressFetchImpl implements _PickupAddressFetch {
  const _$PickupAddressFetchImpl();

  @override
  String toString() {
    return 'AddressEvent.getPickupAddresses()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$PickupAddressFetchImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(dynamic request) getAddresses,
    required TResult Function() getPickupAddresses,
    required TResult Function(dynamic request) addAddress,
  }) {
    return getPickupAddresses();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(dynamic request)? getAddresses,
    TResult? Function()? getPickupAddresses,
    TResult? Function(dynamic request)? addAddress,
  }) {
    return getPickupAddresses?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(dynamic request)? getAddresses,
    TResult Function()? getPickupAddresses,
    TResult Function(dynamic request)? addAddress,
    required TResult orElse(),
  }) {
    if (getPickupAddresses != null) {
      return getPickupAddresses();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_AddressFetchedCart value) getAddresses,
    required TResult Function(_PickupAddressFetch value) getPickupAddresses,
    required TResult Function(_AddressAdd value) addAddress,
  }) {
    return getPickupAddresses(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_AddressFetchedCart value)? getAddresses,
    TResult? Function(_PickupAddressFetch value)? getPickupAddresses,
    TResult? Function(_AddressAdd value)? addAddress,
  }) {
    return getPickupAddresses?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_AddressFetchedCart value)? getAddresses,
    TResult Function(_PickupAddressFetch value)? getPickupAddresses,
    TResult Function(_AddressAdd value)? addAddress,
    required TResult orElse(),
  }) {
    if (getPickupAddresses != null) {
      return getPickupAddresses(this);
    }
    return orElse();
  }
}

abstract class _PickupAddressFetch implements AddressEvent {
  const factory _PickupAddressFetch() = _$PickupAddressFetchImpl;
}

/// @nodoc
abstract class _$$AddressAddImplCopyWith<$Res> {
  factory _$$AddressAddImplCopyWith(
          _$AddressAddImpl value, $Res Function(_$AddressAddImpl) then) =
      __$$AddressAddImplCopyWithImpl<$Res>;
  @useResult
  $Res call({dynamic request});
}

/// @nodoc
class __$$AddressAddImplCopyWithImpl<$Res>
    extends _$AddressEventCopyWithImpl<$Res, _$AddressAddImpl>
    implements _$$AddressAddImplCopyWith<$Res> {
  __$$AddressAddImplCopyWithImpl(
      _$AddressAddImpl _value, $Res Function(_$AddressAddImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? request = freezed,
  }) {
    return _then(_$AddressAddImpl(
      request: freezed == request
          ? _value.request
          : request // ignore: cast_nullable_to_non_nullable
              as dynamic,
    ));
  }
}

/// @nodoc

class _$AddressAddImpl implements _AddressAdd {
  const _$AddressAddImpl({required this.request});

  @override
  final dynamic request;

  @override
  String toString() {
    return 'AddressEvent.addAddress(request: $request)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AddressAddImpl &&
            const DeepCollectionEquality().equals(other.request, request));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(request));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$AddressAddImplCopyWith<_$AddressAddImpl> get copyWith =>
      __$$AddressAddImplCopyWithImpl<_$AddressAddImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(dynamic request) getAddresses,
    required TResult Function() getPickupAddresses,
    required TResult Function(dynamic request) addAddress,
  }) {
    return addAddress(request);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(dynamic request)? getAddresses,
    TResult? Function()? getPickupAddresses,
    TResult? Function(dynamic request)? addAddress,
  }) {
    return addAddress?.call(request);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(dynamic request)? getAddresses,
    TResult Function()? getPickupAddresses,
    TResult Function(dynamic request)? addAddress,
    required TResult orElse(),
  }) {
    if (addAddress != null) {
      return addAddress(request);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_AddressFetchedCart value) getAddresses,
    required TResult Function(_PickupAddressFetch value) getPickupAddresses,
    required TResult Function(_AddressAdd value) addAddress,
  }) {
    return addAddress(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_AddressFetchedCart value)? getAddresses,
    TResult? Function(_PickupAddressFetch value)? getPickupAddresses,
    TResult? Function(_AddressAdd value)? addAddress,
  }) {
    return addAddress?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_AddressFetchedCart value)? getAddresses,
    TResult Function(_PickupAddressFetch value)? getPickupAddresses,
    TResult Function(_AddressAdd value)? addAddress,
    required TResult orElse(),
  }) {
    if (addAddress != null) {
      return addAddress(this);
    }
    return orElse();
  }
}

abstract class _AddressAdd implements AddressEvent {
  const factory _AddressAdd({required final dynamic request}) =
      _$AddressAddImpl;

  dynamic get request;
  @JsonKey(ignore: true)
  _$$AddressAddImplCopyWith<_$AddressAddImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$AddressState {
  AddressStatus get status => throw _privateConstructorUsedError;
  Failure? get failure => throw _privateConstructorUsedError;
  String? get authorizationUrl => throw _privateConstructorUsedError;
  String? get addressId => throw _privateConstructorUsedError;
  List<Address> get data => throw _privateConstructorUsedError;
  List<PickupAddress> get pickupAddresses => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $AddressStateCopyWith<AddressState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AddressStateCopyWith<$Res> {
  factory $AddressStateCopyWith(
          AddressState value, $Res Function(AddressState) then) =
      _$AddressStateCopyWithImpl<$Res, AddressState>;
  @useResult
  $Res call(
      {AddressStatus status,
      Failure? failure,
      String? authorizationUrl,
      String? addressId,
      List<Address> data,
      List<PickupAddress> pickupAddresses});
}

/// @nodoc
class _$AddressStateCopyWithImpl<$Res, $Val extends AddressState>
    implements $AddressStateCopyWith<$Res> {
  _$AddressStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? failure = freezed,
    Object? authorizationUrl = freezed,
    Object? addressId = freezed,
    Object? data = null,
    Object? pickupAddresses = null,
  }) {
    return _then(_value.copyWith(
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as AddressStatus,
      failure: freezed == failure
          ? _value.failure
          : failure // ignore: cast_nullable_to_non_nullable
              as Failure?,
      authorizationUrl: freezed == authorizationUrl
          ? _value.authorizationUrl
          : authorizationUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      addressId: freezed == addressId
          ? _value.addressId
          : addressId // ignore: cast_nullable_to_non_nullable
              as String?,
      data: null == data
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as List<Address>,
      pickupAddresses: null == pickupAddresses
          ? _value.pickupAddresses
          : pickupAddresses // ignore: cast_nullable_to_non_nullable
              as List<PickupAddress>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$AddressStateImplCopyWith<$Res>
    implements $AddressStateCopyWith<$Res> {
  factory _$$AddressStateImplCopyWith(
          _$AddressStateImpl value, $Res Function(_$AddressStateImpl) then) =
      __$$AddressStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {AddressStatus status,
      Failure? failure,
      String? authorizationUrl,
      String? addressId,
      List<Address> data,
      List<PickupAddress> pickupAddresses});
}

/// @nodoc
class __$$AddressStateImplCopyWithImpl<$Res>
    extends _$AddressStateCopyWithImpl<$Res, _$AddressStateImpl>
    implements _$$AddressStateImplCopyWith<$Res> {
  __$$AddressStateImplCopyWithImpl(
      _$AddressStateImpl _value, $Res Function(_$AddressStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? failure = freezed,
    Object? authorizationUrl = freezed,
    Object? addressId = freezed,
    Object? data = null,
    Object? pickupAddresses = null,
  }) {
    return _then(_$AddressStateImpl(
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as AddressStatus,
      failure: freezed == failure
          ? _value.failure
          : failure // ignore: cast_nullable_to_non_nullable
              as Failure?,
      authorizationUrl: freezed == authorizationUrl
          ? _value.authorizationUrl
          : authorizationUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      addressId: freezed == addressId
          ? _value.addressId
          : addressId // ignore: cast_nullable_to_non_nullable
              as String?,
      data: null == data
          ? _value._data
          : data // ignore: cast_nullable_to_non_nullable
              as List<Address>,
      pickupAddresses: null == pickupAddresses
          ? _value._pickupAddresses
          : pickupAddresses // ignore: cast_nullable_to_non_nullable
              as List<PickupAddress>,
    ));
  }
}

/// @nodoc

class _$AddressStateImpl implements _AddressState {
  const _$AddressStateImpl(
      {this.status = AddressStatus.initial,
      this.failure,
      this.authorizationUrl,
      this.addressId,
      final List<Address> data = const [],
      final List<PickupAddress> pickupAddresses = const []})
      : _data = data,
        _pickupAddresses = pickupAddresses;

  @override
  @JsonKey()
  final AddressStatus status;
  @override
  final Failure? failure;
  @override
  final String? authorizationUrl;
  @override
  final String? addressId;
  final List<Address> _data;
  @override
  @JsonKey()
  List<Address> get data {
    if (_data is EqualUnmodifiableListView) return _data;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_data);
  }

  final List<PickupAddress> _pickupAddresses;
  @override
  @JsonKey()
  List<PickupAddress> get pickupAddresses {
    if (_pickupAddresses is EqualUnmodifiableListView) return _pickupAddresses;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_pickupAddresses);
  }

  @override
  String toString() {
    return 'AddressState(status: $status, failure: $failure, authorizationUrl: $authorizationUrl, addressId: $addressId, data: $data, pickupAddresses: $pickupAddresses)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AddressStateImpl &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.failure, failure) || other.failure == failure) &&
            (identical(other.authorizationUrl, authorizationUrl) ||
                other.authorizationUrl == authorizationUrl) &&
            (identical(other.addressId, addressId) ||
                other.addressId == addressId) &&
            const DeepCollectionEquality().equals(other._data, _data) &&
            const DeepCollectionEquality()
                .equals(other._pickupAddresses, _pickupAddresses));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      status,
      failure,
      authorizationUrl,
      addressId,
      const DeepCollectionEquality().hash(_data),
      const DeepCollectionEquality().hash(_pickupAddresses));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$AddressStateImplCopyWith<_$AddressStateImpl> get copyWith =>
      __$$AddressStateImplCopyWithImpl<_$AddressStateImpl>(this, _$identity);
}

abstract class _AddressState implements AddressState {
  const factory _AddressState(
      {final AddressStatus status,
      final Failure? failure,
      final String? authorizationUrl,
      final String? addressId,
      final List<Address> data,
      final List<PickupAddress> pickupAddresses}) = _$AddressStateImpl;

  @override
  AddressStatus get status;
  @override
  Failure? get failure;
  @override
  String? get authorizationUrl;
  @override
  String? get addressId;
  @override
  List<Address> get data;
  @override
  List<PickupAddress> get pickupAddresses;
  @override
  @JsonKey(ignore: true)
  _$$AddressStateImplCopyWith<_$AddressStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
