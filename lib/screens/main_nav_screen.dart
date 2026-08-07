import 'package:flutter/material.dart';
import 'package:tmp_assignment_mod_20/screens/completed_screen.dart';
import 'package:tmp_assignment_mod_20/screens/cancelled_screen.dart';
import 'package:tmp_assignment_mod_20/screens/create_task_screen.dart';
import 'package:tmp_assignment_mod_20/screens/progress_screen.dart';
import 'package:tmp_assignment_mod_20/screens/new_tasks_screen.dart';
import 'package:tmp_assignment_mod_20/screens/update_profile_screen.dart';

class MainNavScreen extends StatefulWidget {
  const MainNavScreen({super.key});

  @override
  State<MainNavScreen> createState() => _MainNavScreenState();
}

class _MainNavScreenState extends State<MainNavScreen> {
  int selectedIndex = 0;

  List screens = [
    TaskScreen(),
    ProgressScreen(),
    CanceledScreen(),
    CompletedScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //---App bar for 4 screens----//
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

      body: screens[selectedIndex],
      bottomNavigationBar: NavigationBar(
        selectedIndex: selectedIndex,
        onDestinationSelected: (int index) {
          selectedIndex = index;
          setState(() {});
        },
        destinations: [
          NavigationDestination(icon: Icon(Icons.task), label: 'New'),

          NavigationDestination(icon: Icon(Icons.refresh), label: 'Progress'),
          NavigationDestination(icon: Icon(Icons.cancel), label: 'Canceled'),
          NavigationDestination(icon: Icon(Icons.task_alt_outlined),label: 'Completed',),
        ],
      ),

      floatingActionButton: FloatingActionButton(onPressed: (){
        Navigator.push(context, MaterialPageRoute(builder: (context)=>CreateTaskScreen()));
      }, child: Icon(Icons.add),),

    );
  }
}
