// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ProductImpl _$$ProductImplFromJson(Map<String, dynamic> json) =>
    _$ProductImpl(
      id: json['id'] as String,
      name: json['name'] as String,
      description: json['description'] as String,
      price: const StringOrIntConverter().fromJson(json['price']),
      category: json['category'] as String,
      imageUrl: json['imageUrl'] as String,
      variants: (json['variants'] as List<dynamic>)
          .map((e) => Variant.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$ProductImplToJson(_$ProductImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'price': const StringOrIntConverter().toJson(instance.price),
      'category': instance.category,
      'imageUrl': instance.imageUrl,
      'variants': instance.variants,
    };

_$VariantImpl _$$VariantImplFromJson(Map<String, dynamic> json) =>
    _$VariantImpl(
      variantId: json['variantId'] as String,
      productTypeName: json['productTypeName'] as String,
      productid: json['productid'] as String,
      typePrice: (json['typePrice'] as num).toDouble(),
      units: (json['units'] as num).toInt(),
    );

Map<String, dynamic> _$$VariantImplToJson(_$VariantImpl instance) =>
    <String, dynamic>{
      'variantId': instance.variantId,
      'productTypeName': instance.productTypeName,
      'productid': instance.productid,
      'typePrice': instance.typePrice,
      'units': instance.units,
    };
