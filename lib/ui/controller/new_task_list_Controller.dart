import 'package:get/get.dart';

import '../../data/models/task_model.dart';
import '../../data/services/network_caller.dart';
import '../../data/urls.dart';

class NewTaskListController extends GetxController{
  bool _inProgress = false;
  String ? _errorMessage ;

  List<TaskModel> _newTaskList = [];
  //
  bool get inProgress => _inProgress;
  String ? get errorMessage => _errorMessage;
  List<TaskModel> get newTaskList => _newTaskList;
  //
  Future<bool> getNewTaskList() async {
    bool isSuccess = false;
    _inProgress = true;
    update();
    NetworkResponse response =

    await NetworkCaller.getRequest(url: Urls.getNewTasksUrl);

    if(response.isSuccess){
      //Models
      List<TaskModel> list = [];
      for(Map<String,dynamic>jsonData in response.body!['data'])
      {
        list.add(TaskModel.fromJson(jsonData));
      }
      _newTaskList = list;
      _errorMessage = null;
    }else{
      _errorMessage = response.errormessage;
    }
    _inProgress = false;
    update();
    return isSuccess;
  }
}