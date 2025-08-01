import 'dart:math';

import 'package:device_preview/device_preview.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:task_management/ui/controller/auth_controller.dart';
import 'package:task_management/ui/screens/Add_New_Task.dart';
import 'package:task_management/ui/screens/Update_profile_screen.dart';
import 'package:task_management/ui/screens/change_password_screen.dart';
import 'package:task_management/ui/screens/forgot_password_email_screen.dart';
import 'package:task_management/ui/screens/main_nav_bar_screen.dart';
import 'package:task_management/ui/screens/pin_verificaiton_screen.dart';
import 'package:task_management/ui/screens/sign_in_screen.dart';
import 'package:task_management/ui/screens/sign_up_screen.dart';
import 'package:task_management/ui/screens/splash_screen.dart';

//All Package imported
class TaskManager extends StatelessWidget {
  const TaskManager({super.key});
  static GlobalKey<NavigatorState>navigator = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        navigatorKey:navigator ,
        theme: ThemeData(
            colorSchemeSeed: Colors.green,
            textTheme: TextTheme(
              titleLarge: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.w700
              ),
            ),
            inputDecorationTheme: InputDecorationTheme(
              filled: true,
              fillColor: Colors.white,
              contentPadding:
              EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              hintStyle: TextStyle(
                color: Colors.grey,
              ),
              border: OutlineInputBorder(
                borderSide: BorderSide.none,
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide.none,
              ),
              errorBorder: OutlineInputBorder(
                borderSide: BorderSide.none,
              ),
            ),
            elevatedButtonTheme: ElevatedButtonThemeData(
                style: ElevatedButton.styleFrom(
                  fixedSize: Size.fromWidth(double.maxFinite),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4)
                  ),
                  padding: EdgeInsets.symmetric(vertical: 15),
                  backgroundColor: Colors.green,
                  foregroundColor: Colors.white,
                )
            ),
            textButtonTheme: TextButtonThemeData(
                style: TextButton.styleFrom(
                  foregroundColor: Colors.green,
                )
            )
        ),
        useInheritedMediaQuery: true,
        debugShowCheckedModeBanner: false,
        initialRoute: '/',
        routes: {
          SplashScreen.name : (context) => SplashScreen(),
          SignInScreen.name : (context) => SignInScreen(),
          SignUpScreen.name : (context) => SignUpScreen(),
          Forgot_passwordEmail_screen.name: (context) => Forgot_passwordEmail_screen(),
          ChangePasswordScreen.name : (context) => ChangePasswordScreen(),
          Pin_Verification_Screen.name : (context) => Pin_Verification_Screen(),
          MainNavBarScreen.name: (context) => MainNavBarScreen(),
          AddNewTask.name : (context) => AddNewTask(),
          UpdateProfileScreen.name : (context) => UpdateProfileScreen(),
        }
    );
  }
}
