// ignore_for_file: must_be_immutable
import 'package:elhaga/presentation/widgets/custom_button.dart';
import 'package:flutter/Material.dart';
import 'package:flutter/services.dart';

class SignUpScreen extends StatelessWidget {
  static const String url = 'SignUpScreen';
  SignUpScreen({super.key});
  late String firstName;
  late String lastName;
  final String email = '';
  final GlobalKey<FormState> _signUpFormKey = GlobalKey();

  Widget _bulidIntroTexts() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        const Text(
          'الخطوة الأخيرة لإنشاء حسابك',
          style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
        ),
        Text(
          '!أضف معلوماتك الأساسية لبدء التسوق',
          style: TextStyle(
            fontSize: 20,
            color: Colors.grey[600],
          ),
        ),
      ],
    );
  }

  Widget _buildFirstNameAndLastNameRow() {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //FirstName
          Directionality(
            textDirection: TextDirection.rtl,
            child: Expanded(
              flex: 1,
              child: TextFormField(
                style: const TextStyle(fontSize: 20),
                inputFormatters: [
                  LengthLimitingTextInputFormatter(10),
                ],
                decoration: InputDecoration(
                  hintText: 'الأسم الأول',
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
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'أدخل الأسم الأول';
                  } else if (value.length < 3) {
                    return 'أدخل أسم صحيح';
                  }
                  return null;
                },
                onChanged: (value) {
                  firstName = value;
                },
              ),
            ),
          ),
          const SizedBox(
            width: 20,
          ),
          //LastName
          Directionality(
            textDirection: TextDirection.rtl,
            child: Expanded(
              flex: 1,
              child: TextFormField(
                style: const TextStyle(fontSize: 20),
                inputFormatters: [
                  LengthLimitingTextInputFormatter(10),
                ],
                decoration: InputDecoration(
                  hintText: 'الأسم الأخير',
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
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'أدخل الأسم الأخير';
                  } else if (value.length < 3) {
                    return 'أدخل أسم صحيح';
                  }
                  return null;
                },
                onChanged: (value) {
                  lastName = value;
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmailTextField() {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Expanded(
        flex: 1,
        child: TextFormField(
          style: const TextStyle(fontSize: 20),
          keyboardType: TextInputType.emailAddress,
          decoration: InputDecoration(
            hintText: ' البريد الالكتروني (إختياري)',
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
          validator: (value) {
            if (value!.isEmpty) {
              return null;
            } else {
              bool isValid =
                  RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value);
              return isValid ? null : 'أدخل بريد الكتروني صالح';
            }
          },
        ),
      ),
    );
  }

  Widget _buildSignUpButton() {
    return CustomButton(
        onPressed: () {
          if (_signUpFormKey.currentState!.validate()) {
            //TODO
          } else {}
        },
        title: const Text('إنشاء الحساب'));
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
          body: SingleChildScrollView(
            child: Form(
              autovalidateMode: AutovalidateMode.onUserInteraction,
              key: _signUpFormKey,
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
                    _buildFirstNameAndLastNameRow(),
                    const SizedBox(
                      height: 20,
                    ),
                    _buildEmailTextField(),
                    Expanded(
                      child: Container(),
                    ),
                    _buildSignUpButton()
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
