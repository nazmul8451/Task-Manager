import 'package:http/http.dart';
//create a class
class NetworkResponse {
  final bool isSuccess ;
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
  static Future getRequest (String url) async{
    Uri uri = Uri.parse(url);
    Response response = await get(uri);
  }
}