
import 'package:flutter/material.dart';
import 'package:task_management/ui/widgets/center_circulerProgressbar.dart';

import '../../data/models/task_model.dart';
import '../../data/service/network_caller.dart';
import '../../data/urls.dart';
import '../widgets/Task_Card.dart';
import '../widgets/snacbar_messanger.dart';

class ProgressTaskListScreen extends StatefulWidget {
  const ProgressTaskListScreen({super.key});

  @override
  State<ProgressTaskListScreen> createState() => _ProgressTaskListScreenState();
}

class _ProgressTaskListScreenState extends State<ProgressTaskListScreen> {
  bool _getProgressTaskInProgress = false;
  List <TaskModel> _progressTaskList = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getProgressTaskList();
  }
  @override
  Widget build(BuildContext context) {
    return Padding(padding:EdgeInsets.symmetric(horizontal: 8),
    child: Visibility(
      visible: _getProgressTaskInProgress == true,
      replacement: CenterCirculerprogressbar(),
      child: ListView.builder(
          itemCount: _progressTaskList.length,
          itemBuilder: (contex,index){
            return Task_Card(
              taskType: TaskType.progress,
              taskModel: _progressTaskList[index],);
          }),
    ),
    );
  }

  Future<void> _getProgressTaskList() async {
    _getProgressTaskInProgress = true;
    setState(() {});
    NetworkResponse response =
    await NetworkCaller.getRequest(url: Urls.getProgressTasksUrl);



    if(response.isSuccess){
      //Models
      List<TaskModel> list = [];
      for(Map<String,dynamic>jsonData in response.body!['data'])
      {
        list.add(TaskModel.fromJson(jsonData));
      }
      _progressTaskList = list;
    }else{
      Show_SnacBarMessage(context, response.errormessage!);
    }
    _getProgressTaskInProgress =false;
    setState(() {});
  }

}
