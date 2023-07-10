import 'package:flutter/material.dart';

class LoactionNotSupported extends StatelessWidget {
  const LoactionNotSupported({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            const Text(
              'عفواً!لا نقم بالتوصيل لهذه المنطقة بعد',
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 35,
                  height: 1.5,
                  fontWeight: FontWeight.bold,
                  color: Colors.teal),
            ),
            Image.asset(
              'assets/images/loaction_not_supported.png',
              height: 250,
              width: 300,
            ),
            Text(
              'خدماتنا غير متوفرة في هذه المنطقة ,لكننا نعمل على التوصيل لجميع المناطق.',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 20, color: Colors.grey[600]),
            ),
            ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  fixedSize: const Size(450, 70),
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
                child: const Text('تغيير الموقع',
                    style:
                        TextStyle(fontSize: 20, fontFamily: 'NotoSansArabic')))
          ],
        ),
      ),
    );
  }
}
