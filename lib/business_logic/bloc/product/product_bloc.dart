// ignore_for_file: depend_on_referenced_packages

import 'package:bloc/bloc.dart';
import 'package:elhaga/Data/Models/product_model.dart';
import 'package:elhaga/Data/Repositories/product_repo.dart';
import 'package:equatable/equatable.dart';
part 'product_event.dart';
part 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final ProductRepository _productReposiory;

  ProductBloc({required ProductRepository productRepository})
      : _productReposiory = productRepository,
        super(ProductLoading()) {
    on<LoadProducts>((event, emit) async {
      List<Product> products = await _productReposiory.getAllProducts();
      if (products.isNotEmpty) {
        emit(ProductLoaded(products: products));
      } else {
        emit(ProductError());
      }
    });
  }
}
