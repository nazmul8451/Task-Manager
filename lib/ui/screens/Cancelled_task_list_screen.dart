
import 'package:flutter/material.dart';

import '../widgets/Task_Card.dart';

class Cancelled_TaskListScreen extends StatefulWidget {
  const Cancelled_TaskListScreen({super.key});

  @override
  State<Cancelled_TaskListScreen> createState() => _Cancelled_TaskListScreenState();
}

class _Cancelled_TaskListScreenState extends State<Cancelled_TaskListScreen> {
  @override
  Widget build(BuildContext context) {
    return Padding(padding:EdgeInsets.symmetric(horizontal: 8),
      child: ListView.builder(
          itemCount: 10,
          itemBuilder: (contex,index){
            return Task_Card();
          }),
    );
  }
}
