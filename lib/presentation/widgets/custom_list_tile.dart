// ignore_for_file: must_be_immutable
import 'package:flutter/Material.dart';

class CustomListTile extends StatelessWidget {
  final String title;
  final IconData leading;
  final bool showArrow;
  final VoidCallback onTap;
  const CustomListTile(
      {super.key,
      required this.onTap,
      required this.title,
      required this.leading,
      required this.showArrow});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: Colors.transparent,
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
        ),
        width: double.infinity,
        height: 60,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                RotatedBox(
                  quarterTurns: showArrow ? 0 : 90,
                  child: Icon(
                    leading,
                    color: Colors.teal[700],
                    size: 28,
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 24,
                    color: Colors.grey[800],
                  ),
                )
              ],
            ),
            showArrow
                ? RotatedBox(
                    quarterTurns: 90,
                    child: Icon(
                      Icons.arrow_back_ios,
                      color: Colors.teal[700],
                    ),
                  )
                : Container()
          ],
        ),
      ),
    );
  }
}
