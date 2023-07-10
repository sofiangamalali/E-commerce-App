part of 'favorite_bloc.dart';

abstract class FavoriteEvent extends Equatable {
  const FavoriteEvent();

  @override
  List<Object> get props => [];
}

class FavoriteStarted extends FavoriteEvent {
  @override
  List<Object> get props => [];
}

class AddProductToFavorite extends FavoriteEvent {
  final Product product;
  const AddProductToFavorite({required this.product});
  @override
  List<Object> get props => [product];
}

class ReomveProductFromFavorite extends FavoriteEvent {
  final Product product;
  const ReomveProductFromFavorite({required this.product});
  @override
  List<Object> get props => [product];
}
