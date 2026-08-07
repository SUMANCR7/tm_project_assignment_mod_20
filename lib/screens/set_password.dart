import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import '../widget/screen_bg.dart';
import 'login_screen.dart';

class SetPassword extends StatefulWidget {
  const SetPassword({super.key});

  @override
  State<SetPassword> createState() => _SetPasswordState();
}

class _SetPasswordState extends State<SetPassword> {

  onTapLogIn(){
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> LogInScreen()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ScreenBG(
        child: Padding(
          padding: const EdgeInsets.all(35),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 150),
              Text(
                'Set Password',
                //------predefine theme------//
                style: Theme.of(context).textTheme.titleLarge,
              ),

              SizedBox(height: 25),

              Text('Enter your new password to proceed with your account',style: TextStyle(fontSize: 17),),

              SizedBox(height: 15,),

              //------Table-------//

              //--------for Password--------//
              TextFormField(
                  obscureText: true,
                  decoration: InputDecoration(hintText: 'Password')),

              SizedBox(height: 10),

              //--------for Confirm Password--------//
              TextFormField(
                  obscureText: true,
                  decoration: InputDecoration(hintText: 'Confirm Password')),



              SizedBox(height: 20),

              //----------button---------//
              FilledButton(
                onPressed: () {
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> LogInScreen()));
                },
                child: Text('Confirm',style: TextStyle(fontSize: 18),),
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
    );
  }
}
