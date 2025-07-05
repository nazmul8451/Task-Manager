import 'package:email_validator/email_validator.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:task_management/ui/screens/forgot_password_email_screen.dart';
import 'package:task_management/ui/screens/pin_verificaiton_screen.dart';
import 'package:task_management/ui/screens/sign_in_screen.dart';
import 'package:task_management/ui/screens/sign_up_screen.dart';
import 'package:task_management/ui/widgets/screen_background.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});
  static const String name = '/change-password';

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final TextEditingController passwordTEController = TextEditingController();
  final TextEditingController confirm_passwordTEController = TextEditingController();
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
                    Text('Set Password',
                        style: Theme.of(context).textTheme.titleLarge),
                    Text(
                      'Minimum length password 8 character with\nLatter and number combination',
                      style: Theme.of(context)
                          .textTheme
                          .titleSmall
                          ?.copyWith(color: Colors.grey),
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                    TextFormField(
                      controller: passwordTEController,
                      textInputAction: TextInputAction.next,
                      decoration: InputDecoration(
                        hintText: 'Password',
                      ),
                      validator: (String? value){
                        if((value?.length ?? 0)<=8)
                        {
                          return 'Enter a valid password';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    TextFormField(
                      controller: confirm_passwordTEController,
                      obscureText: true,
                      decoration: InputDecoration(hintText: 'Confirm Password'),
                      validator: (String? value){
                        if((value?? '')!= passwordTEController.text)
                        {
                          return "Confirm password doesn't match";
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    ElevatedButton(
                        onPressed: (){},
                        child: Text('Confirm')),
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
                                        ..onTap = onTapSignIn_button,
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
    Navigator.pushNamedAndRemoveUntil(context, SignInScreen.name, (predicate)=> false);
  }

  @override
  void dispose(){
    confirm_passwordTEController.dispose();
    passwordTEController.dispose();
    super.dispose();
  }




}
