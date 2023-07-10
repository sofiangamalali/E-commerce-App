// ignore_for_file: must_be_immutable
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});
  late String phoneNumber;
  final GlobalKey<FormState> _phoneFormKey = GlobalKey();

  Widget _bulidIntroTexts() {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'تسجيل الدخول أو إنشاء حساب',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          Text(
            'سنرسل لك كود لتأكيد رقم الهاتف',
            style: TextStyle(
              fontSize: 18,
              color: Colors.grey[600],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPhoneFormField() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 1,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 19),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey[300]!),
              borderRadius: BorderRadius.circular(6),
            ),
            child: Center(
              child: Text(
                '${_getCountyFlag()} +20',
                style: const TextStyle(letterSpacing: 2, fontSize: 20),
              ),
            ),
          ),
        ),
        const SizedBox(
          width: 16,
        ),
        Expanded(
          flex: 2,
          child: Directionality(
            textDirection: TextDirection.rtl,
            child: TextFormField(
              textDirection: TextDirection.ltr,
              autofocus: true,
              inputFormatters: [
                LengthLimitingTextInputFormatter(11),
                FilteringTextInputFormatter.digitsOnly,
              ],
              style: const TextStyle(letterSpacing: 2, fontSize: 20),
              decoration: InputDecoration(
                focusedErrorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(6),
                  borderSide: BorderSide(color: Colors.red[500]!),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(6),
                  borderSide: BorderSide(color: Colors.grey[300]!),
                ),
                errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(6),
                  borderSide: BorderSide(color: Colors.red[500]!),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(6),
                  borderSide: BorderSide(color: Colors.grey[300]!),
                ),
                disabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(6),
                  borderSide: BorderSide(color: Colors.grey[300]!),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(6),
                  borderSide: BorderSide(color: Colors.grey[300]!),
                ),
                errorStyle: const TextStyle(
                  fontSize: 16,
                ),
              ),
              cursorColor: Colors.teal[300],
              keyboardType: TextInputType.phone,
              validator: (value) {
                if (value!.isEmpty) {
                  return 'أدخل رقم الهاتف';
                } else if (value.length < 11 || !value.startsWith('01')) {
                  return 'أدخل رقم هاتف صحيح';
                }
                return null;
              },
              onChanged: (value) {
                phoneNumber = value;
              },
            ),
          ),
        ),
      ],
    );
  }

  String _getCountyFlag() {
    String countryCode = 'eg';
    String flag = countryCode.toUpperCase().replaceAllMapped(
          RegExp(r'[A-Z]'),
          (match) => String.fromCharCode(
            match.group(0)!.codeUnitAt(0) + 127397,
          ),
        );
    return flag;
  }

  Widget _buildNextButton() {
    return ElevatedButton(
        onPressed: () {
          if (_phoneFormKey.currentState!.validate()) {
          } else {
            return;
          }
        },
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
        child: const CircularProgressIndicator(
          color: Colors.white,
        ));
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Scaffold(
          backgroundColor: Colors.white,
          body: Form(
            autovalidateMode: AutovalidateMode.onUserInteraction,
            key: _phoneFormKey,
            child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    const SizedBox(
                      height: 30,
                    ),
                    _bulidIntroTexts(),
                    const SizedBox(
                      height: 30,
                    ),
                    _buildPhoneFormField(),
                    Expanded(
                      child: Container(),
                    ),
                    _buildNextButton()
                  ],
                )),
          ),
        ),
      ),
    );
  }
}
