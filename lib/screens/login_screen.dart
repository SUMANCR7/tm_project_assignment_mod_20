import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:tmp_assignment_mod_20/controller/auth_controller.dart';
import 'package:tmp_assignment_mod_20/data/models/user_model.dart';
import 'package:tmp_assignment_mod_20/screens/forget_pass_Email.dart';
import 'package:tmp_assignment_mod_20/screens/main_nav_screen.dart';
import 'package:tmp_assignment_mod_20/screens/sign_up_screen.dart';
import 'package:tmp_assignment_mod_20/widget/screen_bg.dart';

import '../data/models/api_response.dart';
import '../data/service/api_caller.dart';
import '../utils/urls.dart';

class LogInScreen extends StatefulWidget {
  const LogInScreen({super.key});

  @override
  State<LogInScreen> createState() => _LogInScreenState();
}

class _LogInScreenState extends State<LogInScreen> {

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  onTapSignUp() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => SignUpScreen()),
    );
  }

  //--------Method for [ LOG IN ]------//

  Future<void> logIn() async {
    //--call POST request from API caller---//
    final ApiResponse response =await ApiCaller.postRequest(URL: TMurls.log_In,
        body: {
          "email": _emailController.text,

          "password": _passwordController.text,
        }
    );
    if(response.isSuccess){
      UserModel model = UserModel.fromJson(response.responseData['data']);
      String token = response.responseData['token'];

      //---Auth Controller-- POST--//
      AuthController.saveUserData(model, token);

      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> MainNavScreen()));
      //------Snack bar message------//
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Login Success...!')));
    }else{
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Something Wrong...!')));
    }
  }

  @override
  Widget build(BuildContext context) {
    //-----Scaffold-----//
    return Scaffold(
      body: ScreenBG(
        child: Padding(
          padding: const EdgeInsets.all(35),

          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 150),
                Text(
                  'Get Started With',
                  //------predefine theme------//
                  style: Theme.of(context).textTheme.titleLarge,
                ),

                SizedBox(height: 25),

                //------Table-------//

                //--------for Email--------//
                TextFormField(
                  controller: _emailController,
                  decoration: InputDecoration(hintText: 'Email'),
                  //-----validation----//
                  validator: (myValue){
                    if(myValue == null || myValue.isEmpty){
                      return 'Please enter email';
                    }else{
                      return null;
                    }
                  },
                ),

                SizedBox(height: 10),

                //--------for Password--------//
                TextFormField(
                  controller: _passwordController,
                  obscureText: true,
                  decoration: InputDecoration(hintText: 'Password'),
                  //-----validation----//
                  validator: (myValue){
                    if(myValue == null || myValue.isEmpty){
                      return 'Please enter password';
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
                      logIn();
                    }
                    //Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>MainNavScreen()));
                  },
                  child: Icon(Icons.arrow_circle_right_outlined, size: 30),
                ),

                SizedBox(height: 40),

                Center(
                  child: Column(
                    children: [
                      //-------Text Button-------//
                      TextButton(
                        onPressed: () {
                          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> ForgetPassEmail()));
                        },
                        child: Text(
                          'Forget Password ?',
                          style: TextStyle(color: Colors.grey),
                        ),
                      ),

                      //----Rich Text----//
                      RichText(
                        text: TextSpan(
                          text: "Don't have an account ?",
                          style: TextStyle(color: Colors.black),
                          children: [
                            TextSpan(
                              text: " Sign up",
                              style: TextStyle(
                                color: Colors.green,
                                fontWeight: .bold,
                              ),

                              //---for clickable text button (recognizer)----//
                              recognizer: TapGestureRecognizer()..onTap = onTapSignUp,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
