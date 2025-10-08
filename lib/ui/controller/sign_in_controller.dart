import 'package:get/get.dart';
import 'package:task_management/data/services/network_caller.dart';
import '../../data/models/users_model.dart';
import '../../data/urls.dart';
import 'auth_controller.dart';

class SignInController extends GetxController{
  bool _inProgress = false;
  String? _errorMessage;
  bool get inProgress => _inProgress;
  String? get errorMessage => _errorMessage;
  //Sign in api call
  Future<bool> SignIn(String email,String password) async {
    bool isSucces = false;
    _inProgress = true;
    update();

    Map<String, String> requestBody = {
      "email": email,
      "password": password,
    };
    NetworkResponse response = await NetworkCaller.postRequest(
      url: Urls.logInUrl,
      body: requestBody,
      isFromLogin: true,
    );

    if (response.isSuccess && response.body?['data'] != null) {

      UserModel userModel = UserModel.fromJson(response.body!['data']);
      String token = response.body!['token'];

      await AuthController.saveUserData(userModel, token);
      isSucces = true;
      _errorMessage = null;

    } else {
      _errorMessage = response.errormessage!;
    }

    _inProgress = false;
    update();

    return isSucces;
  }




}