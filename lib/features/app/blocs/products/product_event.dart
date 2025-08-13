part of 'product_bloc.dart';

@freezed
class ProductEvent with _$ProductEvent {
  const factory ProductEvent.products() = _ProductsFetched;
  const factory ProductEvent.buyProducts({required dynamic request}) =
      _ProductsPurchase;
  const factory ProductEvent.buyBulkProducts({required dynamic request}) =
  _ProductsBulkPurchase;
  const factory ProductEvent.addToCart({required dynamic request}) =
      _ProductToCart;
}
