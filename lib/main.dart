import 'package:device_preview/device_preview.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:task_management/app.dart';
import 'package:task_management/ui/controller/add_new_task_controller.dart';
import 'package:task_management/ui/controller/sign_in_controller.dart';
import 'package:task_management/ui/controller/sign_up_controller.dart';

void main() {
  //controller inject
  Get.put(SignUpController());
  Get.put(SignInController());
  Get.put(AddNewTaskController());
  runApp(
        DevicePreview(
          enabled: !kReleaseMode,
          builder: (context) => const TaskManager(), // এখানে TaskManager এর ভেতরেই GetMaterialApp আছে
        ),
  );
}