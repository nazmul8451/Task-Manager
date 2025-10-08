import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:task_management/data/models/task_model.dart';
import 'package:task_management/data/models/task_status_count.dart';
import 'package:task_management/data/services/network_caller.dart';
import 'package:task_management/data/urls.dart';
import 'package:task_management/ui/controller/new_task_list_Controller.dart';
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
      //এটার মানে হলও তুমি আগে স্বাভাবিক ভাবে স্ক্রিন টাকে একবার বিল্ড করো ।এরপরে তুইমি এই ফাংশন গুলো কে কল দাও
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
              height: 10,
            ),
            SizedBox(
              height: 100,
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
            SizedBox(height: 10,),
            Visibility(
              child: Expanded(
                  child: Visibility(
                    visible: _getNewTaskInProgress == false,
                    replacement: CenterCirculerprogressbar(),
                    child: ListView.builder(
                        itemCount: _newTaskList.length,
                        itemBuilder: (contex, index) {
                          return Task_Card(
                            taskModel: _newTaskList[index],
                            taskType: TaskType.tNew,
                            onStatusUpdate: () {
                              _getNewTaskList();
                              _getNewTaskStatusList();
                              },
                          );
                        }),
                  )),
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

    // bool isSuccess = await NewTaskListController().getNewTaskList();
    // if(isSuccess)
    //   {
    //     Get.snackbar('Success', 'Task Successfully added');
    //   }else{
    //   Get.snackbar('Error', NewTaskListController().errorMessage!);
    // }

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
