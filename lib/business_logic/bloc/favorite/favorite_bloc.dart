// ignore_for_file: depend_on_referenced_packages

import 'package:bloc/bloc.dart';
import 'package:elhaga/Data/Models/favorite_model.dart';
import 'package:elhaga/Data/Models/product_model.dart';
import 'package:elhaga/Data/Repositories/product_repo.dart';
import 'package:elhaga/helper.dart';
import 'package:equatable/equatable.dart';
part 'favorite_event.dart';
part 'favorite_state.dart';

class FavoriteBloc extends Bloc<FavoriteEvent, FavoriteState> {
  final ProductRepository productRepository;
  FavoriteBloc({required this.productRepository}) : super(FavoriteLoading()) {
    on<FavoriteStarted>((event, emit) async {
      emit(FavoriteLoading());
      List<Product> allProducts = await productRepository.getAllProducts();
      List<String> favProductsId = await readItemsFromFavoriteList();
      List<Product> favProducts = [];
      for (var i = 0; i < allProducts.length; i++) {
        if (favProductsId.contains(allProducts[i].id)) {
          favProducts.add(allProducts[i]);
        }
      }
      emit(FavoriteLoaded(
          favorite: Favorite(items: favProducts),
          favoriteItemsId: favProductsId));
    });
    on<AddProductToFavorite>((event, emit) async {
      if (state is FavoriteLoaded) {
        final state = this.state as FavoriteLoaded;
        List<String> favList = await readItemsFromFavoriteList();
        favList.add(event.product.id);
        updateFavoriteList(favList);
        emit(FavoriteLoading());
        emit(
          FavoriteLoaded(
              favorite: Favorite(
                items: List.from(state.favorite.items)..add(event.product),
              ),
              favoriteItemsId: favList),
        );
      }
    });
    on<ReomveProductFromFavorite>((event, emit) async {
      if (state is FavoriteLoaded) {
        final state = this.state as FavoriteLoaded;
        List<String> favList = await readItemsFromFavoriteList();
        favList.remove(event.product.id);
        updateFavoriteList(favList);
        emit(FavoriteLoading());
        emit(
          FavoriteLoaded(
              favorite: Favorite(
                items: List.from(state.favorite.items)..remove(event.product),
              ),
              favoriteItemsId: favList),
        );
      }
    });
  }
}
