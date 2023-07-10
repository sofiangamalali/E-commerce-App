part of 'favorite_bloc.dart';

abstract class FavoriteState extends Equatable {
  const FavoriteState();

  @override
  List<Object> get props => [];
}

class FavoriteLoading extends FavoriteState {
  @override
  List<Object> get props => [];
}

class FavoriteLoaded extends FavoriteState {
  final Favorite favorite;
  final List<String> favoriteItemsId;
  const FavoriteLoaded(
      {this.favorite = const Favorite(), this.favoriteItemsId = const []});
  @override
  List<Object> get props => [favorite, favoriteItemsId];
}

class FavoriteError extends FavoriteState {
  @override
  List<Object> get props => [];
}
