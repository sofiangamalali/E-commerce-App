import 'package:elhaga/business_logic/bloc/settings/settings_bloc.dart';
import 'package:elhaga/helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../business_logic/bloc/cart/cart_bloc.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final Color backgroundColor;
  final bool isItemScreen;
  final bool isHomeScreen;
  final bool isLastOrderScreen;
  final bool withBackButton;
  final bool isOrderDetalisScreen;
  final VoidCallback? cancelOrder;

  const CustomAppBar({
    Key? key,
    this.withBackButton = false,
    this.isHomeScreen = false,
    this.isItemScreen = false,
    this.cancelOrder,
    required this.title,
    this.isOrderDetalisScreen = false,
    this.isLastOrderScreen = false,
    required this.backgroundColor,
  }) : super(key: key);

  Widget _buildCartIconWithCounter() {
    return Padding(
        padding: const EdgeInsets.only(left: 20, top: 11),
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Transform.scale(
              scaleX: -1,
              child: const Icon(Icons.shopping_cart_outlined,
                  color: Colors.teal, size: 40),
            ),
            BlocBuilder<CartBloc, CartState>(
              builder: (context, state) {
                if (state is CartLoaded) {
                  if (state.cart.getCount() == 0) {
                    return Container();
                  } else {
                    return Positioned(
                      left: -5,
                      top: -5,
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
                    );
                  }
                } else {
                  return Container();
                }
              },
            ),
          ],
        ));
  }

  Widget _buildChatIcon() {
    return Padding(
      padding: const EdgeInsets.only(left: 10),
      child: BlocBuilder<SettingsBloc, SettingsState>(
        builder: (context, state) {
          return InkWell(
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            onTap: state is SettingsLoaded
                ? () async {
                    openWhatsapp(
                        context: context, number: state.settings.contactPhone);
                  }
                : null,
            child: Transform.flip(
              flipX: true,
              child: Icon(
                Icons.chat_outlined,
                size: 30,
                color: Colors.teal[400],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildCancelORder() {
    return Padding(
      padding: const EdgeInsets.only(left: 10),
      child: InkWell(
        onTap: cancelOrder,
        child: const Icon(
          Icons.delete_outline_rounded,
          color: Colors.teal,
          size: 30,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Container(
        decoration: BoxDecoration(
          color: backgroundColor,
          border: Border(
            bottom: BorderSide(
              color: Colors.grey[300]!,
              width: 1.0,
            ),
          ),
        ),
        child: AppBar(
          systemOverlayStyle: SystemUiOverlayStyle.dark,
          centerTitle: true,
          actions: [
            isItemScreen
                ? _buildCartIconWithCounter()
                : isHomeScreen
                    ? _buildChatIcon()
                    : isOrderDetalisScreen
                        ? _buildCancelORder()
                        : Container(),
          ],
          leading: withBackButton
              ? InkWell(
                  splashColor: Colors.transparent,
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Icon(
                    Icons.arrow_back_ios,
                    color: Colors.teal[400],
                  ),
                )
              : isHomeScreen
                  ? Padding(
                      padding: const EdgeInsets.only(right: 10),
                      child: Image.asset(
                        'assets/images/app_icon.png',
                        height: 25,
                        width: 25,
                      ),
                    )
                  : Container(),
          title: Text(
            title,
            style: const TextStyle(
              fontSize: 22.0,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          backgroundColor: Colors.transparent,
          elevation: 0.0,
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight + 1.0);
}
