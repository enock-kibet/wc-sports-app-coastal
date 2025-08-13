import 'package:freezed_annotation/freezed_annotation.dart';
import 'string_or_int_converter.dart';

part 'product.freezed.dart';

part 'product.g.dart';

@freezed
class Product with _$Product {
  const factory Product(
      {required String id,
      required String name,
      required String description,
      @StringOrIntConverter() required String price,
      required String category,
      required String imageUrl,
      required List<Variant> variants}) = _Product;

  factory Product.fromJson(Map<String, Object?> json) =>
      _$ProductFromJson(json);
}

@freezed
class Variant with _$Variant {
  const factory Variant({
    required String variantId,
    required String productTypeName,
    required String productid,
    required double typePrice,
    required int units,
  }) = _Variant;

  factory Variant.fromJson(Map<String, dynamic> json) =>
      _$VariantFromJson(json);
}
