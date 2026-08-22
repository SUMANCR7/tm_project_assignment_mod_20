import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:provider/provider.dart';
import 'package:tmp_assignment_mod_20/data/models/task_model.dart';
import 'package:tmp_assignment_mod_20/data/service/api_caller.dart';
import 'package:tmp_assignment_mod_20/providers/task_provider.dart';
import 'package:tmp_assignment_mod_20/utils/urls.dart';
import 'package:tmp_assignment_mod_20/widget/snackbar.dart';

class TaskCard extends StatefulWidget {

  final TaskModel taskModel;
  final Color cardColor;
  final VoidCallback refreshParent;

  const TaskCard({
    super.key, required this.taskModel, required this.cardColor, required this.refreshParent,
  });

  @override
  State<TaskCard> createState() => _TaskCardState();
}

class _TaskCardState extends State<TaskCard> {

  //final taskProvider = Provider.of<TaskProvider>(context,listen: false);

  //final taskProvider = context.read<TaskProvider>();




  //--------[ API Call for Delete task]------//
  // Future<void> deleteTask() async {
  //   final response =await ApiCaller.getRequest(URL: TMurls.deleteTask(widget.taskModel.sId.toString()));
  //
  //   setState(() {
  //
  //   });
  //
  //   if(response.isSuccess){
  //     widget.refreshParent();
  //     showSnackBar(context, 'Task Deleted...!');
  //   }
  // }

  //--------[ API Call for Update task]------//
  // Future<void> changeStatus(String status) async {
  //   final response =await ApiCaller.getRequest(URL: TMurls.updateTask(widget.taskModel.sId.toString(), status));
  //
  //   setState(() {
  //
  //   });
  //
  //   if(response.isSuccess){
  //     Navigator.pop(context);
  //     widget.refreshParent();
  //     showSnackBar(context, 'Task Updated...!');
  //   }
  // }

  //---------[ Method for Alert Dialog ]------//


  @override
  Widget build(BuildContext context) {

    final taskProvider = Provider.of<TaskProvider>(context,listen: false);
    //---------[ Method for Alert Dialog ]------//
    void showChangeStatusDialog(){
      showDialog(context: context, builder: (context){
        return AlertDialog(
          title: Text('Change Status'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Card(
                child: ListTile(
                  title: Text('New'),
                  trailing: widget.taskModel.status == 'New' ? Icon(Icons.check_box,color: Colors.green,) : null,
                  onTap: (){
                    taskProvider.changeStatus(widget.taskModel.sId.toString(),'New');
                  },
                ),
              ),
              Card(
                child: ListTile(
                  title: Text('Progress'),
                  trailing: widget.taskModel.status == 'Progress' ? Icon(Icons.check_box,color : Colors.green,) : null,
                  onTap: (){
                    taskProvider.changeStatus(widget.taskModel.sId.toString(),'Progress');
                  },
                ),
              ),
              Card(
                child: ListTile(
                  title: Text('Canceled'),
                  trailing: widget.taskModel.status == 'Canceled' ? Icon(Icons.check_box,color: Colors.green,) : null,
                  onTap: (){
                    taskProvider.changeStatus(widget.taskModel.sId.toString(),'Canceled');
                  },
                ),
              ),
              Card(
                child: ListTile(
                  title: Text('Completed'),
                  trailing: widget.taskModel.status == 'Completed' ? Icon(Icons.check_box,color: Colors.green,) : null,
                  onTap: (){
                    taskProvider.changeStatus(widget.taskModel.sId.toString(),'Completed');
                  },
                ),
              ),
            ],
          ),
        );
      });
    }

    Future<void> deleteTask()async{


      final success = taskProvider.deleteTask(widget.taskModel.sId.toString());

      if(await success){
        showSnackBar(context, 'Task deleted....!');
      }

    }

    return Card(
      child: ListTile(
          title: Text(widget.taskModel.title.toString(),style: Theme.of(context).textTheme.titleLarge!.copyWith(
            fontSize: 18,
          ),),

          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(widget.taskModel.description.toString()),

              Text('Date: ${widget.taskModel.createdDate}',style: TextStyle(fontWeight: .bold),),

              SizedBox(height: 10,),
              Row(
                children: [

                  Chip(label: Text('${widget.taskModel.status}',style: TextStyle(fontWeight: .w800,color: Colors.white),),
                    backgroundColor: widget.cardColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                  ),

                  Spacer(),
                 //----[Update Button]-----//

                  IconButton(onPressed: (){
                    showChangeStatusDialog();
                  }, icon: Icon(Icons.edit_note,color: Colors.green,)),
                  //----[Delete Button]-----//
                  IconButton(onPressed: (){
                    deleteTask();
                  }, icon: Icon(Icons.delete,color: Colors.red,)),
                ],
              )
            ],
          )
      ),
    );
  }
}