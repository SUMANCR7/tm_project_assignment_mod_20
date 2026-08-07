import 'package:flutter/material.dart';

import '../data/models/task_model.dart';
import '../data/service/api_caller.dart';
import '../utils/urls.dart';
import '../widget/task_card.dart';

class CanceledScreen extends StatefulWidget {
  const CanceledScreen({super.key});

  @override
  State<CanceledScreen> createState() => _CanceledScreenState();
}

class _CanceledScreenState extends State<CanceledScreen> {

  //-------------[GET - 1 ]---------//
  List<TaskModel> taskList = [];

  Future<void> getAllTaskList() async {
    final response =await ApiCaller.getRequest(URL: TMurls.allTask('Canceled'));

    List<TaskModel> temList = [];

    if(response.isSuccess){
      for(Map<String, dynamic> jsonData in response.responseData['data']){
        temList.add(TaskModel.fromJson(jsonData));
      }
    }else{
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Something Wrong...!')));
    }
    taskList = temList;

    setState(() {

    });

  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getAllTaskList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
          itemCount: taskList.length,
          itemBuilder: (context, index){
            return  TaskCard(taskModel: taskList[index]
              , cardColor: Colors.red, refreshParent: () {

                getAllTaskList();
              },);
          }),
    );
  }
}
