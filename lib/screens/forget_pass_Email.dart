import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:tmp_assignment_mod_20/screens/pin_verify.dart';

import '../widget/screen_bg.dart';
import 'login_screen.dart';

class ForgetPassEmail extends StatefulWidget {
  const ForgetPassEmail({super.key});

  @override
  State<ForgetPassEmail> createState() => _ForgetPassEmailState();
}

class _ForgetPassEmailState extends State<ForgetPassEmail> {

  onTapLogIn(){
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>LogInScreen()));
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
                'Your Email Address',
                //------predefine theme------//
                style: Theme.of(context).textTheme.titleLarge,
              ),

              SizedBox(height: 25),

              Text('A 6 digit verification pin send your email address',style: TextStyle(fontSize: 17),),

              SizedBox(height: 15,),

              //------Table-------//

              //--------for Email--------//
              TextFormField(decoration: InputDecoration(hintText: 'Email')),

              SizedBox(height: 10),

              //--------for Password--------//

              SizedBox(height: 20),

              //----------button---------//
              FilledButton(
                onPressed: () {
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>PinVerification()));
                },
                child: Icon(Icons.arrow_circle_right_outlined, size: 30),
              ),

              SizedBox(height: 40),

              Center(
                child: Column(
                  children: [
                    //-------Text Button-------//


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
