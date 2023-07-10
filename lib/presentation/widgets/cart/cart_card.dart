import 'package:cached_network_image/cached_network_image.dart';
import 'package:elhaga/Data/Models/item_model.dart';
import 'package:elhaga/Data/Models/product_model.dart';
import '../icon_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../business_logic/bloc/cart/cart_bloc.dart';

class CartCard extends StatelessWidget {
  final Item item;
  const CartCard({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Container(
          padding:
              const EdgeInsets.only(top: 10, left: 10, right: 3, bottom: 10),
          color: Colors.transparent,
          height: 100,
          width: screenWidth,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  //Image
                  item is Product
                      ? CachedNetworkImage(
                          imageUrl: item.image,
                          placeholder: (context, url) => Container(),
                          height: 60,
                          width: 60,
                          errorWidget: (context, url, error) => Container(),
                          fit: BoxFit.fill,
                        )
                      : Container(),
                  const SizedBox(
                    width: 10,
                  ),
                  //Description + Price
                  SizedBox(
                    width: screenWidth * (5 / 7) - 100,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          item.name,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              color: Colors.grey[800],
                              fontSize: 16,
                              height: 1,
                              fontFamily: 'NotoSansArabic'),
                        ),
                        Row(
                          children: [
                            const SizedBox(
                              width: 10,
                            ),
                            Text(
                              '${item.price.toStringAsFixed(2)} ج.م',
                              style: TextStyle(
                                  color: Colors.grey[600],
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                ],
              ),
              //Add And Reomve
              SizedBox(
                width: screenWidth / 3.5,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    //Remove
                    BlocBuilder<CartBloc, CartState>(
                      builder: (context, state) {
                        if (state is CartLoaded) {
                          final itemData = state.cart.items[item];
                          int quantity = itemData!['quantity'];
                          return InkWell(
                            splashColor: Colors.transparent,
                            onTap: () {
                              context.read<CartBloc>().add(
                                    CartItemRemoved(item),
                                  );
                            },
                            child: IconContainer(
                              color: Colors.teal[100]!,
                              child: quantity == 1
                                  ? const Icon(
                                      Icons.delete_outline_outlined,
                                      color: Colors.teal,
                                      size: 25,
                                    )
                                  : const Icon(
                                      Icons.remove_outlined,
                                      color: Colors.teal,
                                      size: 25,
                                    ),
                            ),
                          );
                        } else {
                          return Container();
                        }
                      },
                    ),
                    //Quantity
                    BlocBuilder<CartBloc, CartState>(
                      builder: (context, state) {
                        if (state is CartLoaded) {
                          Map<String, dynamic>? itemData =
                              state.cart.items[item];
                          int quantity = itemData!['quantity'];
                          return IconContainer(
                            color: Colors.grey[100]!,
                            child: Text(
                              quantity.toString(),
                              style: const TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                          );
                        } else {
                          return Container();
                        }
                      },
                    ),

                    //Add
                    BlocBuilder<CartBloc, CartState>(
                      builder: (context, state) {
                        if (state is CartLoaded) {
                          return InkWell(
                            splashColor: Colors.transparent,
                            onTap: () {
                              if (state.cart
                                  .checkProductStock(item, state.cart.items)) {
                                context
                                    .read<CartBloc>()
                                    .add(CartItemAdded(item));
                              } else {
                                null;
                              }
                            },
                            child: IconContainer(
                              color: state.cart
                                      .checkProductStock(item, state.cart.items)
                                  ? Colors.teal[100]!
                                  : Colors.grey[100]!,
                              child: Icon(
                                Icons.add,
                                color: state.cart.checkProductStock(
                                        item, state.cart.items)
                                    ? Colors.teal
                                    : Colors.grey,
                                size: 25,
                              ),
                            ),
                          );
                        } else {
                          return Container();
                        }
                      },
                    )
                  ],
                ),
              )
            ],
          )),
    );
  }
}
