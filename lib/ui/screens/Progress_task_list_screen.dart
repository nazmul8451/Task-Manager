
import 'package:flutter/material.dart';

import '../widgets/Task_Card.dart';

class ProgressTaskListScreen extends StatefulWidget {
  const ProgressTaskListScreen({super.key});

  @override
  State<ProgressTaskListScreen> createState() => _ProgressTaskListScreenState();
}

class _ProgressTaskListScreenState extends State<ProgressTaskListScreen> {
  @override
  Widget build(BuildContext context) {
    return Padding(padding:EdgeInsets.symmetric(horizontal: 8),
    child: ListView.builder(
        itemCount: 10,
        itemBuilder: (contex,index){
          return Task_Card(taskType: TaskType.progress,);
        }),
    );
  }
}
