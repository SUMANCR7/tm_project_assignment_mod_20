import 'package:flutter/material.dart';
import 'package:tmp_assignment_mod_20/screens/splash_screen.dart';

class MyAPP extends StatelessWidget {
  const MyAPP({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(

      theme: ThemeData(
        //---for Text-----//
        textTheme: TextTheme(
          titleLarge: TextStyle(
            fontSize: 28,
            fontWeight: .w600
          )
        ),

        //----for Table (Text Form Field)---//
        inputDecorationTheme: InputDecorationTheme(
          fillColor: Colors.white,
          filled: true ,
          hintStyle: TextStyle(
            color: Colors.grey,
          ),

          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide.none,
          ),
        ),

        //--- for button---//
        filledButtonTheme: FilledButtonThemeData(
          style: FilledButton.styleFrom(
            backgroundColor: Colors.green,
            fixedSize: Size.fromWidth(double.maxFinite),
            padding: EdgeInsets.symmetric(vertical: 12),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            )
          )
        )

      ),

      title: 'Flutter 16',
      home: SplashScreen(),

    );
  }
}