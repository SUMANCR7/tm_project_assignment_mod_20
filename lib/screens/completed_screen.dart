import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../data/models/task_model.dart';
import '../data/service/api_caller.dart';
import '../providers/task_provider.dart';
import '../utils/urls.dart';
import '../widget/task_card.dart';

class CompletedScreen extends StatefulWidget {
  const CompletedScreen({super.key});

  @override
  State<CompletedScreen> createState() => _CompletedScreenState();
}

class _CompletedScreenState extends State<CompletedScreen> {

  //-------------[GET - 1 ]---------//
  // List<TaskModel> taskList = [];
  //
  // Future<void> getAllTaskList() async {
  //   final response =await ApiCaller.getRequest(URL: TMurls.allTask('Completed'));
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
    final taskProvider = Provider.of<TaskProvider>(context,listen: false);
    taskProvider.getAllTaskByStatus('Completed');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<TaskProvider>(
        //future: future,
        builder: (context, taskProvider, child) {
          return taskProvider.isLoading ? Center(child: CircularProgressIndicator()) : ListView.builder(
              itemCount: taskProvider.completedTask.length,
              itemBuilder: (context, index){
                final task = taskProvider.completedTask[index];
                return  TaskCard(taskModel: task
                  , cardColor: Colors.green, refreshParent: () {

                  //getAllTaskList();
                    taskProvider.getAllTaskByStatus('Completed');

                  },);
              });
        }
      ),
    );
  }
}
