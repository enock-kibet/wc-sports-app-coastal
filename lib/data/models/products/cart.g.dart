// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cart.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$CartResponseImpl _$$CartResponseImplFromJson(Map<String, dynamic> json) =>
    _$CartResponseImpl(
      email: json['email'] as String,
      bundledItems: (json['bundledItems'] as List<dynamic>)
          .map((e) => CartItem.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$CartResponseImplToJson(_$CartResponseImpl instance) =>
    <String, dynamic>{
      'email': instance.email,
      'bundledItems': instance.bundledItems,
    };

_$CartItemImpl _$$CartItemImplFromJson(Map<String, dynamic> json) =>
    _$CartItemImpl(
      id: json['productID'] as String,
      productName: json['productName'] as String,
      productImage: json['productImage'] as String,
      category: json['category'] as String,
      variants: (json['variantItems'] as List<dynamic>)
          .map((e) => CartVariant.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$CartItemImplToJson(_$CartItemImpl instance) =>
    <String, dynamic>{
      'productID': instance.id,
      'productName': instance.productName,
      'productImage': instance.productImage,
      'category': instance.category,
      'variantItems': instance.variants,
    };

_$CartVariantImpl _$$CartVariantImplFromJson(Map<String, dynamic> json) =>
    _$CartVariantImpl(
      variantID: json['variantID'] as String,
      quantity: const StringOrIntToIntConverter().fromJson(json['quantity']),
      variantName: json['variantName'] as String,
      variantPrice:
          const VariantPriceConverter().fromJson(json['variantPrice']),
    );

Map<String, dynamic> _$$CartVariantImplToJson(_$CartVariantImpl instance) =>
    <String, dynamic>{
      'variantID': instance.variantID,
      'quantity': const StringOrIntToIntConverter().toJson(instance.quantity),
      'variantName': instance.variantName,
      'variantPrice':
          const VariantPriceConverter().toJson(instance.variantPrice),
    };
