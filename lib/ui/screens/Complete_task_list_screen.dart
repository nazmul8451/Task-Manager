
import 'package:flutter/material.dart';

import '../widgets/Task_Card.dart';

class Complete_TaskListScreen extends StatefulWidget {
  const Complete_TaskListScreen({super.key});

  @override
  State<Complete_TaskListScreen> createState() => _Complete_TaskListScreenState();
}

class _Complete_TaskListScreenState extends State<Complete_TaskListScreen> {
  @override
  Widget build(BuildContext context) {
    return Padding(padding:EdgeInsets.symmetric(horizontal: 8),
      child: ListView.builder(
          itemCount: 10,
          itemBuilder: (contex,index){
            return Task_Card(taskType: TaskType.completed,);
          }),
    );
  }
}
