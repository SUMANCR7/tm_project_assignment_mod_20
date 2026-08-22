import 'package:flutter/widgets.dart';

import '../controller/auth_controller.dart';
import '../data/models/api_response.dart';
import '../data/models/user_model.dart';
import '../data/service/api_caller.dart';
import '../utils/urls.dart';

class AuthProvider extends ChangeNotifier {

  bool isLoading = false;
  String ? errorMessage;

  //--- set loading method---//
  void setLoading (bool value){
    isLoading = value;
    notifyListeners();
  }

  //----Login method from Login page----//
  Future<bool> logIn(String email, String password) async {
    setLoading(true);
    //--call POST request from API caller---//
    final ApiResponse response =await ApiCaller.postRequest(URL: TMurls.log_In,
        body: {
          "email": email,
          "password": password,
        }
    );
    setLoading(false);

    if(response.isSuccess){
      UserModel model = UserModel.fromJson(response.responseData['data']);
      String token = response.responseData['token'];

      //---Auth Controller-- POST--//
      AuthController.saveUserData(model, token);
      return true;
    }else{
     return false;
    }
  }

}