import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:task_management/ui/controller/auth_controller.dart';
import 'package:task_management/ui/screens/main_nav_bar_screen.dart';
import 'package:task_management/ui/screens/sign_in_screen.dart';
import 'package:task_management/ui/utils/assets_paths.dart';
import 'package:task_management/ui/widgets/screen_background.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});
  static const String name = '/';
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _moveToNextScreen();
  }

  Future<void> _moveToNextScreen() async {
    print("Starting splash screen delay...");
    await Future.delayed(Duration(seconds: 2));

    bool isLoggedIn = await AuthController.isUserLoggedIn();
    print("Is user logged in? $isLoggedIn");

    if (isLoggedIn) {
      print("Navigating to MainNavBarScreen");
      Navigator.pushReplacementNamed(context, MainNavBarScreen.name);
    } else {
      print("Navigating to SignInScreen");
      Navigator.pushReplacementNamed(context, SignInScreen.name);
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: ScreenBackground(
        child: Center(
          child: SvgPicture.asset(AssetsPaths.logoSvg),
        ),
      ),
    );
  }
}
