import 'package:flutter/material.dart';
import 'package:task_management/data/models/task_model.dart';
import 'package:task_management/data/models/task_status_count.dart';
import 'package:task_management/data/service/network_caller.dart';
import 'package:task_management/data/urls.dart';
import 'package:task_management/ui/screens/Add_New_Task.dart';
import 'package:task_management/ui/widgets/center_circulerProgressbar.dart';
import 'package:task_management/ui/widgets/snacbar_messanger.dart';

import '../widgets/TaskCount_summuryCard.dart';
import '../widgets/Task_Card.dart';

class NewTaskListScreen extends StatefulWidget {
  NewTaskListScreen({
    super.key,
  });

  @override
  State<NewTaskListScreen> createState() => _NewTaskListScreenState();
}

class _NewTaskListScreenState extends State<NewTaskListScreen> {

  bool _getNewTaskInProgress = false;
  bool _getTaskStatusCountInProgress = false;
  List <TaskModel> _newTaskList= [];
  List<TaskStatusCountModel> _taskStatusCountList= [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_){
      _getNewTaskList();
      _getNewTaskStatusList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Column(
          children: [
            const SizedBox(
              height: 16,
            ),
            SizedBox(
              height: 100,
              child: Visibility(
                visible: _getTaskStatusCountInProgress == false,
                replacement: CenterCirculerprogressbar(),
                child: ListView.separated(
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  scrollDirection: Axis.horizontal,
                  itemCount: _taskStatusCountList.length,
                  itemBuilder: (context, index) {
                    return Task_count_summuryCard(
                        title: _taskStatusCountList[index].id,
                        count: _taskStatusCountList[index].count);
                  },
                  separatorBuilder: (context, index) => const SizedBox(
                    width: 4,
                  ),
                ),
              ),
            ),
            Visibility(


              child: Expanded(
                  child: ListView.builder(
                      itemCount: _newTaskList.length,
                      itemBuilder: (contex, index) {
                        return Task_Card(
                          taskModel: _newTaskList[index],
                          taskType: TaskType.tNew,
                        );
                      })),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _onTapNewTaskButton,
        child: Icon(Icons.add),
      ),
    );
  }

  Future<void> _getNewTaskList() async {
    _getNewTaskInProgress = true;
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
      _newTaskList = list;
    }else{
      Show_SnacBarMessage(context, response.errormessage!);
    }
    _getNewTaskInProgress =false;
    setState(() {});
  }
  Future<void> _getNewTaskStatusList() async {
    _getTaskStatusCountInProgress = true;
    setState(() {});
    NetworkResponse response =
    await NetworkCaller.getRequest(url: Urls.getTaskStatusCountUrl);

    if(response.isSuccess){
      //Models
      List<TaskStatusCountModel> list = [];
      for(Map<String,dynamic>jsonData in response.body!['data'])
      {
        list.add(TaskStatusCountModel.fromJson(jsonData));
      }
      _taskStatusCountList = list;
    }else{
      if(mounted)
        {
          Show_SnacBarMessage(context, response.errormessage!);

        }
    }
    _getTaskStatusCountInProgress =false;
    if(mounted){
      setState(() {});
    }
  }

  void _onTapNewTaskButton() {
    Navigator.pushNamed(context, AddNewTask.name);
  }
}
