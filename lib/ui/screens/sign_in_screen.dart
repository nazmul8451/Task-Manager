import 'package:email_validator/email_validator.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_management/ui/controller/sign_in_controller.dart';
import 'package:task_management/ui/screens/forgot_password_email_screen.dart';
import 'package:task_management/ui/screens/main_nav_bar_screen.dart';
import 'package:task_management/ui/screens/sign_up_screen.dart';
import 'package:task_management/ui/widgets/center_circulerProgressbar.dart';
import 'package:task_management/ui/widgets/screen_background.dart';
import 'package:task_management/ui/widgets/snacbar_messanger.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});
  static const String name = '/sign-in';

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final TextEditingController emailTEController = TextEditingController();
  final TextEditingController passwordTEController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final SignInController _signInController = SignInController();

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
                Text('Get Started With',
                    style: Theme.of(context).textTheme.titleLarge),
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
                  height: 8,
                ),
                TextFormField(
                  controller: passwordTEController,
                  obscureText: true,
                  decoration: InputDecoration(hintText: 'Password'),
                  validator: (String? value) {
                    if ((value?.length ?? 0) <= 6) {
                      return 'Enter a valid password';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 16,
                ),


                GetBuilder(
                  init: _signInController,
                  builder: (controller) {
                    return Visibility(
                      visible: controller.inProgress == false,
                      replacement: CenterCirculerprogressbar(),
                      child: ElevatedButton(
                          onPressed: onTapSignIn_button,
                          child: Icon(Icons.arrow_circle_right_outlined)),
                    );
                  }
                ),


                const SizedBox(
                  height: 40,
                ),
                Center(
                  child: Column(
                    children: [
                      TextButton(
                          onPressed: onTap_ForgotPassword,
                          child: Text(
                            'Forgot Password?',
                            style: TextStyle(
                              color: Colors.grey,
                            ),
                          )),
                      RichText(
                          text: TextSpan(
                              text: "Don't have an account? ",
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                color: Colors.black,
                                letterSpacing: 0.5,
                              ),
                              children: [
                            TextSpan(
                              text: 'Sign Up',
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
      _SignIn();
    }
  }


  // API calling for Sign In
  Future<void> _SignIn() async {
    final bool  isSuccess = await _signInController.SignIn
      (emailTEController.text.trim(), passwordTEController.text);
    if(isSuccess){
      Get.offAllNamed(MainNavBarScreen.name);
    }else{
      Show_SnacBarMessage(context, _signInController.errorMessage!);
    }
  }

  void onTap_ForgotPassword() {
    Navigator.pushReplacementNamed(context, Forgot_passwordEmail_screen.name);
  }

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
