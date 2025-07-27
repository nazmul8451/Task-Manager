import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import '../../data/models/users_model.dart';

class AuthController {
  static UserModel? userModel;
  static String? accessToken;

  static const String _userDataKey = 'user-data';
  static const String _tokenKey = 'token';

  static Future<void> saveUserData(UserModel model, String token) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.setString(_userDataKey, jsonEncode(model.toJson()));
    await sharedPreferences.setString(_tokenKey, token);
    userModel = model;
    accessToken = token;
  }

  static Future<void> updateUserData(UserModel model) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.setString(_userDataKey, jsonEncode(model.toJson()));
    userModel = model;
  }
//get user data
  static Future<void> getUserData() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String? userDataString = sharedPreferences.getString(_userDataKey);
    if (userDataString != null) {
      userModel = UserModel.fromJson(jsonDecode(userDataString));
    }
    accessToken = sharedPreferences.getString(_tokenKey);
  }


  static Future<bool> isUserLoggedIn() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String? token = sharedPreferences.getString(_tokenKey);
    if (token != null) {
      await getUserData();
      return true;
    } else {
      return false;
    }
  }
//log out korle data clear korar dorkar tai ei function kaj korbe
  static Future<void> clearData() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.clear();
    accessToken = null;
    userModel = null;
  }
}