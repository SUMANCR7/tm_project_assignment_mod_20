import 'package:flutter/material.dart';
import 'package:tmp_assignment_mod_20/data/models/api_response.dart';
import 'package:tmp_assignment_mod_20/data/models/task_model.dart';
import 'package:tmp_assignment_mod_20/data/models/task_status_count.dart';

import '../data/service/api_caller.dart';
import '../utils/urls.dart';

class TaskProvider with ChangeNotifier {
  bool isLoading = false;
  String? errorMessage;

  //--- set loading method---//
  void setLoading(bool value) {
    isLoading = value;
    notifyListeners();
  }

  List<TaskStatusCountModel> taskCountList = [];

  List<TaskModel> newTask = [];
  List<TaskModel> progressTask = [];
  List<TaskModel> completedTask = [];
  List<TaskModel> cancelledTask = [];

  //------- Method of Task Count----//
  Future<void> getAllTaskCount() async {
    setLoading(true);
    //----API call---//
    final response = await ApiCaller.getRequest(URL: TMurls.taskCount);

    List<TaskStatusCountModel> temList = [];

    if (response.isSuccess) {
      for (Map<String, dynamic> jsonData in response.responseData['data']) {
        temList.add(TaskStatusCountModel.fromJson(jsonData));
      }
    } else {}
    taskCountList = temList;

    setLoading(false);
  }

  //----- Method of Task Status [ New, Progress, Completed, Cancelled ]----//
  Future<void> getAllTaskByStatus(String status) async {
    //---Loading ON----//
    setLoading(true);

    //---API call---//
    final ApiResponse response = await ApiCaller.getRequest(
      URL: TMurls.allTask(status),
    );

    if (response.isSuccess) {
      List<TaskModel> temList = [];

      for (Map<String, dynamic> jsonData in response.responseData['data']) {
        temList.add(TaskModel.fromJson(jsonData));
      }

      if (status == 'New') {
        newTask = temList;
      } else if (status == 'Progress') {
        progressTask = temList;
      } else if (status == 'Completed') {
        completedTask = temList;
      } else if (status == 'Canceled') {
        cancelledTask = temList;
      }
    }
    //---Loading OFF---//
    setLoading(false);
  }

  //--------[ Method of DELETE Task]------//
  Future<bool> deleteTask(String taskID) async {
    final response =await ApiCaller.getRequest(URL: TMurls.deleteTask(taskID));

    // setState(() {
    //
    // });

    if(response.isSuccess){
      newTask.removeWhere((task) => task.sId.toString() == taskID);
      progressTask.removeWhere((task) => task.sId.toString() == taskID);
      completedTask.removeWhere((task) => task.sId.toString() == taskID);
      cancelledTask.removeWhere((task) => task.sId.toString() == taskID);

      // widget.refreshParent();
      // showSnackBar(context, 'Task Deleted...!');

      notifyListeners();
      return true;
    }else{
      return false;
    }
  }

  //--------[ Method of UPDATE task]------//
  Future<bool> changeStatus(String taskID, String status) async {
    final response =await ApiCaller.getRequest(URL: TMurls.updateTask(taskID, status));


    if(response.isSuccess){
      newTask.removeWhere((task) => task.sId.toString() == taskID);
      progressTask.removeWhere((task) => task.sId.toString() == taskID);
      completedTask.removeWhere((task) => task.sId.toString() == taskID);
      cancelledTask.removeWhere((task) => task.sId.toString() == taskID);
      
     await getAllTaskByStatus(status);
     return true;
    }else{
      return false;
    }
  }

}
