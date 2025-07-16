import 'package:flutter/material.dart';
import 'package:task_management/ui/widgets/TaskManager_AppBar.dart';
import 'package:task_management/ui/widgets/screen_background.dart';
class AddNewTask extends StatefulWidget {
  const AddNewTask({super.key});
  static const String name = '/add-new-task';
  @override
  State<AddNewTask> createState() => _AddNewTaskState();
}
TextEditingController titleTEController =TextEditingController();
TextEditingController descriptionTEController =TextEditingController();
final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
class _AddNewTaskState extends State<AddNewTask> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Task_manager_AppBar(),
      body: ScreenBackground(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Form(
            key: _formkey,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 80,
                ),
                Text('Add New Task',
                    style: Theme.of(context).textTheme.titleLarge),
                const SizedBox(
                  height: 16,
                ),
                TextFormField(
                  controller: titleTEController,
                  textInputAction: TextInputAction.next,
                  validator: (String? value){
                    if(value?.trim().isEmpty?? true){
                      return 'Enter your title';
                    }
                  },
                  decoration: InputDecoration(
                    hintText: 'Title',
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                TextFormField(
                  controller: descriptionTEController,
                  maxLines: 5,
                  validator: (String? value){
                    if(value?.trim().isEmpty?? true){
                      return 'Enter your description';
                    }
                  },
                  decoration: InputDecoration(
                      hintText: 'Description'),
                ),
                const SizedBox(
                  height: 16,
                ),
                ElevatedButton(onPressed: (){},
                    child: Icon(
                        Icons.arrow_circle_right_outlined))
              ],
            ),
          ),
        )),
    );
  }
  void _onTapsubmitButton()
  {
    if(_formkey.currentState!.validate()){
      //TODO: Add new task
    }
  }
}
