import 'package:email_validator/email_validator.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:task_management/ui/screens/sign_up_screen.dart';
import 'package:task_management/ui/widgets/screen_background.dart';


class Pin_Verification_Screen extends StatefulWidget {
  const Pin_Verification_Screen({super.key});
  static const String name = '/pin-verificaition-screen';

  @override
  State<Pin_Verification_Screen> createState() =>
      _Pin_Verification_ScreenState();
}

class _Pin_Verification_ScreenState extends State<Pin_Verification_Screen> {
  final TextEditingController emailTEController = TextEditingController();
  final TextEditingController passwordTEController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ScreenBackground(
          child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Form(
            key: _formKey,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 80,
                ),
                Text('PIN Verification',
                    style: Theme.of(context).textTheme.titleLarge),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  'A 6 digits OTP has been send to your email address',
                  style: Theme.of(context)
                      .textTheme
                      .titleSmall
                      ?.copyWith(
                      color: Colors.grey),
                ),
                const SizedBox(
                  height: 24,
                ),

                const SizedBox(
                  height: 16,
                ),
                ElevatedButton(
                    onPressed: (){},
                    child: Icon(Icons.arrow_circle_right_outlined)),
                const SizedBox(
                  height: 40,
                ),
                Center(
                  child: Column(
                    children: [
                      RichText(
                          text: TextSpan(
                              text: "Have account? ",
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                color: Colors.black,
                                letterSpacing: 0.5,
                              ),
                              children: [
                            TextSpan(
                              text: 'Sign In',
                              style: TextStyle(
                                color: Colors.green,
                                fontWeight: FontWeight.w700,
                              ),
                              recognizer: TapGestureRecognizer()
                                ..onTap = onTapSignUp_button,
                            )
                          ])),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      )),
    );
  }

  void onTapSignIn_button() {
    if (_formKey.currentState!.validate()) {
      //TODO: Sign in with API
    }
  }

  void onTap_ForgotPassword() {}

  void onTapSignUp_button() {
    Navigator.pushReplacementNamed(context, SignUpScreen.name);
  }

  @override
  void dispose() {
    emailTEController.dispose();
    passwordTEController.dispose();
    super.dispose();
  }
}
