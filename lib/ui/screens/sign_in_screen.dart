import 'package:email_validator/email_validator.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:task_management/data/models/users_model.dart';
import 'package:task_management/data/services/network_caller.dart';
import 'package:task_management/data/urls.dart';
import 'package:task_management/ui/controller/auth_controller.dart';
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
  bool _signInProgress = false;
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


                Visibility(
                  visible: _signInProgress == false,
                  replacement: CenterCirculerprogressbar(),
                  child: ElevatedButton(
                      onPressed: onTapSignIn_button,
                      child: Icon(Icons.arrow_circle_right_outlined)),
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

  //API calling for Sign In
  Future<void> _SignIn() async {
    _signInProgress = true;
    setState(() {});
    Map<String, String> requestBody = {
      "email": emailTEController.text.trim(),
      "password": passwordTEController.text,
    };
    NetworkResponse response = await NetworkCaller.postRequest(
      url: Urls.logInUrl,
      body: requestBody,
      isFromLogin: true,
    );

    if (response.isSuccess && response.body?['data'] != null) {

      UserModel userModel = UserModel.fromJson(response.body!['data']);
      String token = response.body!['token'];

      await AuthController.saveUserData(userModel, token);

      Navigator.pushNamedAndRemoveUntil(
          context, MainNavBarScreen.name, (predicate) => false);
    } else {
      _signInProgress = false;
      if(mounted) {
        setState(() {});
      }
      Show_SnacBarMessage(context, response.errormessage!);
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
