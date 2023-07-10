import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../business_logic/bloc/cart/cart_bloc.dart';
import '../pages/cart_page.dart';
import '../pages/drawer_page.dart';
import '../pages/home_page.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _page = 2;
  final pages = const <Widget>[DrawerPage(), CartPage(), HomePage()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
            border: Border(top: BorderSide(color: Colors.grey[300]!))),
        child: BottomNavigationBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          selectedItemColor: Colors.teal,
          unselectedFontSize: 14,
          selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold),
          unselectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold),
          unselectedItemColor: Colors.grey[400],
          currentIndex: _page,
          onTap: (index) {
            setState(() {
              _page = index;
            });
          },
          items: <BottomNavigationBarItem>[
            const BottomNavigationBarItem(
              icon: Icon(
                Icons.menu_rounded,
                size: 30,
              ),
              label: 'المزيد',
              tooltip: '',
            ),
            BottomNavigationBarItem(
              icon: BlocBuilder<CartBloc, CartState>(
                builder: (context, state) {
                  if (state is CartLoaded) {
                    return Stack(
                      clipBehavior: Clip.none,
                      children: [
                        const Icon(Icons.shopping_cart_outlined, size: 30),
                        state.cart.getCount() == 0
                            ? Positioned(
                                right: -5, bottom: -5, child: Container())
                            : Positioned(
                                right: -10,
                                bottom: -7,
                                child: Container(
                                  width: 25,
                                  height: 25,
                                  decoration: const BoxDecoration(
                                    color: Colors.teal,
                                    shape: BoxShape.circle,
                                  ),
                                  child: Center(
                                    child: Text(
                                      state.cart.getCount().toString(),
                                      style: const TextStyle(
                                          height: 1.8,
                                          color: Colors.white,
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ),
                              )
                      ],
                    );
                  } else {
                    return const Icon(Icons.shopping_cart_outlined, size: 30);
                  }
                },
              ),
              label: 'السلة',
              tooltip: '',
              activeIcon: BlocBuilder<CartBloc, CartState>(
                builder: (context, state) {
                  if (state is CartLoaded) {
                    return Stack(
                      clipBehavior: Clip.none,
                      children: [
                        const Icon(Icons.shopping_cart, size: 30),
                        state.cart.getCount() == 0
                            ? Positioned(
                                right: -5, bottom: -5, child: Container())
                            : Positioned(
                                right: -10,
                                bottom: -7,
                                child: Container(
                                  width: 25,
                                  height: 25,
                                  decoration: const BoxDecoration(
                                    color: Colors.teal,
                                    shape: BoxShape.circle,
                                  ),
                                  child: Center(
                                    child: Text(
                                      state.cart.getCount().toString(),
                                      style: const TextStyle(
                                          height: 1.8,
                                          color: Colors.white,
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ),
                              )
                      ],
                    );
                  } else {
                    return const Icon(Icons.shopping_cart_outlined, size: 30);
                  }
                },
              ),
            ),
            const BottomNavigationBarItem(
              icon: Icon(Icons.home_outlined, size: 30),
              label: 'الرئيسية',
              tooltip: '',
              activeIcon: Icon(Icons.home, size: 30),
            ),
          ],
        ),
      ),
      backgroundColor: Colors.white,
      body: pages[_page],
    );
  }
}
