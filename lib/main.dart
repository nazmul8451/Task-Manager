import 'package:device_preview/device_preview.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:task_management/ui/screens/change_password_screen.dart';
import 'package:task_management/ui/screens/forgot_password_email_screen.dart';
import 'package:task_management/ui/screens/sign_in_screen.dart';
import 'package:task_management/ui/screens/sign_up_screen.dart';
import 'package:task_management/ui/screens/splash_screen.dart';

//All Package imported


void main() {
  runApp(
    DevicePreview(
      enabled: !kReleaseMode,
      builder: (context) => MaterialApp(
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
        }
      ), // runApp এর ভিতরে DevicePreview
    ),
  );
}
