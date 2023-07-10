import 'package:elhaga/Data/Models/product_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../business_logic/bloc/favorite/favorite_bloc.dart';

class FavIcon extends StatelessWidget {
  final Widget activeIcon;
  final Widget inactiveIcon;
  final Product product;

  const FavIcon({
    super.key,
    required this.product,
    required this.activeIcon,
    required this.inactiveIcon,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FavoriteBloc, FavoriteState>(
      builder: (context, state) {
        if (state is FavoriteLoaded) {
          return InkWell(
            highlightColor: Colors.transparent,
            splashColor: Colors.transparent,
            onTap: () {
              if (state.favoriteItemsId.contains(product.id)) {
                BlocProvider.of<FavoriteBloc>(context)
                    .add(ReomveProductFromFavorite(product: product));
              } else {
                BlocProvider.of<FavoriteBloc>(context)
                    .add(AddProductToFavorite(product: product));
              }
            },
            child: state.favoriteItemsId.contains(product.id)
                ? activeIcon
                : inactiveIcon,
          );
        } else {
          return Container();
        }
      },
    );
  }
}
