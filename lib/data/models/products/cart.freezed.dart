// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'cart.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

CartResponse _$CartResponseFromJson(Map<String, dynamic> json) {
  return _CartResponse.fromJson(json);
}

/// @nodoc
mixin _$CartResponse {
  String get email => throw _privateConstructorUsedError;
  @JsonKey(name: 'bundledItems')
  List<CartItem> get bundledItems => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $CartResponseCopyWith<CartResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CartResponseCopyWith<$Res> {
  factory $CartResponseCopyWith(
          CartResponse value, $Res Function(CartResponse) then) =
      _$CartResponseCopyWithImpl<$Res, CartResponse>;
  @useResult
  $Res call(
      {String email,
      @JsonKey(name: 'bundledItems') List<CartItem> bundledItems});
}

/// @nodoc
class _$CartResponseCopyWithImpl<$Res, $Val extends CartResponse>
    implements $CartResponseCopyWith<$Res> {
  _$CartResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? email = null,
    Object? bundledItems = null,
  }) {
    return _then(_value.copyWith(
      email: null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      bundledItems: null == bundledItems
          ? _value.bundledItems
          : bundledItems // ignore: cast_nullable_to_non_nullable
              as List<CartItem>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$CartResponseImplCopyWith<$Res>
    implements $CartResponseCopyWith<$Res> {
  factory _$$CartResponseImplCopyWith(
          _$CartResponseImpl value, $Res Function(_$CartResponseImpl) then) =
      __$$CartResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String email,
      @JsonKey(name: 'bundledItems') List<CartItem> bundledItems});
}

/// @nodoc
class __$$CartResponseImplCopyWithImpl<$Res>
    extends _$CartResponseCopyWithImpl<$Res, _$CartResponseImpl>
    implements _$$CartResponseImplCopyWith<$Res> {
  __$$CartResponseImplCopyWithImpl(
      _$CartResponseImpl _value, $Res Function(_$CartResponseImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? email = null,
    Object? bundledItems = null,
  }) {
    return _then(_$CartResponseImpl(
      email: null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      bundledItems: null == bundledItems
          ? _value._bundledItems
          : bundledItems // ignore: cast_nullable_to_non_nullable
              as List<CartItem>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$CartResponseImpl implements _CartResponse {
  const _$CartResponseImpl(
      {required this.email,
      @JsonKey(name: 'bundledItems')
      required final List<CartItem> bundledItems})
      : _bundledItems = bundledItems;

  factory _$CartResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$CartResponseImplFromJson(json);

  @override
  final String email;
  final List<CartItem> _bundledItems;
  @override
  @JsonKey(name: 'bundledItems')
  List<CartItem> get bundledItems {
    if (_bundledItems is EqualUnmodifiableListView) return _bundledItems;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_bundledItems);
  }

  @override
  String toString() {
    return 'CartResponse(email: $email, bundledItems: $bundledItems)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CartResponseImpl &&
            (identical(other.email, email) || other.email == email) &&
            const DeepCollectionEquality()
                .equals(other._bundledItems, _bundledItems));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, email, const DeepCollectionEquality().hash(_bundledItems));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$CartResponseImplCopyWith<_$CartResponseImpl> get copyWith =>
      __$$CartResponseImplCopyWithImpl<_$CartResponseImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CartResponseImplToJson(
      this,
    );
  }
}

abstract class _CartResponse implements CartResponse {
  const factory _CartResponse(
      {required final String email,
      @JsonKey(name: 'bundledItems')
      required final List<CartItem> bundledItems}) = _$CartResponseImpl;

  factory _CartResponse.fromJson(Map<String, dynamic> json) =
      _$CartResponseImpl.fromJson;

  @override
  String get email;
  @override
  @JsonKey(name: 'bundledItems')
  List<CartItem> get bundledItems;
  @override
  @JsonKey(ignore: true)
  _$$CartResponseImplCopyWith<_$CartResponseImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

CartItem _$CartItemFromJson(Map<String, dynamic> json) {
  return _CartItem.fromJson(json);
}

/// @nodoc
mixin _$CartItem {
  @JsonKey(name: 'productID')
  String get id => throw _privateConstructorUsedError;
  String get productName => throw _privateConstructorUsedError;
  String get productImage => throw _privateConstructorUsedError;
  String get category => throw _privateConstructorUsedError;
  @JsonKey(name: 'variantItems')
  List<CartVariant> get variants => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $CartItemCopyWith<CartItem> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CartItemCopyWith<$Res> {
  factory $CartItemCopyWith(CartItem value, $Res Function(CartItem) then) =
      _$CartItemCopyWithImpl<$Res, CartItem>;
  @useResult
  $Res call(
      {@JsonKey(name: 'productID') String id,
      String productName,
      String productImage,
      String category,
      @JsonKey(name: 'variantItems') List<CartVariant> variants});
}

/// @nodoc
class _$CartItemCopyWithImpl<$Res, $Val extends CartItem>
    implements $CartItemCopyWith<$Res> {
  _$CartItemCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? productName = null,
    Object? productImage = null,
    Object? category = null,
    Object? variants = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      productName: null == productName
          ? _value.productName
          : productName // ignore: cast_nullable_to_non_nullable
              as String,
      productImage: null == productImage
          ? _value.productImage
          : productImage // ignore: cast_nullable_to_non_nullable
              as String,
      category: null == category
          ? _value.category
          : category // ignore: cast_nullable_to_non_nullable
              as String,
      variants: null == variants
          ? _value.variants
          : variants // ignore: cast_nullable_to_non_nullable
              as List<CartVariant>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$CartItemImplCopyWith<$Res>
    implements $CartItemCopyWith<$Res> {
  factory _$$CartItemImplCopyWith(
          _$CartItemImpl value, $Res Function(_$CartItemImpl) then) =
      __$$CartItemImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'productID') String id,
      String productName,
      String productImage,
      String category,
      @JsonKey(name: 'variantItems') List<CartVariant> variants});
}

/// @nodoc
class __$$CartItemImplCopyWithImpl<$Res>
    extends _$CartItemCopyWithImpl<$Res, _$CartItemImpl>
    implements _$$CartItemImplCopyWith<$Res> {
  __$$CartItemImplCopyWithImpl(
      _$CartItemImpl _value, $Res Function(_$CartItemImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? productName = null,
    Object? productImage = null,
    Object? category = null,
    Object? variants = null,
  }) {
    return _then(_$CartItemImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      productName: null == productName
          ? _value.productName
          : productName // ignore: cast_nullable_to_non_nullable
              as String,
      productImage: null == productImage
          ? _value.productImage
          : productImage // ignore: cast_nullable_to_non_nullable
              as String,
      category: null == category
          ? _value.category
          : category // ignore: cast_nullable_to_non_nullable
              as String,
      variants: null == variants
          ? _value._variants
          : variants // ignore: cast_nullable_to_non_nullable
              as List<CartVariant>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$CartItemImpl implements _CartItem {
  const _$CartItemImpl(
      {@JsonKey(name: 'productID') required this.id,
      required this.productName,
      required this.productImage,
      required this.category,
      @JsonKey(name: 'variantItems') required final List<CartVariant> variants})
      : _variants = variants;

  factory _$CartItemImpl.fromJson(Map<String, dynamic> json) =>
      _$$CartItemImplFromJson(json);

  @override
  @JsonKey(name: 'productID')
  final String id;
  @override
  final String productName;
  @override
  final String productImage;
  @override
  final String category;
  final List<CartVariant> _variants;
  @override
  @JsonKey(name: 'variantItems')
  List<CartVariant> get variants {
    if (_variants is EqualUnmodifiableListView) return _variants;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_variants);
  }

  @override
  String toString() {
    return 'CartItem(id: $id, productName: $productName, productImage: $productImage, category: $category, variants: $variants)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CartItemImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.productName, productName) ||
                other.productName == productName) &&
            (identical(other.productImage, productImage) ||
                other.productImage == productImage) &&
            (identical(other.category, category) ||
                other.category == category) &&
            const DeepCollectionEquality().equals(other._variants, _variants));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, productName, productImage,
      category, const DeepCollectionEquality().hash(_variants));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$CartItemImplCopyWith<_$CartItemImpl> get copyWith =>
      __$$CartItemImplCopyWithImpl<_$CartItemImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CartItemImplToJson(
      this,
    );
  }
}

abstract class _CartItem implements CartItem {
  const factory _CartItem(
      {@JsonKey(name: 'productID') required final String id,
      required final String productName,
      required final String productImage,
      required final String category,
      @JsonKey(name: 'variantItems')
      required final List<CartVariant> variants}) = _$CartItemImpl;

  factory _CartItem.fromJson(Map<String, dynamic> json) =
      _$CartItemImpl.fromJson;

  @override
  @JsonKey(name: 'productID')
  String get id;
  @override
  String get productName;
  @override
  String get productImage;
  @override
  String get category;
  @override
  @JsonKey(name: 'variantItems')
  List<CartVariant> get variants;
  @override
  @JsonKey(ignore: true)
  _$$CartItemImplCopyWith<_$CartItemImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

CartVariant _$CartVariantFromJson(Map<String, dynamic> json) {
  return _CartVariant.fromJson(json);
}

/// @nodoc
mixin _$CartVariant {
  String get variantID => throw _privateConstructorUsedError;
  @StringOrIntToIntConverter()
  int get quantity => throw _privateConstructorUsedError;
  String get variantName => throw _privateConstructorUsedError;
  @VariantPriceConverter()
  double get variantPrice => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $CartVariantCopyWith<CartVariant> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CartVariantCopyWith<$Res> {
  factory $CartVariantCopyWith(
          CartVariant value, $Res Function(CartVariant) then) =
      _$CartVariantCopyWithImpl<$Res, CartVariant>;
  @useResult
  $Res call(
      {String variantID,
      @StringOrIntToIntConverter() int quantity,
      String variantName,
      @VariantPriceConverter() double variantPrice});
}

/// @nodoc
class _$CartVariantCopyWithImpl<$Res, $Val extends CartVariant>
    implements $CartVariantCopyWith<$Res> {
  _$CartVariantCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? variantID = null,
    Object? quantity = null,
    Object? variantName = null,
    Object? variantPrice = null,
  }) {
    return _then(_value.copyWith(
      variantID: null == variantID
          ? _value.variantID
          : variantID // ignore: cast_nullable_to_non_nullable
              as String,
      quantity: null == quantity
          ? _value.quantity
          : quantity // ignore: cast_nullable_to_non_nullable
              as int,
      variantName: null == variantName
          ? _value.variantName
          : variantName // ignore: cast_nullable_to_non_nullable
              as String,
      variantPrice: null == variantPrice
          ? _value.variantPrice
          : variantPrice // ignore: cast_nullable_to_non_nullable
              as double,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$CartVariantImplCopyWith<$Res>
    implements $CartVariantCopyWith<$Res> {
  factory _$$CartVariantImplCopyWith(
          _$CartVariantImpl value, $Res Function(_$CartVariantImpl) then) =
      __$$CartVariantImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String variantID,
      @StringOrIntToIntConverter() int quantity,
      String variantName,
      @VariantPriceConverter() double variantPrice});
}

/// @nodoc
class __$$CartVariantImplCopyWithImpl<$Res>
    extends _$CartVariantCopyWithImpl<$Res, _$CartVariantImpl>
    implements _$$CartVariantImplCopyWith<$Res> {
  __$$CartVariantImplCopyWithImpl(
      _$CartVariantImpl _value, $Res Function(_$CartVariantImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? variantID = null,
    Object? quantity = null,
    Object? variantName = null,
    Object? variantPrice = null,
  }) {
    return _then(_$CartVariantImpl(
      variantID: null == variantID
          ? _value.variantID
          : variantID // ignore: cast_nullable_to_non_nullable
              as String,
      quantity: null == quantity
          ? _value.quantity
          : quantity // ignore: cast_nullable_to_non_nullable
              as int,
      variantName: null == variantName
          ? _value.variantName
          : variantName // ignore: cast_nullable_to_non_nullable
              as String,
      variantPrice: null == variantPrice
          ? _value.variantPrice
          : variantPrice // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$CartVariantImpl implements _CartVariant {
  const _$CartVariantImpl(
      {required this.variantID,
      @StringOrIntToIntConverter() required this.quantity,
      required this.variantName,
      @VariantPriceConverter() required this.variantPrice});

  factory _$CartVariantImpl.fromJson(Map<String, dynamic> json) =>
      _$$CartVariantImplFromJson(json);

  @override
  final String variantID;
  @override
  @StringOrIntToIntConverter()
  final int quantity;
  @override
  final String variantName;
  @override
  @VariantPriceConverter()
  final double variantPrice;

  @override
  String toString() {
    return 'CartVariant(variantID: $variantID, quantity: $quantity, variantName: $variantName, variantPrice: $variantPrice)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CartVariantImpl &&
            (identical(other.variantID, variantID) ||
                other.variantID == variantID) &&
            (identical(other.quantity, quantity) ||
                other.quantity == quantity) &&
            (identical(other.variantName, variantName) ||
                other.variantName == variantName) &&
            (identical(other.variantPrice, variantPrice) ||
                other.variantPrice == variantPrice));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, variantID, quantity, variantName, variantPrice);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$CartVariantImplCopyWith<_$CartVariantImpl> get copyWith =>
      __$$CartVariantImplCopyWithImpl<_$CartVariantImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CartVariantImplToJson(
      this,
    );
  }
}

abstract class _CartVariant implements CartVariant {
  const factory _CartVariant(
          {required final String variantID,
          @StringOrIntToIntConverter() required final int quantity,
          required final String variantName,
          @VariantPriceConverter() required final double variantPrice}) =
      _$CartVariantImpl;

  factory _CartVariant.fromJson(Map<String, dynamic> json) =
      _$CartVariantImpl.fromJson;

  @override
  String get variantID;
  @override
  @StringOrIntToIntConverter()
  int get quantity;
  @override
  String get variantName;
  @override
  @VariantPriceConverter()
  double get variantPrice;
  @override
  @JsonKey(ignore: true)
  _$$CartVariantImplCopyWith<_$CartVariantImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
