import 'package:flutter/material.dart';

class EmptyCart extends StatelessWidget {
  const EmptyCart({super.key});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return Container(
      width: screenWidth,
      height: screenHeight - 200,
      color: Colors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Image.asset('assets/images/cart_empty.png'),
          Text(
            '!يبدو أن سلة التسوق الخاصة بك فارغة',
            style: TextStyle(
              fontSize: 20,
              color: Colors.grey[500],
              fontFamily: 'NotoSansArabic',
            ),
          ),
          Text(
            '.ابدأ التسوق وأضف المنتجات',
            style: TextStyle(
              fontSize: 20,
              color: Colors.grey[500],
              fontFamily: 'NotoSansArabic',
            ),
          )
        ],
      ),
    );
  }
}
