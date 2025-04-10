part of 'product_bloc.dart';

@freezed
class ProductEvent with _$ProductEvent {
  const factory ProductEvent.products() = _ProductsFetched;
  const factory ProductEvent.buyProducts({required dynamic request}) = _ProductsPurchase;

}
