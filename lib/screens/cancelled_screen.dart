import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../data/models/task_model.dart';
import '../data/service/api_caller.dart';
import '../providers/task_provider.dart';
import '../utils/urls.dart';
import '../widget/task_card.dart';

class CanceledScreen extends StatefulWidget {
  const CanceledScreen({super.key});

  @override
  State<CanceledScreen> createState() => _CanceledScreenState();
}

class _CanceledScreenState extends State<CanceledScreen> {

  //-------------[GET - 1 ]---------//
  // List<TaskModel> taskList = [];
  //
  // Future<void> getAllTaskList() async {
  //   final response =await ApiCaller.getRequest(URL: TMurls.allTask('Canceled'));
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
    taskProvider.getAllTaskByStatus('Canceled');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<TaskProvider>(
        //future: future,
        builder: (context, taskProvider,child) {
          return taskProvider.isLoading ? Center(child: CircularProgressIndicator()) : ListView.builder(
              itemCount: taskProvider.cancelledTask.length,
              itemBuilder: (context, index){
                final task = taskProvider.cancelledTask[index];
                return  TaskCard(taskModel: task
                  , cardColor: Colors.red, refreshParent: () {

                    //getAllTaskList();
                    taskProvider.getAllTaskByStatus('Canceled');
                  },);
              });
        }
      ),
    );
  }
}
