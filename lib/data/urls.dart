class Urls {
  static const String baseUrl = "http://35.73.30.144:2005/api/v1";
  static const String registrationUrl = "$baseUrl/Registration";
  static const String logInUrl = "$baseUrl/Login";
  static const String creatNewTasksUrl = "$baseUrl/createTask";
  static const String getNewTasksUrl = "$baseUrl/listTaskByStatus/New";
  static const String getProgressTasksUrl = "$baseUrl/listTaskByStatus/Progress";
  static const String getTaskStatusCountUrl = "$baseUrl/taskStatusCount";
  static String updateTaskStatusUrl(String taskId, String status) =>
      "$baseUrl/updateTaskStatus/$taskId/$status";
}
