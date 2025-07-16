import 'package:flutter/material.dart';
import 'package:task_management/ui/screens/Add_New_Task.dart';

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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Column(
          children: [
            const SizedBox(height: 16,),
            SizedBox(
              height: 100,
              width: double.infinity,
              child: ListView.separated(
                clipBehavior: Clip.antiAliasWithSaveLayer,
                scrollDirection: Axis.horizontal,
                  separatorBuilder: (context,index)=> const SizedBox(width: 4,),
                  itemCount:4 ,
                itemBuilder: (context,index){
                    return Task_count_summuryCard(title: 'Progress', count: 8);
                },
              ),
            ),
            Expanded(child: ListView.builder(
              itemCount: 10,
                itemBuilder: (contex,index){
                return Task_Card(taskType: TaskType.tNew,);
                }))
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed:_onTapNewTaskButton,
        child: Icon(Icons.add),),
    );

  }
  void _onTapNewTaskButton()
  {
    Navigator.pushNamed(context, AddNewTask.name);
  }
}

