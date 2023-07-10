import 'package:flutter/material.dart';

class IconContainer extends StatelessWidget {
  final Widget child;
  final Color color;
  const IconContainer({super.key, required this.child, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 30,
      height: 30,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(5),
      ),
      child: Center(child: child),
    );
  }
}
