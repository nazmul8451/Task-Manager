import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:http/http.dart';
//create a class
class NetworkResponse {
  final bool isSuccess;
  final int statusCode;
  final Map<String,dynamic>? body;
  final String ? errormessage;
//create  a constructor
  NetworkResponse(
  {
    required this.statusCode,
    required this.isSuccess,
    this.body,///cause body thakteo pare na o thakte pare
    this.errormessage,///cause body thakteo pare na o thakte pare
  });
}


class NetworkCaller{
  static const String _defaultErrorMessage = 'Somethins went wrong';
  static Future<NetworkResponse> getRequest ({required String url}) async{
   try {
      Uri uri = Uri.parse(url);
      logRequest(url,null);
      Response response = await get(uri);
      logResponse(url, response);
      if (response.statusCode == 200) {
        final decodedJson = jsonDecode(response.body);
        return NetworkResponse(
          isSuccess: true,
            statusCode: response.statusCode,
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
    }catch(e)
    {
      return NetworkResponse(
        statusCode: -1,
        isSuccess: false,
        errormessage: e.toString(),
      );
    }
  }
  static Future<NetworkResponse> postRequest ({required String url,Map<String,String>? body}) async{
    try {
      Uri uri = Uri.parse(url);
      logRequest(url, body);
      Response response = await post(
          uri,
          headers: {
            'content-type': 'application/json'
          },
          body: jsonEncode(body)
      );
      logResponse(url, response);
      if (response.statusCode == 200) {
        final decodedJson = jsonDecode(response.body);
        return NetworkResponse(
            statusCode: response.statusCode,
            isSuccess: true);
      } else {
        final decodedJson = jsonDecode(response.body);
        return NetworkResponse(
          statusCode: response.statusCode,
          isSuccess: false,
          errormessage: decodedJson['data'] ?? _defaultErrorMessage,
        );
      }
    }catch(e)
    {
      return NetworkResponse(
        statusCode: -1,
        isSuccess: false,
        errormessage: e.toString(),
      );
    }
  }

  static void logRequest(String url,Map<String,String>? body){
    debugPrint('=====================Request========================\n'
        'URL: $url \n'
        'BODY:$body \n==================================================');
  }
  static void logResponse(String url,Response response){
    debugPrint('=====================Response========================\n'
        'URL: $url \n'
        'BODY:${response.body}\n'
        'STATUS CODE:${response.statusCode}\n'
        '=================================================================');

  }


}