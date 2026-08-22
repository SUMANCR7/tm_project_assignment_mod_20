import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tmp_assignment_mod_20/providers/task_provider.dart';

import '../data/models/task_model.dart';
import '../data/service/api_caller.dart';
import '../utils/urls.dart';
import '../widget/task_card.dart';

class ProgressScreen extends StatefulWidget {
  const ProgressScreen({super.key});

  @override
  State<ProgressScreen> createState() => _ProgressScreenState();
}

class _ProgressScreenState extends State<ProgressScreen> {

  //-------------[GET - 1 ]---------//
  // List<TaskModel> taskList = [];
  //
  // Future<void> getAllTaskList() async {
  //   final response =await ApiCaller.getRequest(URL: TMurls.allTask('Progress'));
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
    //getAllTaskList();
    final taskProvider = Provider.of<TaskProvider>(context, listen: false);
    
    taskProvider.getAllTaskByStatus('Progress');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<TaskProvider>(
        //future: future,
        builder: (context, taskProvider, child ) {
          return taskProvider.isLoading ? Center(child: CircularProgressIndicator()) : ListView.builder(
              itemCount: taskProvider.progressTask.length,
              itemBuilder: (context, index){
                final task = taskProvider.progressTask[index];
                return  TaskCard(taskModel: task
                  , cardColor: Colors.purple, refreshParent: () {

                    //getAllTaskList();
                    taskProvider.getAllTaskByStatus('Progress');
                  },);
              });
        }
      ),
    );
  }
}
