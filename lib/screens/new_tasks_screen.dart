import 'package:flutter/material.dart';
import 'package:tmp_assignment_mod_20/data/models/task_model.dart';
import 'package:tmp_assignment_mod_20/data/models/task_status_count.dart';
import 'package:tmp_assignment_mod_20/data/service/api_caller.dart';
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
  List<TaskStatusCountModel> taskCountList = [];


  Future<void> getAllTaskCount() async {
    final response =await ApiCaller.getRequest(URL: TMurls.taskCount);

    List<TaskStatusCountModel> temList = [];

    if(response.isSuccess){
      for(Map<String, dynamic> jsonData in response.responseData['data']){
        temList.add(TaskStatusCountModel.fromJson(jsonData));
      }
    }else{
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Something Wrong...!')));
    }
taskCountList = temList;

    setState(() {

    });

  }

  //-------------[GET - 2 ]---------//
  List<TaskModel> taskList = [];

  Future<void> getAllTaskList() async {
    final response =await ApiCaller.getRequest(URL: TMurls.allTask('New'));

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
    //---call GET---//
    getAllTaskCount();

    getAllTaskList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          children: [

            SizedBox(
              height: 90,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                  itemCount: taskCountList.length,
                  itemBuilder: (context, index){
                return SizedBox(
                    width: 99,
                    child: TaskCountByStatus(
                      title: taskCountList[index].sId.toString(),
                      count: taskCountList[index].sum ?? 0,
                      ));
              },
                separatorBuilder: (context, index){
                  return SizedBox(width: 5,);
                },
              ),
            ),

           Expanded(
             child: ListView.builder(
                 itemCount: taskList.length,
                 itemBuilder: (context, index){
               return  TaskCard(taskModel: taskList[index]
               , cardColor: Colors.blue, refreshParent: () {
                 getAllTaskCount();
                 getAllTaskList();

                 },);
             }),
           ),




          ],
        ),
      ),
    );
  }
}




