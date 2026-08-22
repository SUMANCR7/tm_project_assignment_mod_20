
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:tmp_assignment_mod_20/data/models/user_model.dart';

class AuthController {

  static String ? token;
  static UserModel ? userData;

  //--------[ POST ]---JSON--ENCODE----//

  static Future saveUserData(UserModel model, String token) async {
    SharedPreferences sharedPreferences =await SharedPreferences.getInstance();

    //---for TOKEN---//
    sharedPreferences.setString('token', token);
    sharedPreferences.setString('user-data', jsonEncode(model.toString()));

    //---Now update token and userdata---//
    token = token;
    userData = model;
  }

  //-------[[ GET ]---JSON---DECODE------//

static Future getUserData() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    String ? tkn = sharedPreferences.getString('token');

    if(tkn != null){
      token = tkn;
    }

    String ? uData = sharedPreferences.getString('user-data');

    if(uData != null){
      userData = UserModel.fromJson(jsonDecode(uData));
    }
  }


  //----for Log In-----//
  static Future<bool> isUserLogIn() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    String ? tkn = sharedPreferences.getString('token');

               //----set condition---//
     //---con-1--//
    if(tkn != null){
      return true;
    }else{
      return false;
    }
    //---con-2---//
    //return tkn != null;   //---con-1 & 2 are same value---//
  }


}