import 'dart:convert';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart';
import 'package:task_management/app.dart';
import 'package:task_management/ui/controller/auth_controller.dart';
import 'package:task_management/ui/screens/sign_in_screen.dart';

//create a class
class NetworkResponse {
  final bool isSuccess;
  final int statusCode;
  final Map<String, dynamic>? body;
  final String? errormessage;
//create  a constructor
  NetworkResponse({
    required this.statusCode,
    required this.isSuccess,
    this.body,

    ///cause body thakteo pare na o thakte pare
    this.errormessage,

    ///cause body thakteo pare na o thakte pare
  });
}

class NetworkCaller {
  static const String _defaultErrorMessage = 'Something went wrong';
  static const String _unAuthorizeMessage = 'Un-authorized token';

  static Future<NetworkResponse> getRequest({required String url}) async {
    try {
      Uri uri = Uri.parse(url);
      final Map<String, String> headers = {
        'token': AuthController.accessToken ?? '',
      };
      _logRequest;(url, null, null,headers);
      Response response = await get(uri,headers: headers);
      logResponse(url, response);
      if (response.statusCode == 200) {
        final decodedJson = jsonDecode(response.body);
        return NetworkResponse(
          isSuccess: true,
          statusCode: response.statusCode,
          body: decodedJson,
        );
      }
      else if(response.statusCode == 401){
        _onUnAuthorize();
        final decodedJson = jsonDecode(response.body);
        return NetworkResponse(
          statusCode: response.statusCode,
          isSuccess: false,
          errormessage:_unAuthorizeMessage,
        );
      }
      else {
        final decodedJson = jsonDecode(response.body);
        return NetworkResponse(
          statusCode: response.statusCode,
          isSuccess: false,
          errormessage: decodedJson['data'] ?? _defaultErrorMessage,
        );
      }
    } catch (e) {
      return NetworkResponse(
        statusCode: -1,
        isSuccess: false,
        errormessage: e.toString(),
      );
    }
  }

  static Future<NetworkResponse> postRequest({required String url, Map<String, String>? body,bool isFromLogin = false}) async {
    try {
      Uri uri = Uri.parse(url);
      final Map<String, String> headers = {
            'content-type': 'application/json',
            'token': AuthController.accessToken ?? '',
          },
          _logRequest;(url, body, headers);
      Response response = await post(
        uri,
        headers: headers,
        body: jsonEncode(body),
      );

      logResponse(url, response);
      if (response.statusCode == 200) {
        final decodedJson = jsonDecode(response.body);
        return NetworkResponse(
          statusCode: response.statusCode,
          isSuccess: true,
          body: decodedJson,
        );
      }
      else if(response.statusCode == 401){
        if(isFromLogin == false) {
          _onUnAuthorize();
        }
        final decodedJson = jsonDecode(response.body);
        return NetworkResponse(
          statusCode: response.statusCode,
          isSuccess: false,
          errormessage:_unAuthorizeMessage,
        );
      }
      else {
        final decodedJson = jsonDecode(response.body);
        return NetworkResponse(
          statusCode: response.statusCode,
          isSuccess: false,
          errormessage: decodedJson['data'] ?? _defaultErrorMessage,
        );
      }
    } catch (e) {
      return NetworkResponse(
        statusCode: -1,
        isSuccess: false,
        errormessage: e.toString(),
      );
    }
  }

  static void _logRequest(
      String url, Map<String, String>? body, Map<String, String>? headers) {
    debugPrint('=====================Request========================\n'
        'URL: $url \n'
        'BODY:$body \n'
        'HEADERS:$headers\n'
        '==================================================');
  }

  static void logResponse(String url, Response response) {
    debugPrint('=====================Response========================\n'
        'URL: $url \n'
        'BODY:${response.body}\n'
        'STATUS CODE:${response.statusCode}\n'
        '=================================================================');
  }

  static Future<void> _onUnAuthorize() async {
    await AuthController.clearData();
    Navigator.of(TaskManager.navigator.currentContext!)
        .pushNamedAndRemoveUntil(SignInScreen.name, (predicate) => false);
  }
}
