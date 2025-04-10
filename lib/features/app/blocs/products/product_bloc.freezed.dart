// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'product_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$ProductEvent {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() products,
    required TResult Function(dynamic request) buyProducts,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? products,
    TResult? Function(dynamic request)? buyProducts,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? products,
    TResult Function(dynamic request)? buyProducts,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_ProductsFetched value) products,
    required TResult Function(_ProductsPurchase value) buyProducts,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_ProductsFetched value)? products,
    TResult? Function(_ProductsPurchase value)? buyProducts,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_ProductsFetched value)? products,
    TResult Function(_ProductsPurchase value)? buyProducts,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ProductEventCopyWith<$Res> {
  factory $ProductEventCopyWith(
          ProductEvent value, $Res Function(ProductEvent) then) =
      _$ProductEventCopyWithImpl<$Res, ProductEvent>;
}

/// @nodoc
class _$ProductEventCopyWithImpl<$Res, $Val extends ProductEvent>
    implements $ProductEventCopyWith<$Res> {
  _$ProductEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;
}

/// @nodoc
abstract class _$$ProductsFetchedImplCopyWith<$Res> {
  factory _$$ProductsFetchedImplCopyWith(_$ProductsFetchedImpl value,
          $Res Function(_$ProductsFetchedImpl) then) =
      __$$ProductsFetchedImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$ProductsFetchedImplCopyWithImpl<$Res>
    extends _$ProductEventCopyWithImpl<$Res, _$ProductsFetchedImpl>
    implements _$$ProductsFetchedImplCopyWith<$Res> {
  __$$ProductsFetchedImplCopyWithImpl(
      _$ProductsFetchedImpl _value, $Res Function(_$ProductsFetchedImpl) _then)
      : super(_value, _then);
}

/// @nodoc

class _$ProductsFetchedImpl implements _ProductsFetched {
  const _$ProductsFetchedImpl();

  @override
  String toString() {
    return 'ProductEvent.products()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$ProductsFetchedImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() products,
    required TResult Function(dynamic request) buyProducts,
  }) {
    return products();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? products,
    TResult? Function(dynamic request)? buyProducts,
  }) {
    return products?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? products,
    TResult Function(dynamic request)? buyProducts,
    required TResult orElse(),
  }) {
    if (products != null) {
      return products();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_ProductsFetched value) products,
    required TResult Function(_ProductsPurchase value) buyProducts,
  }) {
    return products(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_ProductsFetched value)? products,
    TResult? Function(_ProductsPurchase value)? buyProducts,
  }) {
    return products?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_ProductsFetched value)? products,
    TResult Function(_ProductsPurchase value)? buyProducts,
    required TResult orElse(),
  }) {
    if (products != null) {
      return products(this);
    }
    return orElse();
  }
}

abstract class _ProductsFetched implements ProductEvent {
  const factory _ProductsFetched() = _$ProductsFetchedImpl;
}

/// @nodoc
abstract class _$$ProductsPurchaseImplCopyWith<$Res> {
  factory _$$ProductsPurchaseImplCopyWith(_$ProductsPurchaseImpl value,
          $Res Function(_$ProductsPurchaseImpl) then) =
      __$$ProductsPurchaseImplCopyWithImpl<$Res>;
  @useResult
  $Res call({dynamic request});
}

/// @nodoc
class __$$ProductsPurchaseImplCopyWithImpl<$Res>
    extends _$ProductEventCopyWithImpl<$Res, _$ProductsPurchaseImpl>
    implements _$$ProductsPurchaseImplCopyWith<$Res> {
  __$$ProductsPurchaseImplCopyWithImpl(_$ProductsPurchaseImpl _value,
      $Res Function(_$ProductsPurchaseImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? request = freezed,
  }) {
    return _then(_$ProductsPurchaseImpl(
      request: freezed == request
          ? _value.request
          : request // ignore: cast_nullable_to_non_nullable
              as dynamic,
    ));
  }
}

/// @nodoc

class _$ProductsPurchaseImpl implements _ProductsPurchase {
  const _$ProductsPurchaseImpl({required this.request});

  @override
  final dynamic request;

  @override
  String toString() {
    return 'ProductEvent.buyProducts(request: $request)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ProductsPurchaseImpl &&
            const DeepCollectionEquality().equals(other.request, request));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(request));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ProductsPurchaseImplCopyWith<_$ProductsPurchaseImpl> get copyWith =>
      __$$ProductsPurchaseImplCopyWithImpl<_$ProductsPurchaseImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() products,
    required TResult Function(dynamic request) buyProducts,
  }) {
    return buyProducts(request);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? products,
    TResult? Function(dynamic request)? buyProducts,
  }) {
    return buyProducts?.call(request);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? products,
    TResult Function(dynamic request)? buyProducts,
    required TResult orElse(),
  }) {
    if (buyProducts != null) {
      return buyProducts(request);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_ProductsFetched value) products,
    required TResult Function(_ProductsPurchase value) buyProducts,
  }) {
    return buyProducts(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_ProductsFetched value)? products,
    TResult? Function(_ProductsPurchase value)? buyProducts,
  }) {
    return buyProducts?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_ProductsFetched value)? products,
    TResult Function(_ProductsPurchase value)? buyProducts,
    required TResult orElse(),
  }) {
    if (buyProducts != null) {
      return buyProducts(this);
    }
    return orElse();
  }
}

