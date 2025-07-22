import 'package:email_validator/email_validator.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:task_management/data/service/network_caller.dart';
import 'package:task_management/data/urls.dart';
import 'package:task_management/ui/screens/sign_in_screen.dart';
import 'package:task_management/ui/widgets/screen_background.dart';
import 'package:task_management/ui/widgets/snacbar_messanger.dart';

class SignUpScreen extends StatefulWidget {

  const SignUpScreen({super.key});
  static const String name = '/sign-up';

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController emailTEController = TextEditingController();
  final TextEditingController passwordTEController = TextEditingController();
  final TextEditingController firstNamelTEController = TextEditingController();
  final TextEditingController lastNameTEController = TextEditingController();
  final TextEditingController mobileTEController = TextEditingController();
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool _signUpIn_Progress = false;
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
                Text('Join With Us',
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
                  textInputAction: TextInputAction.next,
                  controller: firstNamelTEController,
                  decoration: InputDecoration(hintText: 'First Name'),
                  validator: (String? value) {
                    if (value?.trim().isEmpty ?? true) {
                      return 'Enter your First name';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 8,
                ),
                TextFormField(
                  textInputAction: TextInputAction.next,
                  controller: lastNameTEController,
                  decoration: InputDecoration(hintText: 'Last Name'),
                  validator: (String? value) {
                    if (value?.trim().isEmpty ?? true) {
                      return 'Enter your Last name';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 8,
                ),
                TextFormField(
                  textInputAction: TextInputAction.next,
                  controller: mobileTEController,
                  keyboardType: TextInputType.phone,
                  decoration: InputDecoration(hintText: 'Mobile'),
                  validator: (String? value) {
                    if (value?.trim().isEmpty ?? true) {
                      return 'Enter your mobile number';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 8,
                ),
                TextFormField(
                  textInputAction: TextInputAction.next,
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
                  visible: _signUpIn_Progress == false,
                  replacement: Center(child: CircularProgressIndicator()),
                  child: ElevatedButton(
                      onPressed: _onTapSignUp_button,
                      child: Icon(Icons.arrow_circle_right_outlined)),
                ),
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
                ),
              ],
            ),
          ),
        ),
      )),
    );
  }

  void onTapSignIn_button() {
    Navigator.pushNamed(context, SignInScreen.name);
  }

  void _onTapSignUp_button() {
    //todo:API Calling
    _signUp();
  }

  Future<void> _signUp() async{
    _signUpIn_Progress = true;
    setState(() {});
    Map<String,String>requestBody=
    {
        "email":emailTEController.text.trim(),
        "firstName":firstNamelTEController.text.trim(),
        "lastName":lastNameTEController.text.trim(),
        "mobile":mobileTEController.text.trim(),
        "password":passwordTEController.text,
    };

    NetworkResponse response =
        await NetworkCaller.postRequest(url:Urls.registrationUrl,body: requestBody);

    _signUpIn_Progress = false;
    setState(() {});


    if(response.isSuccess)
      {
        Show_SnacBarMessage(context,'Registration has been success.plz log in');
      }else
        {
          Show_SnacBarMessage(context,response.errormessage!);
        }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    firstNamelTEController.dispose();
    emailTEController.dispose();
    mobileTEController.dispose();
    firstNamelTEController.dispose();
    lastNameTEController.dispose();
    passwordTEController.dispose();
    super.dispose();
  }
}
