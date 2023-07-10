// ignore_for_file: unnecessary_string_interpolations
import 'package:elhaga/presentation/screens/order_screen.dart';
import 'package:page_transition/page_transition.dart';
import '../../business_logic/bloc/cart/cart_bloc.dart';
import '../widgets/cart/cart_card.dart';
import '../widgets/custom_appbar.dart';
import '../widgets/cart/empty_cart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const CustomAppBar(
        title: 'السلة',
        backgroundColor: Colors.white,
      ),
      body: BlocBuilder<CartBloc, CartState>(
        builder: (context, state) {
          if (state is CartLoading) {
            return const Center(
              child: CircularProgressIndicator(
                color: Colors.teal,
              ),
            );
          }
          if (state is CartLoaded) {
            if (state.cart.items.isEmpty) {
              return const EmptyCart();
            } else {
              return Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  //Items
                  Expanded(
                    child: ListView.builder(
                      itemCount: state.cart.items.length,
                      itemBuilder: (context, index) {
                        final item = state.cart.items.keys.toList()[index];
                        return CartCard(item: item);
                      },
                    ),
                  ),
                  // Order Button
                  Container(
                    margin: const EdgeInsets.all(10),
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).push(PageTransition(
                            child: OrderScreen(
                                totalForCart: state.cart.getTotalPrice(),
                                cartItems: state.cart.items),
                            type: PageTransitionType.bottomToTop));
                      },
                      style: ElevatedButton.styleFrom(
                        fixedSize: const Size(450, 80),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16.0,
                          vertical: 8.0,
                        ),
                        backgroundColor: Colors.teal,
                        textStyle: const TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                      child: Directionality(
                        textDirection: TextDirection.rtl,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'الذهاب لتنفيذ الطلب',
                              style: TextStyle(
                                  fontSize: 20, fontFamily: 'NotoSansArabic'),
                            ),
                            Text(
                              '${state.cart.getTotalPrice().toStringAsFixed(2)} ج.م',
                              style: const TextStyle(
                                  fontFamily: 'NotoSansArabic',
                                  fontSize: 20,
                                  height: 0.5),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              );
            }
          } else {
            return const Center(
              child: Text('حدث خطأ ما'),
            );
          }
        },
      ),
    );
  }
}
