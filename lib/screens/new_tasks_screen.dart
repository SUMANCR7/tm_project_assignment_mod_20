import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tmp_assignment_mod_20/data/models/task_model.dart';
import 'package:tmp_assignment_mod_20/data/models/task_status_count.dart';
import 'package:tmp_assignment_mod_20/data/service/api_caller.dart';
import 'package:tmp_assignment_mod_20/providers/task_provider.dart';
import 'package:tmp_assignment_mod_20/utils/urls.dart';

import '../widget/task_card.dart';
import '../widget/task_count_by_status.dart';

class TaskScreen extends StatefulWidget {
  const TaskScreen({super.key});

  @override
  State<TaskScreen> createState() => _TaskScreenState();
}

class _TaskScreenState extends State<TaskScreen> {
  //-------[ call GET 1. All Task Count 2. All Task List ]-----//

  //-------------[GET - 1 ]---------//
  //List<TaskStatusCountModel> taskCountList = [];

  //   Future<void> getAllTaskCount() async {
  //     final response =await ApiCaller.getRequest(URL: TMurls.taskCount);
  //
  //     List<TaskStatusCountModel> temList = [];
  //
  //     if(response.isSuccess){
  //       for(Map<String, dynamic> jsonData in response.responseData['data']){
  //         temList.add(TaskStatusCountModel.fromJson(jsonData));
  //       }
  //     }else{
  //       ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Something Wrong...!')));
  //     }
  // taskCountList = temList;
  //
  //     setState(() {
  //
  //     });
  //
  //   }

  //-------------[GET - 2 ]---------//
  // List<TaskModel> taskList = [];
  //
  // Future<void> getAllTaskList() async {
  //   final response =await ApiCaller.getRequest(URL: TMurls.allTask('New'));
  //
  //   List<TaskModel> temList = [];
  //
  //   if(response.isSuccess){
  //     for(Map<String, dynamic> jsonData in response.responseData['data']){
  //       temList.add(TaskModel.fromJson(jsonData));
  //     }
  //   }else{
  //     ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Something Wrong...!')));
  //   }
  //   taskList = temList;
  //
  //   setState(() {
  //
  //   });
  //
  // }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //---call GET---//
    final taskProvider = Provider.of<TaskProvider>(context, listen: false);
    taskProvider.getAllTaskCount();
    //getAllTaskList();
    taskProvider.getAllTaskByStatus('New');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: Consumer<TaskProvider>(
          builder: (context, taskProvider, child) {
            return Column(
              children: [
                SizedBox(
                  height: 90,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemCount: taskProvider.taskCountList.length,
                    itemBuilder: (context, index) {
                      final count = taskProvider.taskCountList[index];

                      return SizedBox(
                        width: 99,
                        child: taskProvider.isLoading
                            ? Center(child: CircularProgressIndicator())
                            : TaskCountByStatus(
                                title: count.sId.toString(),
                                count: count.sum ?? 0,
                              ),
                      );
                    },
                    separatorBuilder: (context, index) {
                      return SizedBox(width: 5);
                    },
                  ),
                ),

                Expanded(
                  child: taskProvider.isLoading
                      ? Center(child: CircularProgressIndicator())
                      : ListView.builder(
                          itemCount: taskProvider.newTask.length,
                          itemBuilder: (context, index) {
                            //----create task variable---//
                            final task = taskProvider.newTask[index];
                            return TaskCard(
                              taskModel: task,
                              cardColor: Colors.blue,
                              refreshParent: () {
                                //getAllTaskCount();
                                taskProvider.getAllTaskCount();
                                //getAllTaskList();
                                taskProvider.getAllTaskByStatus('New');
                              },
                            );
                          },
                        ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
