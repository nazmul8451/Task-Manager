import 'package:flutter/material.dart';
import 'package:task_management/data/services/network_caller.dart';
import 'package:task_management/data/urls.dart';
import 'package:task_management/ui/widgets/center_circulerProgressbar.dart';
import 'package:task_management/ui/widgets/snacbar_messanger.dart';

import '../../data/models/task_model.dart';

enum TaskType {
  tNew,
  progress,
  completed,
  cancelled,
}

class Task_Card extends StatefulWidget {
  const Task_Card({
    super.key,
    required this.taskType,
    required this.taskModel,
    required this.onStatusUpdate,
  });
  final TaskType taskType;
  final TaskModel taskModel;
  final VoidCallback onStatusUpdate;

  @override
  State<Task_Card> createState() => _Task_CardState();
}

class _Task_CardState extends State<Task_Card> {
  bool _updateTaskStatsuInProgress = false;
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 10,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.taskModel.title,
              style: Theme.of(context).textTheme.titleMedium,
            ),
            Text(
              widget.taskModel.description,
              style: TextStyle(color: Colors.black54),
            ),
            Text('Date: ${widget.taskModel.createdDate}'),
            const SizedBox(
              height: 8,
            ),
            Row(
              children: [
                Chip(
                  label: Text(
                    widget.taskModel.status,
                    style: TextStyle(color: Colors.white),
                  ),
                  backgroundColor: _getTaskChipColor(),
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  shape: RoundedRectangleBorder(
                    side: BorderSide.none,
                      borderRadius: BorderRadius.circular(20)),
                ),
                Spacer(),
                Visibility(
                  visible: _updateTaskStatsuInProgress == false,
                  replacement: CenterCirculerprogressbar(),
                  child: IconButton(
                      onPressed: () {
                        _showEditTaskStatusDialog();
                      },
                      icon: Icon(
                        Icons.edit,
                        color: Colors.green,
                      )),
                ),
                IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.delete,
                      color: Colors.red,
                    )),
              ],
            )
          ],
        ),
      ),
    );
  }

//--
  Color _getTaskChipColor() {
    if (widget.taskType == TaskType.tNew) {
      return Colors.blue;
    } else if (widget.taskType == TaskType.progress) {
      return Colors.purple;
    } else if (widget.taskType == TaskType.completed) {
      return Colors.green;
    } else {
      return Colors.red;
    }
  }

  void _showEditTaskStatusDialog()
  {
    showDialog(context: context, builder: (ctx){
      return AlertDialog(
        title:Text('Change Status'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              title: Text('New'),
              trailing:_getTaskStatusTrailling(TaskType.tNew) ,
              onTap: (){
                if(widget.taskType == TaskType.tNew){
                  return;
                }else{
                _updateTaskStatus('New');
                }

              },
            ),
            ListTile(
              title: Text('In Progress'),
              trailing:_getTaskStatusTrailling(TaskType.progress) ,
              onTap: (){
                if(widget.taskType == TaskType.progress){
                  return;
                }else{
                  _updateTaskStatus('Progress');
                }

              },
            ),
            ListTile(
              title: Text('Completed'),
              trailing:_getTaskStatusTrailling(TaskType.completed) ,
              onTap: (){
                if(widget.taskType == TaskType.completed){
                  return;
                }else{
                  _updateTaskStatus('Completed');
                }

              },
            ),
            ListTile(
              title: Text('Cancelled'),
              trailing:_getTaskStatusTrailling(TaskType.cancelled) ,
              onTap: (){
                if(widget.taskType == TaskType.cancelled){
                  return;
                }else{
                  _updateTaskStatus('Cancelled');
                }

              },
            ),

          ],
        ),
      );
    });
  }

  Widget? _getTaskStatusTrailling(TaskType type) {
    return widget.taskType == type ? Icon(Icons.check) : null;
  }



  Future<void> _updateTaskStatus(String status)async{

    Navigator.pop(context);
    _updateTaskStatsuInProgress = true;
    if(mounted)
      {
        setState(() {});
      }
    NetworkResponse response = await NetworkCaller.getRequest(
        url: Urls.updateTaskStatusUrl(widget.taskModel.id, status));
   _updateTaskStatsuInProgress = false;
    if(mounted){
      setState(() {});
    }
    if(response.isSuccess){
      widget.onStatusUpdate();
    }else{
      if(mounted)
        {
          Show_SnacBarMessage(context, response.errormessage!);
        }
    }
  }

}
