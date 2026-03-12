import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:sports_app/data/error/failure.dart';
import 'package:sports_app/data/models/products/product.dart';

import 'package:sports_app/data/services/service.dart';
import 'package:sports_app/localization/app_prefs_manager.dart';

part 'product_event.dart';
part 'product_state.dart';
part 'product_bloc.freezed.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  late ProductService _productService;

  ProductBloc() : super(const ProductState()) {
    _productService = service<ProductService>();

    on<_ProductsFetched>((event, emit) async {
      emit(state.copyWith(status: ProductStatus.loading));
      final recordResponse = await _productService.getProducts();
      recordResponse.when(onError: (error) {
        emit(state.copyWith(
          status: ProductStatus.failure,
          failure: error,
        ));
      }, onSuccess: (data) async {
        emit(state.copyWith(
          status: ProductStatus.success,
          products: data,
          failure: null,
        ));
      });
    });
    on<_ProductToCart>((event, emit) async {
      emit(state.copyWith(status: ProductStatus.loading));
      final token = service<AppPreferencesManager>().currentUserValue?.token;
      if (token == null || token.isEmpty) {
        emit(state.copyWith(
          status: ProductStatus.failure,
          failure: Failure(error: "Please sign in to add items to cart."),
        ));
        return;
      }

      final recordResponse =
          await _productService.addToCart(event.request, token);
      recordResponse.when(onError: (error) {
        emit(state.copyWith(
          status: ProductStatus.failure,
          failure: error,
        ));
      }, onSuccess: (data) async {
        emit(state.copyWith(
          status: ProductStatus.success,
          message: data,
          failure: null,
        ));
      });
    });

    on<_ProductRemoveCart>((event, emit) async {
      emit(state.copyWith(status: ProductStatus.loading));
      final recordResponse =
      await _productService.removeCart(event.request);
      recordResponse.when(onError: (error) {
        emit(state.copyWith(
          status: ProductStatus.failure,
          failure: error,
        ));
      }, onSuccess: (data) async {
        emit(state.copyWith(
          status: ProductStatus.success,
          message: data,
          failure: null,
        ));
      });
    });

    on<_ProductClearCart>((event, emit) async {
      emit(state.copyWith(status: ProductStatus.loading));
      final recordResponse =
      await _productService.clearCart(event.request);
      recordResponse.when(onError: (error) {
        emit(state.copyWith(
          status: ProductStatus.failure,
          failure: error,
        ));
      }, onSuccess: (data) async {
        emit(state.copyWith(
          status: ProductStatus.success,
          message: data,
          failure: null,
        ));
      });
    });


    on<_ProductsBulkPurchase>((event, emit) async {
      emit(state.copyWith(status: ProductStatus.processingPayment));
      final recordResponse =
      await _productService.productsPayment(event.request);
      recordResponse.when(onError: (error) {
        emit(state.copyWith(
          status: ProductStatus.failure,
          failure: error,
        ));
      }, onSuccess: (data) async {
        emit(state.copyWith(
          status: ProductStatus.successfulPayment,
          authorizationUrl: data,
          failure: null,
        ));
      });
    });

    on<_ProductsPurchase>((event, emit) async {
      emit(state.copyWith(status: ProductStatus.processingPayment));
      final recordResponse =
          await _productService.productPayment(event.request);
      recordResponse.when(onError: (error) {
        emit(state.copyWith(
          status: ProductStatus.failure,
          failure: error,
        ));
      }, onSuccess: (data) async {
        emit(state.copyWith(
          status: ProductStatus.successfulPayment,
          authorizationUrl: data,
          failure: null,
        ));
      });
    });
  }
}
