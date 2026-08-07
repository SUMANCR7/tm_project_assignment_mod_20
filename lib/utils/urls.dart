
class TMurls{
  static String baseUrl = 'https://task-manager-api.ostad.live/api/v1';
  static String sign_Up = '$baseUrl/Registration';
  static String log_In = '$baseUrl/Login';
  static String createTask = '$baseUrl/createTask';
  //----update Profile---//
  static String updateProfile = '$baseUrl/ProfileUpdate';
  static String taskCount = '$baseUrl/taskStatusCount';
  static String allTask(String status) => '$baseUrl/listTaskByStatus/$status';
  static String deleteTask(String taskId) => '$baseUrl/deleteTask/$taskId';
  static String updateTask(String taskId, String status) => '$baseUrl/updateTaskStatus/$taskId/$status';

}