import 'package:get/get.dart';

import '../../data/services/network_caller.dart';
import '../../data/urls.dart';

class AddNewTaskController extends GetxController{
  bool _inProgress = false;
  String? _errorMessage ;

  bool get inProgress => _inProgress;
  String ? get errorMessage => _errorMessage;

  Future<bool> addNewTask(String title,String description,) async {
    bool isSuccess = false;
    _inProgress = true;
    update();

    Map<String, String> requestBody = {
      "title": title,
      "description": description,
      "status": "New"
    };

    NetworkResponse response = await NetworkCaller.postRequest(
        url: Urls.creatNewTasksUrl,
        body: requestBody
    );

    if(response.isSuccess){
      return true;

    }else{
      _errorMessage = response.errormessage;
    }
    _inProgress = false;
    update();
    return isSuccess;

  }


}