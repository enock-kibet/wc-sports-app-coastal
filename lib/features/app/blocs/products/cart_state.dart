part of 'cart_bloc.dart';

enum CartStatus {
  initial,
  loading,
  success,
  failure,
  processingPayment,
  successfulPayment,
  ;

  bool get isInitial => this == CartStatus.initial;
  bool get isLoading => this == CartStatus.loading;
  bool get isSuccess => this == CartStatus.success;
  bool get isFailure => this == CartStatus.failure;
}

@freezed
class CartState with _$CartState {
  const factory CartState({
    @Default(CartStatus.initial) CartStatus status,
    Failure? failure,
    String? authorizationUrl,
    @Default([]) List<CartItem> cartItems,
  }) = _CartState;
}
