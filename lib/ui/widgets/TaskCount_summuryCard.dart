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
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 5),
      height: 100,
      width: 100,
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.all(13),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text('$count',
              style: Theme.of(context).textTheme.titleLarge,maxLines: 1,),
            Text(title),
          ],
        ),
      ),
    );
  }}