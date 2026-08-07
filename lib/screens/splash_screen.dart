import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tmp_assignment_mod_20/controller/auth_controller.dart';
import 'package:tmp_assignment_mod_20/screens/login_screen.dart';
import 'package:tmp_assignment_mod_20/screens/main_nav_screen.dart';
import 'package:tmp_assignment_mod_20/utils/asset_path.dart';

import '../widget/screen_bg.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  //----init State-----//
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    moveToNextScreen();
  }

  //-----Function for move next screen------//
  Future<void>moveToNextScreen() async {
   await Future.delayed(Duration(seconds: 4));
   //---check login----//
   AuthController.getUserData();
   final bool isLogin = await AuthController.isUserLogIn();
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> isLogin ? MainNavScreen() : LogInScreen()));
  }

  @override
  Widget build(BuildContext context) {
    return ScreenBG(child: Center(child: Image.asset(AssetPath.logo,height: 400,width: 400,)),);
  }
}


