import 'package:get/get.dart';

import '../../data/services/network_caller.dart';
import '../../data/urls.dart';
import '../widgets/snacbar_messanger.dart';

class SignUpController extends GetxController{
  bool _inProgrees = false;
  String? _errorMessage;

  bool get inProgres => _inProgrees;
  String? get errorMessage => _errorMessage;

  Future<bool> SignUp(String email,String firstName,String lastName,String mobile,String password) async {
    bool isSuccess = false;
    _inProgrees = true;
    update();

    Map<String, String>requestBody = {
      "email": email,
      "firstName":firstName,
      "lastName": lastName,
      "mobile": mobile,
      "password": password,
    };
    //এটুকুই আমার নেটও্যয়ার্ক কল করার কোড ।
    // কারণ আমি সব অপারেশন NetworkCaller classe
    // এই করে পেলেছি।এখন শুধু এখানে এপ্লাই করার ফালা।
    NetworkResponse response =
    await NetworkCaller.postRequest(
        url: Urls.registrationUrl, body: requestBody);

    if (response.isSuccess && response.body?['data'] != null) {
      return true;
    } else {
      _errorMessage = response.errormessage!;
    }
    _inProgrees = false;
    update();
    return isSuccess;
  }

}