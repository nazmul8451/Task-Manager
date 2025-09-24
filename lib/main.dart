import 'package:device_preview/device_preview.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:task_management/app.dart';

void main() {
  runApp(
        DevicePreview(
          enabled: !kReleaseMode,
          builder: (context) => const TaskManager(), // এখানে TaskManager এর ভেতরেই GetMaterialApp আছে
        ),
  );
}