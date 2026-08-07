import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:tmp_assignment_mod_20/data/models/api_response.dart';
import 'package:tmp_assignment_mod_20/data/service/api_caller.dart';
import 'package:tmp_assignment_mod_20/screens/login_screen.dart';

import '../utils/urls.dart';
import '../widget/screen_bg.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {

  onTapLogIn(){
  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>LogInScreen()));
}

  //--------Method for [ SIGN UP ]------//

  Future<void> signUp() async {
    //--call POST request from API caller---//
    final ApiResponse response =await ApiCaller.postRequest(URL: TMurls.sign_Up,
        body: {
          "email": _emailController.text,
          "firstName": _firstNameController.text,
          "lastName": _lastNameController.text,
          "mobile": _mobileNumberlController.text,
          "password": _passwordController.text,
        }
    );
    if(response.isSuccess){
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> LogInScreen()));
      //------Snack bar message------//
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('SignUp Success...!')));
    }else{
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Something Wrong...!')));
    }
  }

final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

final TextEditingController _emailController = TextEditingController();
final TextEditingController _firstNameController = TextEditingController();
final TextEditingController _lastNameController = TextEditingController();
final TextEditingController _mobileNumberlController = TextEditingController();
final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    //--------Scaffold------//
    return Scaffold(
      //--------BODY---------//
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
                  'Join With Us',
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
            
                TextFormField(
                    controller: _firstNameController,
                    decoration: InputDecoration(hintText: 'First Name'),
                    //-----validation----//
                    validator: (myValue){
          if(myValue == null || myValue.isEmpty){
          return 'Please enter first name';
          }else{
          return null;
          }
          },
                ),
            
                SizedBox(height: 10),
            
                TextFormField(
                    controller: _lastNameController,
                    decoration: InputDecoration(hintText: 'Last name'),
                  //-----validation----//
                  validator: (myValue){
                    if(myValue == null || myValue.isEmpty){
                      return 'Please enter last name';
                    }else{
                      return null;
                    }
                  },
                ),
            
                SizedBox(height: 10),
            
                TextFormField(
                    controller: _mobileNumberlController,
                    decoration: InputDecoration(hintText: 'Mobile Number'),
                  //-----validation----//
                  validator: (myValue){
                    if(myValue == null || myValue.isEmpty){
                      return 'Please enter mobile number';
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
                    if(_formKey.currentState!.validate()){}
                    signUp();
                  },
                  child: Icon(Icons.arrow_circle_right_outlined, size: 30),
                ),
            
                SizedBox(height: 40),
            
                Center(
                  child: Column(
                    children: [
            
                      //----Rich Text----//
                      RichText(
                        text: TextSpan(
                          text: "Have account ?",
                          style: TextStyle(color: Colors.black),
                          children: [
                            TextSpan(
                              text: " Sign in",
                              style: TextStyle(
                                color: Colors.green,
                                fontWeight: .bold,
                              ),
            
                              //---for clickable text button (recognizer)----//
                              recognizer: TapGestureRecognizer()..onTap = onTapLogIn,
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
