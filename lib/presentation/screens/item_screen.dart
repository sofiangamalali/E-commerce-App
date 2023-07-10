import 'package:cached_network_image/cached_network_image.dart';
import 'package:elhaga/Data/Models/offer_model.dart';
import 'package:elhaga/presentation/widgets/custom_appbar.dart';
import 'package:elhaga/presentation/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../Data/Models/item_model.dart';
import '../../business_logic/bloc/cart/cart_bloc.dart';

class ItemScreen extends StatelessWidget {
  final Item item;
  const ItemScreen({super.key, required this.item});
  Widget _buildProductImage(screenWidth, screenHeight) {
    return SizedBox(
      height: screenHeight / 3,
      width: screenWidth,
      child: Center(
        child: CachedNetworkImage(
          imageUrl: item.image,
          placeholder: (context, url) => Container(),
          width: item is Offer ? screenWidth : screenWidth / 2,
          height: item is Offer ? screenHeight / 3 : screenHeight / 4,
          fit: BoxFit.fill,
        ),
      ),
    );
  }

  Widget _buildProductNameAndPrice() {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(
                item.name,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Text(
              '${item.price.toStringAsFixed(2)} ج.م',
              style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.teal),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProdcutDiscreption(screenHeight) {
    return Container(
      height: screenHeight / 3,
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 10),
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(color: Colors.grey[400]!),
          bottom: BorderSide(color: Colors.grey[400]!),
        ),
      ),
      child: Text(
        item.description,
        maxLines: 8,
        overflow: TextOverflow.ellipsis,
        textDirection: TextDirection.rtl,
        style: TextStyle(
          fontFamily: 'NotoSansArabic',
          color: Colors.grey[600],
          fontSize: 17,
          height: 2,
        ),
      ),
    );
  }

  Widget _buildAddToCartButton() {
    return BlocBuilder<CartBloc, CartState>(
      builder: (context, state) {
        if (state is CartLoaded) {
          return CustomButton(
            isEnable: state.cart.checkProductStock(item, state.cart.items),
            onPressed: () {
              context.read<CartBloc>().add(CartItemAdded(item));
            },
            title: const Text('أضف إلى السلة'),
          );
        } else {
          return Container();
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const CustomAppBar(
        title: '',
        backgroundColor: Colors.white,
        isItemScreen: true,
        withBackButton: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Column(
              children: [
                _buildProductImage(screenWidth, screenHeight),
                const SizedBox(height: 10),
                _buildProductNameAndPrice(),
                const SizedBox(height: 10),
                _buildProdcutDiscreption(screenHeight),
              ],
            ),
          ),
          _buildAddToCartButton(),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
