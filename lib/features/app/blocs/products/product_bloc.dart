import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:sports_app/data/error/failure.dart';
import 'package:sports_app/data/models/products/product.dart';

import 'package:sports_app/data/services/service.dart';

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
  }
}
