// ignore_for_file: prefer_const_constructors
import 'package:elhaga/presentation/screens/item_screen.dart';
import 'package:elhaga/presentation/widgets/favorite_icon.dart';
import 'package:page_transition/page_transition.dart';
import '../../Data/Models/product_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../business_logic/bloc/cart/cart_bloc.dart';
import '../../business_logic/bloc/favorite/favorite_bloc.dart';
import 'package:cached_network_image/cached_network_image.dart';

class ProductCard extends StatelessWidget {
  final Product product;
  final bool isFavScreen;
  const ProductCard({
    super.key,
    required this.isFavScreen,
    required this.product,
  });
  Widget _buildProductImage() {
    return Positioned(
      top: 15,
      left: 20,
      child: CachedNetworkImage(
        imageUrl: product.image,
        placeholder: (context, url) => Container(),
        height: 100,
        width: 100,
        errorWidget: (context, url, error) => Container(),
        fit: BoxFit.fill,
      ),
    );
  }

  Widget _buildDeleteButtonForFavoriteScreen(BuildContext context) {
    return InkWell(
        highlightColor: Colors.transparent,
        splashColor: Colors.transparent,
        onTap: () {
          context
              .read<FavoriteBloc>()
              .add(ReomveProductFromFavorite(product: product));
        },
        child: Container(
          width: 30,
          height: 30,
          decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.teal),
          child: Icon(
            Icons.delete_outline_outlined,
            color: Colors.white,
            size: 25,
          ),
        ));
  }

  @override
  Widget build(BuildContext context) {
    int intPart = product.price.truncate();
    double decimalPart = product.price % 1.0;
    return InkWell(
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      onTap: () {
        Navigator.of(context).push(PageTransition(
            child: ItemScreen(item: product),
            type: PageTransitionType.bottomToTop));
      },
      child: Container(
        color: Colors.transparent,
        height: 200,
        width: 150,
        child: Stack(
          children: [
            //Product Image
            _buildProductImage(),
            //Favorite Icon
            Positioned(
                top: 0,
                left: 10,
                child: BlocBuilder<FavoriteBloc, FavoriteState>(
                  builder: (context, state) {
                    if (state is FavoriteLoaded) {
                      if (isFavScreen) {
                        return _buildDeleteButtonForFavoriteScreen(context);
                      } else {
                        return FavIcon(
                          product: product,
                          inactiveIcon: Icon(
                            Icons.favorite_outline_rounded,
                            color: Colors.grey[400],
                            size: 30,
                          ),
                          activeIcon: Icon(
                            Icons.favorite_rounded,
                            color: Colors.red[400],
                            size: 30,
                          ),
                        );
                      }
                    } else {
                      return Container();
                    }
                  },
                )),

            //Add To cart button
            Positioned(
              top: 100,
              left: 10,
              child: BlocBuilder<CartBloc, CartState>(
                builder: (context, state) {
                  if (state is CartLoaded) {
                    return InkWell(
                      highlightColor: Colors.transparent,
                      splashColor: Colors.transparent,
                      onTap: (() {
                        if (state.cart
                            .checkProductStock(product, state.cart.items)) {
                          context.read<CartBloc>().add(CartItemAdded(product));
                        } else {
                          null;
                        }
                      }),
                      child: Container(
                        width: 30,
                        height: 30,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: state.cart.checkProductStock(
                                    product, state.cart.items)
                                ? Colors.teal
                                : Colors.grey),
                        child: const Icon(
                          Icons.add,
                          color: Colors.white,
                        ),
                      ),
                    );
                  } else {
                    return Container();
                  }
                },
              ),
            ),
            // Price
            Positioned(
              top: 130,
              right: 10,
              child: Row(
                textDirection: TextDirection.rtl,
                children: [
                  Text.rich(
                    TextSpan(
                      style: const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                      children: [
                        //int
                        TextSpan(
                          text: intPart.toString(),
                          style: const TextStyle(fontSize: 18),
                        ),
                        //double
                        TextSpan(
                          text: decimalPart.toStringAsFixed(2).substring(1),
                          style: const TextStyle(
                              fontSize: 16, color: Colors.black87),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    product.previuosPrice,
                    style: const TextStyle(
                        fontSize: 16,
                        color: Colors.red,
                        fontWeight: FontWeight.bold,
                        decoration: TextDecoration.lineThrough),
                  ),
                ],
              ),
            ),
            //Discreption
            Positioned(
              top: 160,
              right: 0,
              child: Container(
                width: 150,
                padding: const EdgeInsets.only(left: 15, right: 5),
                child: Text(
                  product.name,
                  textDirection: TextDirection.rtl,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontFamily: 'NotoSansArabic',
                    height: 1.0,
                    fontSize: 16,
                    color: Colors.grey[500],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
