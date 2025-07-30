import 'package:flutter/material.dart';
import 'package:task_management/data/models/task_model.dart';
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
  List <TaskModel> _newTaskList= [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getNewTaskList();
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
              width: double.infinity,
              child: ListView.separated(
                clipBehavior: Clip.antiAliasWithSaveLayer,
                scrollDirection: Axis.horizontal,
                separatorBuilder: (context, index) => const SizedBox(
                  width: 4,
                ),
                itemCount: 4,
                itemBuilder: (context, index) {
                  return Task_count_summuryCard(title: 'Progress', count: 8);
                },
              ),
            ),
            Visibility(
              visible: _getNewTaskInProgress == false,
              replacement: CenterCirculerprogressbar(),
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

  void _onTapNewTaskButton() {
    Navigator.pushNamed(context, AddNewTask.name);
  }
}
