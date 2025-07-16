import 'package:flutter/material.dart';
import 'package:task_management/ui/screens/Cancelled_task_list_screen.dart';

import '../widgets/TaskManager_AppBar.dart';
import 'Complete_task_list_screen.dart';
import 'Progress_task_list_screen.dart';
import 'new_task_list_screen.dart';

class MainNavBarScreen extends StatefulWidget {
  const MainNavBarScreen({super.key});
  static const String name = '/main-nav-bar-screen';

  @override
  State<MainNavBarScreen> createState() => _MainNavBarScreenState();
}

List<Widget> _screen =
[
  NewTaskListScreen(),
  ProgressTaskListScreen(),
  Complete_TaskListScreen(),
  Cancelled_TaskListScreen(),
];
int _selectedIndex = 0;

class _MainNavBarScreenState extends State<MainNavBarScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Task_manager_AppBar(),
      body: _screen[_selectedIndex],

      bottomNavigationBar:  NavigationBar(
        selectedIndex: _selectedIndex,
          onDestinationSelected:(int index){
          _selectedIndex = index;
          setState(() {

          });
          },
          destinations: [
        NavigationDestination(
            icon: Icon(Icons.new_label_outlined), label: 'New'),
        NavigationDestination(
            icon: Icon(Icons.arrow_circle_right_outlined), label: 'Progress'),
        NavigationDestination(
            icon: Icon(Icons.done_all_outlined), label: 'Completed'),
        NavigationDestination(
            icon: Icon(Icons.cancel_outlined), label: 'Cancelled'),
      ]),
    );
  }




}

