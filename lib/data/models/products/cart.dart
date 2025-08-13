import 'package:freezed_annotation/freezed_annotation.dart';

part 'cart.freezed.dart';
part 'cart.g.dart';

/// Converter that ensures quantity is always an int, even if the API sends a string
class StringOrIntToIntConverter implements JsonConverter<int, Object?> {
  const StringOrIntToIntConverter();

  @override
  int fromJson(Object? json) {
    if (json is int) return json;
    if (json is String) return int.tryParse(json) ?? 0;
    throw Exception('Cannot convert $json to int');
  }

  @override
  Object toJson(int object) => object;
}

@freezed
class CartResponse with _$CartResponse {
  const factory CartResponse({
    required String email,
    @JsonKey(name: 'bundledItems') required List<CartItem> bundledItems,
  }) = _CartResponse;

  factory CartResponse.fromJson(Map<String, dynamic> json) =>
      _$CartResponseFromJson(json);
}

@freezed
class CartItem with _$CartItem {
  const factory CartItem({
    @JsonKey(name: 'productID') required String id,
    required String productName,
    required String productImage,
    required String category,
    @JsonKey(name: 'variantItems') required List<CartVariant> variants,
  }) = _CartItem;

  factory CartItem.fromJson(Map<String, dynamic> json) =>
      _$CartItemFromJson(json);
}

@freezed
class CartVariant with _$CartVariant {
  const factory CartVariant({
    required String variantID,
    @StringOrIntToIntConverter() required int quantity,
    required String variantName,
    @VariantPriceConverter() required double variantPrice,
  }) = _CartVariant;

  factory CartVariant.fromJson(Map<String, dynamic> json) =>
      _$CartVariantFromJson(json);
}

class VariantPriceConverter implements JsonConverter<double, dynamic> {
  const VariantPriceConverter();

  @override
  double fromJson(dynamic json) {
    if (json is List && json.isNotEmpty) {
      return (json[0] as num).toDouble();
    }
    return 0.0;
  }

  @override
  dynamic toJson(double object) => [object];
}
