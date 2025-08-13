import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:sports_app/data/error/failure.dart';
import 'package:sports_app/data/models/products/cart.dart';

import 'package:sports_app/data/services/service.dart';

import '../../../../localization/app_prefs_manager.dart';

part 'cart_event.dart';
part 'cart_state.dart';
part 'cart_bloc.freezed.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  late CartService _cartService;
  CartBloc() : super(const CartState()) {
    _cartService = service<CartService>();

    on<_CartFetchedCart>((event, emit) async {
      emit(state.copyWith(status: CartStatus.loading));
      final recordResponse = await _cartService.getCartItems(event.request);
      recordResponse.when(onError: (error) {
        emit(state.copyWith(
          status: CartStatus.failure,
          failure: error,
        ));
      }, onSuccess: (data) async {
        emit(state.copyWith(
          status: CartStatus.success,
          cartItems: data,
          failure: null,
        ));
      });
    });
  }
}
