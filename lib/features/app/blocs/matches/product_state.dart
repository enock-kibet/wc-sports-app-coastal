part of 'product_bloc.dart';

enum ProductStatus {
  initial,
  loading,
  success,
  failure;

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
    @Default([]) List<dynamic> products,
  }) = _ProductState;
}
