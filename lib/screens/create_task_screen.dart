import 'package:flutter/material.dart';
import 'package:tmp_assignment_mod_20/screens/update_profile_screen.dart';
import 'package:tmp_assignment_mod_20/widget/screen_bg.dart';

//import '../controller/auth_controller.dart';
import '../data/models/api_response.dart';
//import '../data/models/user_model.dart';
import '../data/service/api_caller.dart';
import '../utils/urls.dart';
import 'main_nav_screen.dart';

class CreateTaskScreen extends StatefulWidget {
  const CreateTaskScreen({super.key});

  @override
  State<CreateTaskScreen> createState() => _CreateTaskScreenState();
}

class _CreateTaskScreenState extends State<CreateTaskScreen> {

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  //--------Method for [ Add task ]------//

  Future<void> createTask() async {
    //--call POST request from API caller---//
    final ApiResponse response =await ApiCaller.postRequest(URL: TMurls.createTask,
        body: {
        "title": _titleController.text,
          "description": _descriptionController.text,
          "status": "New",
        }
    );
    if(response.isSuccess){


      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> MainNavScreen()));
      //------Snack bar message------//
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('New Task Added...!')));
    }else{
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Something Wrong...!')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,

        title: GestureDetector(
          onTap: (){
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>UpdateProfile()));
          },
          child: Row(
            children: [
              CircleAvatar(
                radius: 25,
                backgroundImage: NetworkImage(
                  'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTCc0Ohk3vl1JjCPN-hfmFaEEMBTCGVL-QXS81v_DHt3NPCj87Mpu6lhX5v&s=10',
                ),
              ),
              SizedBox(width: 15),
              Column(
                children: [
                  Text(
                    'Suman Mandol',
                    style: Theme.of(context).textTheme.titleSmall!.copyWith(
                      color: Colors.white,
                      fontSize: 17,
                    ),
                  ),
                  Text(
                    'sm@gmail.com',
                    style: Theme.of(context).textTheme.titleSmall!.copyWith(
                      color: Colors.white,
                      fontSize: 17,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      body: ScreenBG(child: Column(
     children: [
       Padding(
         padding: const EdgeInsets.all(25),
         child: Form(
           key: _formKey,
           child: Column(
             crossAxisAlignment: CrossAxisAlignment.start,
             children: [
               SizedBox(height: 60),
               Text(
                 'Add New Task',
                 //------predefine theme------//
                 style: Theme.of(context).textTheme.titleLarge,
               ),

               SizedBox(height: 25),

               //------Table-------//

               //--------for Title--------//
               TextFormField(
                 controller: _titleController,
                 decoration: InputDecoration(hintText: 'Title'),
                 //-----validation----//
                 validator: (myValue){
                   if(myValue == null || myValue.isEmpty){
                     return 'Please enter title';
                   }else{
                     return null;
                   }
                 },
               ),

               SizedBox(height: 10),

               //--------for Description--------//
               TextFormField(
                 controller: _descriptionController,
                 maxLines: 6,
                 decoration: InputDecoration(hintText: 'Description'),
                 //-----validation----//
                 validator: (myValue){
                   if(myValue == null || myValue.isEmpty){
                     return 'Please enter description';
                   }else{
                     return null;
                   }
                 },
               ),

               SizedBox(height: 20),

               //----------button---------//
               FilledButton(
                 onPressed: () {
                   if(_formKey.currentState!.validate()){
                     createTask();
                   }
                   //Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>MainNavScreen()));
                 },
                 child: Icon(Icons.arrow_circle_right_outlined, size: 30),
               ),




             ],
           ),
         ),
       ),
     ],
      )),
    );
  }
}
