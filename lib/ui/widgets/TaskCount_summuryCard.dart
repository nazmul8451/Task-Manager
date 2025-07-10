import 'package:flutter/material.dart';
class Task_count_summuryCard extends StatelessWidget {

  const Task_count_summuryCard({
    super.key,
     required this.title,
     required this.count,
  });
  final String title;
  final int count;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      child: Padding(
        padding: const EdgeInsets.all(13),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('$count',style: Theme.of(context).textTheme.titleLarge,maxLines: 1,),
            Text('$title'),
          ],
        ),
      ),
    );
  }}