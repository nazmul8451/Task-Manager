
import 'package:flutter/material.dart';
import 'package:task_management/ui/widgets/center_circulerProgressbar.dart';

import '../../data/models/task_model.dart';
import '../../data/service/network_caller.dart';
import '../../data/urls.dart';
import '../widgets/Task_Card.dart';
import '../widgets/snacbar_messanger.dart';

class Complete_TaskListScreen extends StatefulWidget {
   Complete_TaskListScreen({super.key});
  @override
  State<Complete_TaskListScreen> createState() => _Complete_TaskListScreenState();
}

class _Complete_TaskListScreenState extends State<Complete_TaskListScreen> {

  bool _getCompletedTaskInProgress = false;
  List <TaskModel> _CompletedTaskList= [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_){
      _getCompletedTaskList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(padding:EdgeInsets.symmetric(horizontal: 8),
      child: Visibility(
        visible: _getCompletedTaskInProgress == true,
        replacement: CenterCirculerprogressbar(),
        child: ListView.builder(
            itemCount: 10,
            itemBuilder: (contex,index){
              return Task_Card(
                taskModel: _CompletedTaskList[index],
                taskType: TaskType.completed, onStatusUpdate: () {
                  
              },

              );
            }),
      ),
    );
  }
  Future<void> _getCompletedTaskList() async {
    _getCompletedTaskInProgress = true;
    setState(() {});
    NetworkResponse response =
    await NetworkCaller.getRequest(url: Urls.getNewTasksUrl);

    if(response.isSuccess){
      //Models
      List<TaskModel> list = [];
      for(Map<String,dynamic>jsonData in response.body!['data'])
      {
        list.add(TaskModel.fromJson(jsonData));
      }
      _CompletedTaskList = list;
    }else{
      Show_SnacBarMessage(context, response.errormessage!);
    }
    _getCompletedTaskInProgress =false;
    setState(() {});
  }
}
