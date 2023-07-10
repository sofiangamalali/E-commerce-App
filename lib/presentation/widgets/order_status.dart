import 'package:flutter/material.dart';

class OrderStatus extends StatelessWidget {
  final String? orderStatus;
  const OrderStatus({required this.orderStatus, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        color: orderStatus == 'جديد'
            ? Colors.green
            : orderStatus == 'جاري التوصيل'
                ? Colors.orange
                : orderStatus == 'تم التسليم'
                    ? Colors.grey
                    : Colors.red,
      ),
      child: Center(
        child: Text(
          orderStatus!.toUpperCase(),
          style: const TextStyle(
            color: Colors.white,
            fontSize: 16,
            height: 1,
          ),
        ),
      ),
    );
  }
}
