// ignore_for_file: depend_on_referenced_packages

import 'package:elhaga/Data/Repositories/order_repo.dart';
import 'package:elhaga/Data/Repositories/product_repo.dart';
import 'package:elhaga/Data/Repositories/settings_repo.dart';
import 'package:elhaga/business_logic/bloc/offer/offer_bloc.dart';
import 'package:elhaga/business_logic/bloc/settings/settings_bloc.dart';
import 'package:elhaga/presentation/screens/app_issue_screen.dart';
import 'package:elhaga/presentation/screens/favorite_screen.dart';
import 'package:elhaga/presentation/screens/last_orders_screen.dart';
import 'package:elhaga/presentation/screens/settings_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'Data/Repositories/offer_repo.dart';
import 'business_logic/bloc/cart/cart_bloc.dart';
import 'business_logic/bloc/favorite/favorite_bloc.dart';
import 'business_logic/bloc/location/location_bloc.dart';
import 'business_logic/bloc/location_permission/location_permission_bloc.dart';
import 'business_logic/bloc/order/order_bloc.dart';
import 'business_logic/bloc/product/product_bloc.dart';
import 'presentation/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'presentation/screens/auth/signup_screen.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.white, // set the color of the status bar
    statusBarIconBrightness: Brightness.light, // set the icons to be dark
  ));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => CartBloc()..add(CartStarted()),
          lazy: false,
        ),
        BlocProvider(
          create: (_) => SettingsBloc(settingsRepository: SettingsRepository())
            ..add(LoadSettings()),
          lazy: false,
        ),
        BlocProvider(
          create: (_) => OrderBloc(orderRepository: OrderRepository()),
          lazy: false,
        ),
        BlocProvider(
          create: (_) =>
              OfferBloc(offerRepository: OfferRepository())..add(LoadOffers()),
          lazy: false,
        ),
        BlocProvider(
          create: (_) => ProductBloc(productRepository: ProductRepository())
            ..add(LoadProducts()),
          lazy: false,
        ),
        BlocProvider(
          create: (_) => LocationBloc(),
          lazy: false,
        ),
        BlocProvider(
          create: (_) => FavoriteBloc(productRepository: ProductRepository())
            ..add(FavoriteStarted()),
          lazy: false,
        ),
        BlocProvider(
          create: (_) =>
              LocationPermissionBloc()..add(RequestLocationPermission()),
          lazy: false,
        ),
      ],
      child: BlocBuilder<SettingsBloc, SettingsState>(
        builder: (context, state) {
          if (state is SettingsLoaded) {
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              theme: ThemeData(
                fontFamily: 'Cairo',
                brightness: Brightness.light,
                colorScheme: ColorScheme.fromSwatch().copyWith(
                  secondary: Colors.white,
                ),
              ),
              home: state.settings.appIssue
                  ? AppIssueScreen(text: state.settings.appIssueText)
                  : state.settings.newUpdate
                      ? AppIssueScreen(text: state.settings.newUpdateText)
                      : AnimatedSplashScreen(
                          splashIconSize: 150,
                          duration: 2000,
                          splash: 'assets/images/app_icon.png',
                          splashTransition: SplashTransition.fadeTransition,
                          nextScreen: const HomeScreen()),
              routes: {
                'HomeScreen': (context) => const HomeScreen(),
                'FavoriteScreen': (context) => const FavoriteScreen(),
                'LastOrdersScreen': (context) => const LastOredersScreen(),
                'SettingsScreen': (context) => const SettingsScreen(),
                'SignUpScreen': (context) => SignUpScreen(),
              },
            );
          } else {
            return Container(
              color: Colors.white,
            );
          }
        },
      ),
    );
  }
}
