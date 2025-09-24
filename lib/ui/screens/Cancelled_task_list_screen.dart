
import 'package:flutter/material.dart';
import 'package:task_management/data/models/task_model.dart';
import 'package:task_management/data/services/network_caller.dart';
import 'package:task_management/data/urls.dart';
import 'package:task_management/ui/widgets/snacbar_messanger.dart';

import '../widgets/Task_Card.dart';
import '../widgets/center_circulerProgressbar.dart';

class Cancelled_TaskListScreen extends StatefulWidget {
  const Cancelled_TaskListScreen({super.key});

  @override
  State<Cancelled_TaskListScreen> createState() => _Cancelled_TaskListScreenState();
}

class _Cancelled_TaskListScreenState extends State<Cancelled_TaskListScreen> {

  bool _getcancelledTaskInProgress = false;
  List CancelledTaskList = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_){
      _getcancelledTaskList();
    });
  }
  @override
  Widget build(BuildContext context) {
    return Padding(padding:EdgeInsets.symmetric(horizontal: 8),
      child: Visibility(
        visible: _getcancelledTaskInProgress == false,
        replacement: CenterCirculerprogressbar(),
        child: ListView.builder(
            itemCount: CancelledTaskList.length,
            itemBuilder: (contex,index){
              return Task_Card(
                taskModel: CancelledTaskList[index],
                taskType: TaskType.cancelled,
                onStatusUpdate: () {
                _getcancelledTaskList();
              },
              );
            }),
      ),
    );
  }


  Future <void> _getcancelledTaskList () async
  {
    _getcancelledTaskInProgress = true;
    setState(() {});
    NetworkResponse response = await NetworkCaller.getRequest(url: Urls.getCancelledTasksUrl);
    if(response.isSuccess){
      List <TaskModel> list = [];
      for(Map<String,String>? jsonData in response.body!['data']){
        if(jsonData != null)
          {
            list.add(TaskModel.fromJson(jsonData));
          }
          CancelledTaskList = list;
      }

    }else{
      Show_SnacBarMessage(context, response.errormessage!);
    }
    _getcancelledTaskInProgress = false;
    setState(() {});

  }



}
