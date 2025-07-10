import 'package:email_validator/email_validator.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:task_management/ui/screens/change_password_screen.dart';
import 'package:task_management/ui/screens/sign_in_screen.dart';
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
  final TextEditingController OtpTEController = TextEditingController();
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
                //otp pin submitted filled
                PinCodeTextField(
                  length: 6,
                  animationType: AnimationType.fade,
                  keyboardType: TextInputType.number,
                  pinTheme: PinTheme(
                      shape: PinCodeFieldShape.box,
                      borderRadius: BorderRadius.circular(5),
                      fieldHeight: 50,
                      fieldWidth: 40,
                      activeFillColor: Colors.white,
                      selectedColor: Colors.green,
                      inactiveColor: Colors.grey
                  ),
                  animationDuration: Duration(milliseconds: 300),
                  backgroundColor: Colors.transparent,
                  controller: OtpTEController,
                  appContext: context,
                ),

                //-----

                const SizedBox(
                  height: 16,
                ),
                ElevatedButton(
                    onPressed: onTapSubmitButton,
                    child: Text('Verify')),
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
    Navigator.pushNamedAndRemoveUntil(context, SignInScreen.name, (predicate)=>false);
  }

void onTapSubmitButton()
{
  Navigator.pushNamed(context, ChangePasswordScreen.name);
}


  @override
  void dispose() {
    OtpTEController.dispose();
    passwordTEController.dispose();
    super.dispose();
  }
}
