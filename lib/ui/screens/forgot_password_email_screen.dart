import 'package:email_validator/email_validator.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:task_management/ui/screens/change_password_screen.dart';
import 'package:task_management/ui/screens/pin_verificaiton_screen.dart';
import 'package:task_management/ui/screens/sign_up_screen.dart';
import 'package:task_management/ui/widgets/screen_background.dart';

class Forgot_passwordEmail_screen extends StatefulWidget {
  const Forgot_passwordEmail_screen({super.key});
  static const String name = '/forgot-password-email';

  @override
  State<Forgot_passwordEmail_screen> createState() =>
      _Forgot_passwordEmail_screenState();
}

class _Forgot_passwordEmail_screenState
    extends State<Forgot_passwordEmail_screen> {
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
                Text('Your Email Address',
                    style: Theme.of(context).textTheme.titleLarge),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  'A 6 digit verification pin will send to your\nemail address',
                  style: Theme.of(context)
                      .textTheme
                      .titleSmall
                      ?.copyWith(color: Colors.grey),
                ),
                const SizedBox(
                  height: 24,
                ),
                TextFormField(
                  controller: emailTEController,
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                    hintText: 'Email',
                  ),
                  validator: (String? value) {
                    String email = value ?? '';
                    if (EmailValidator.validate(email) == false) {
                      return 'Enter a valid email';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 16,
                ),
                ElevatedButton(
                    onPressed: onTap_Submit_Button,
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
    Navigator.pop(context);
  }

  void onTap_Submit_Button()
  {
    Navigator.pushNamed(
        context, Pin_Verification_Screen.name);
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