abstract class _ProductsPurchase implements ProductEvent {
  const factory _ProductsPurchase({required final dynamic request}) =
      _$ProductsPurchaseImpl;

  dynamic get request;
  @JsonKey(ignore: true)
  _$$ProductsPurchaseImplCopyWith<_$ProductsPurchaseImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$ProductState {
  ProductStatus get status => throw _privateConstructorUsedError;
  Failure? get failure => throw _privateConstructorUsedError;
  String? get authorizationUrl => throw _privateConstructorUsedError;
  List<Product> get products => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $ProductStateCopyWith<ProductState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ProductStateCopyWith<$Res> {
  factory $ProductStateCopyWith(
          ProductState value, $Res Function(ProductState) then) =
      _$ProductStateCopyWithImpl<$Res, ProductState>;
  @useResult
  $Res call(
      {ProductStatus status,
      Failure? failure,
      String? authorizationUrl,
      List<Product> products});
}

/// @nodoc
class _$ProductStateCopyWithImpl<$Res, $Val extends ProductState>
    implements $ProductStateCopyWith<$Res> {
  _$ProductStateCopyWithImpl(this._value, this._then);

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
    Object? products = null,
  }) {
    return _then(_value.copyWith(
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as ProductStatus,
      failure: freezed == failure
          ? _value.failure
          : failure // ignore: cast_nullable_to_non_nullable
              as Failure?,
      authorizationUrl: freezed == authorizationUrl
          ? _value.authorizationUrl
          : authorizationUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      products: null == products
          ? _value.products
          : products // ignore: cast_nullable_to_non_nullable
              as List<Product>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ProductStateImplCopyWith<$Res>
    implements $ProductStateCopyWith<$Res> {
  factory _$$ProductStateImplCopyWith(
          _$ProductStateImpl value, $Res Function(_$ProductStateImpl) then) =
      __$$ProductStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {ProductStatus status,
      Failure? failure,
      String? authorizationUrl,
      List<Product> products});
}

/// @nodoc
class __$$ProductStateImplCopyWithImpl<$Res>
    extends _$ProductStateCopyWithImpl<$Res, _$ProductStateImpl>
    implements _$$ProductStateImplCopyWith<$Res> {
  __$$ProductStateImplCopyWithImpl(
      _$ProductStateImpl _value, $Res Function(_$ProductStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? failure = freezed,
    Object? authorizationUrl = freezed,
    Object? products = null,
  }) {
    return _then(_$ProductStateImpl(
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as ProductStatus,
      failure: freezed == failure
          ? _value.failure
          : failure // ignore: cast_nullable_to_non_nullable
              as Failure?,
      authorizationUrl: freezed == authorizationUrl
          ? _value.authorizationUrl
          : authorizationUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      products: null == products
          ? _value._products
          : products // ignore: cast_nullable_to_non_nullable
              as List<Product>,
    ));
  }
}

/// @nodoc

class _$ProductStateImpl implements _ProductState {
  const _$ProductStateImpl(
      {this.status = ProductStatus.initial,
      this.failure,
      this.authorizationUrl,
      final List<Product> products = const []})
      : _products = products;

  @override
  @JsonKey()
  final ProductStatus status;
  @override
  final Failure? failure;
  @override
  final String? authorizationUrl;
  final List<Product> _products;
  @override
  @JsonKey()
  List<Product> get products {
    if (_products is EqualUnmodifiableListView) return _products;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_products);
  }

  @override
  String toString() {
    return 'ProductState(status: $status, failure: $failure, authorizationUrl: $authorizationUrl, products: $products)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ProductStateImpl &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.failure, failure) || other.failure == failure) &&
            (identical(other.authorizationUrl, authorizationUrl) ||
                other.authorizationUrl == authorizationUrl) &&
            const DeepCollectionEquality().equals(other._products, _products));
  }

  @override
  int get hashCode => Object.hash(runtimeType, status, failure,
      authorizationUrl, const DeepCollectionEquality().hash(_products));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ProductStateImplCopyWith<_$ProductStateImpl> get copyWith =>
      __$$ProductStateImplCopyWithImpl<_$ProductStateImpl>(this, _$identity);
}

abstract class _ProductState implements ProductState {
  const factory _ProductState(
      {final ProductStatus status,
      final Failure? failure,
      final String? authorizationUrl,
      final List<Product> products}) = _$ProductStateImpl;

  @override
  ProductStatus get status;
  @override
  Failure? get failure;
  @override
  String? get authorizationUrl;
  @override
  List<Product> get products;
  @override
  @JsonKey(ignore: true)
  _$$ProductStateImplCopyWith<_$ProductStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
