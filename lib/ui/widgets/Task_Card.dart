import 'package:flutter/material.dart';

enum TaskType {
  tNew,
  progress,
  completed,
  cancelled,
}

class Task_Card extends StatelessWidget {
  const Task_Card({
    super.key,
    required this.taskType,
  });
  final TaskType taskType;
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
              'Title will be here',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            Text(
              'Description',
              style: TextStyle(color: Colors.black54),
            ),
            Text('Date: 12/2/25'),
            const SizedBox(
              height: 8,
            ),
            Row(
              children: [
                Chip(
                  label: Text(
                    'New',
                    style: TextStyle(color: Colors.white),
                  ),
                  backgroundColor: _getTaskChipColor(),
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  shape: RoundedRectangleBorder(
                    side: BorderSide.none,
                      borderRadius: BorderRadius.circular(20)),
                ),
                Spacer(),
                IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.edit,
                      color: Colors.green,
                    )),
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

  Color _getTaskChipColor() {
    if (taskType == TaskType.tNew) {
      return Colors.blue;
    } else if (taskType == TaskType.progress) {
      return Colors.purple;
    } else if (taskType == TaskType.completed) {
      return Colors.green;
    } else {
      return Colors.red;
    }
  }
}
