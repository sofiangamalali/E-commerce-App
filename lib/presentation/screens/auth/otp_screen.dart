// ignore_for_file: prefer_const_constructors_in_immutables, prefer_typing_uninitialized_variables, no_leading_underscores_for_local_identifiers, must_be_immutable

import 'package:flutter/Material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class OtpScreen extends StatelessWidget {
  final phoneNumber;
  late String otpCode;
  OtpScreen({super.key, required this.phoneNumber});

  @override
  Widget build(BuildContext context) {
    Widget _buildIntroTexts() {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          const RotatedBox(
            quarterTurns: 90,
            child: Icon(
              Icons.arrow_back_ios_new_rounded,
              color: Colors.teal,
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          const Text(
            'تأكيد رقم الهاتف',
            style: TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            'أدخل الكود المكون من 6 أرقام المرسل إلى',
            style: TextStyle(
              fontSize: 20,
              color: Colors.grey[600],
            ),
          ),
          Text(
            phoneNumber,
            style: TextStyle(
              fontSize: 20,
              color: Colors.blue[600],
              letterSpacing: 2,
            ),
          ),
        ],
      );
    }

    Widget _buildPinCodeFields(BuildContext context) {
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: PinCodeTextField(
          appContext: context,
          autoFocus: true,
          cursorColor: Colors.teal,
          keyboardType: TextInputType.number,
          length: 6,
          obscureText: false,
          animationType: AnimationType.scale,
          pinTheme: PinTheme(
            shape: PinCodeFieldShape.box,
            borderRadius: BorderRadius.circular(5),
            fieldHeight: 50,
            fieldWidth: 40,
            borderWidth: 1,
            activeColor: Colors.teal[300],
            inactiveColor: Colors.grey[300],
            inactiveFillColor: Colors.white,
            activeFillColor: Colors.white,
            selectedColor: Colors.teal,
            selectedFillColor: Colors.white,
          ),
          animationDuration: const Duration(milliseconds: 300),
          backgroundColor: Colors.white,
          enableActiveFill: true,
          onCompleted: (code) {
            otpCode = code;
          },
          onChanged: (code) {},
        ),
      );
    }

    Widget _buildVerifyButton() {
      return ElevatedButton(
        onPressed: () {},
        style: ElevatedButton.styleFrom(
          fixedSize: const Size(450, 60),
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
            borderRadius: BorderRadius.circular(6.0),
          ),
        ),
        child: const Text('تأكيد رقم الهاتف'),
      );
    }

    return SafeArea(
      child: Scaffold(
        body: Container(
          color: Colors.white,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              _buildIntroTexts(),
              const SizedBox(
                height: 20,
              ),
              _buildPinCodeFields(context),
              Expanded(
                child: Container(),
              ),
              _buildVerifyButton(),
            ],
          ),
        ),
      ),
    );
  }
}
