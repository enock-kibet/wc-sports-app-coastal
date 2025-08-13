part of 'product_bloc.dart';

enum ProductStatus {
  initial,
  loading,
  success,
  failure,
  processingPayment,
  successfulPayment,
  ;

  bool get isInitial => this == ProductStatus.initial;
  bool get isLoading => this == ProductStatus.loading;
  bool get isSuccess => this == ProductStatus.success;
  bool get isFailure => this == ProductStatus.failure;
}

@freezed
class ProductState with _$ProductState {
  const factory ProductState({
    @Default(ProductStatus.initial) ProductStatus status,
    Failure? failure,
    String? authorizationUrl,
    String? message,
    @Default([]) List<Product> products,
  }) = _ProductState;
}
