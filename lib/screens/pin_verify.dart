import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:tmp_assignment_mod_20/screens/set_password.dart';

import '../widget/screen_bg.dart';
import 'login_screen.dart';


class PinVerification extends StatefulWidget {
  const PinVerification({super.key});

  @override
  State<PinVerification> createState() => _PinVerificationState();
}

class _PinVerificationState extends State<PinVerification> {

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
                'Pin Verification',
                //------predefine theme------//
                style: Theme.of(context).textTheme.titleLarge,
              ),

              SizedBox(height: 25),

              Text('A 6 digit verification pin send your email address',style: TextStyle(fontSize: 17),),

              SizedBox(height: 15,),


              //-----Pin verification 6 digit field------//

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: List.generate(6, (index) {
                  return SizedBox(
                    height: 50,
                    width: 45,
                    child: TextField(
                      textAlign: TextAlign.center,
                      keyboardType: TextInputType.number,
                      maxLength: 1,
                      decoration: InputDecoration(
                        counterText: "",
                        fillColor: Colors.white,
                        filled: true,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide.none,
                        ),
                      ),
                      onChanged: (value) {
                        if (value.length == 1 && index < 5) {
                          FocusScope.of(context).nextFocus();
                        }
                        if (value.isEmpty && index > 0) {
                          FocusScope.of(context).previousFocus();
                        }
                      },
                    ),
                  );
                }),
              ),

              SizedBox(height: 20),

              //----------button---------//
              FilledButton(
                onPressed: () {
                  //------------//
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>SetPassword()));

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
