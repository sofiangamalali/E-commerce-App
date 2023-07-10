import 'package:flutter/Material.dart';

class RadioListTileForPayment extends StatefulWidget {
  const RadioListTileForPayment({super.key});

  @override
  State<RadioListTileForPayment> createState() =>
      _RadioListTileForPaymentState();
}

class _RadioListTileForPaymentState extends State<RadioListTileForPayment> {
  String? selectedOption = '';

  @override
  void initState() {
    super.initState();

    selectedOption = 'Cash';
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          border: Border.all(color: Colors.teal),
          borderRadius: BorderRadius.circular(6),
          color: Colors.teal[100]),
      child: RadioListTile<String>(
        title: Directionality(
          textDirection: TextDirection.rtl,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                'الدفع عند التوصيل ',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Image.asset(
                'assets/icons/cashIcon.png',
                height: 40,
                width: 40,
              )
            ],
          ),
        ),
        value: 'Cash',
        groupValue: selectedOption,
        onChanged: (value) {
          setState(() {
            selectedOption = value;
          });
        },
        activeColor: Colors.teal,
      ),
    );
  }
}
