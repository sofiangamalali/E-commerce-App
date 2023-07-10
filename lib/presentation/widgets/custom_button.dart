import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final VoidCallback onPressed;
  final Widget title;
  final double width;
  final bool isEnable;
  final Widget disabledWidget;
  const CustomButton({
    super.key,
    this.width = 20,
    required this.onPressed,
    this.disabledWidget = const Text(
      'نفذت الكمية',
      style: TextStyle(fontFamily: 'Cairo'),
    ),
    this.isEnable = true,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return ElevatedButton(
      onPressed: isEnable ? onPressed : null,
      style: ElevatedButton.styleFrom(
        fixedSize: Size(screenWidth - width, 60),
        padding: const EdgeInsets.symmetric(
          horizontal: 16.0,
          vertical: 8.0,
        ),
        backgroundColor: Colors.teal,
        textStyle: const TextStyle(
          fontSize: 18.0,
          fontWeight: FontWeight.bold,
          fontFamily: 'Cairo',
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
      child: isEnable ? title : disabledWidget,
    );
  }
}
