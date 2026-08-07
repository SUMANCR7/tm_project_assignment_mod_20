import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tmp_assignment_mod_20/controller/auth_controller.dart';
import 'package:tmp_assignment_mod_20/screens/main_nav_screen.dart';
import 'package:tmp_assignment_mod_20/utils/urls.dart';

import '../data/models/api_response.dart';
import '../data/models/user_model.dart';
import '../data/service/api_caller.dart';
import '../widget/screen_bg.dart';
import '../widget/snackbar.dart';
import 'dart:convert';

class UpdateProfile extends StatefulWidget {
  const UpdateProfile({super.key});

  @override
  State<UpdateProfile> createState() => _UpdateProfileState();
}

class _UpdateProfileState extends State<UpdateProfile> {

  //------[ Controller ]--------//

  final TextEditingController _emailTEController = TextEditingController();
  final TextEditingController _firstNameTEController = TextEditingController();
  final TextEditingController _lastNameTEController = TextEditingController();
  final TextEditingController _mobileTEController = TextEditingController();
  final TextEditingController _passwordTEController = TextEditingController();

  XFile? _pickedImage;



  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _emailTEController.text = AuthController.userData?.email ?? '';
    _firstNameTEController.text = AuthController.userData?.firstName ?? '';
    _lastNameTEController.text = AuthController.userData?.lastName ?? '';
    _mobileTEController.text = AuthController.userData?.mobile ?? '';


  }

  //---For Picture------//
  Future<void> _pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        _pickedImage = image;
      });
    }
  }

  Future<void> _updateProfile() async {
    Map<String, dynamic> allController = {
      "email": _emailTEController.text.trim(),
      "firstName": _firstNameTEController.text.trim(),
      "lastName": _lastNameTEController.text.trim(),
      "mobile": _mobileTEController.text.trim(),
    };
    if (_passwordTEController.text.isNotEmpty) {
      allController['password'] = _passwordTEController.text;

      //-------API------//
      if (_pickedImage != null) {
        List<int> imageBytes = await _pickedImage!.readAsBytes();
        allController['photo'] = base64Encode(imageBytes);
      }

      // ২. API Request
      final ApiResponse response = await ApiCaller.postRequest(URL:
        TMurls.updateProfile,
        body: allController,
      );

      //
      if (response.isSuccess) {
        //------Update AuthController----//
        UserModel updatedUser = UserModel(
          email: _emailTEController.text.trim(),
          firstName: _firstNameTEController.text.trim(),
          lastName: _lastNameTEController.text.trim(),
          mobile: _mobileTEController.text.trim(),
        );

        await AuthController.saveUserData(updatedUser, AuthController.token ?? '');

        if (mounted) {
          showSnackBar(context, 'Profile updated successfully!');
          Navigator.pop(context);
        }
      } else {
        if (mounted) {
          showSnackBar(context, response.errorMessage ?? 'Update failed!');
        }
      }

    }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Row(
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

     //--------BODY----------//

      body: ScreenBG(
        child: Padding(
          padding: const EdgeInsets.all(35),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 50),
              Text(
                'Update Profile',
                //------predefine theme------//
                style: Theme.of(context).textTheme.titleLarge,
              ),

              SizedBox(height: 25),

              //------Table-------//

              //--------for Email--------//

              Container(
                height: 48,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: _pickImage,
                      child: Container(
                        alignment: Alignment.center,
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        decoration: const BoxDecoration(
                          color: Color(0xFF666666),
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(8),
                            bottomLeft: Radius.circular(8),
                          ),
                        ),
                        child: const Text(
                          'Photos',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                    const Expanded(
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 12),
                        child: Text(
                          '',
                          style: TextStyle(color: Colors.black87),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: 10,),


              TextFormField(
                  controller: _emailTEController,
                  decoration: InputDecoration(hintText: 'Email')),

              SizedBox(height: 10),

              TextFormField(
                  controller: _firstNameTEController,
                  decoration: InputDecoration(hintText: 'First Name')),

              SizedBox(height: 10),

              TextFormField(
                  controller: _lastNameTEController,
                  decoration: InputDecoration(hintText: 'Last name')),

              SizedBox(height: 10),

              TextFormField(
                  controller: _mobileTEController,
                  decoration: InputDecoration(hintText: 'Mobile Number')),

              SizedBox(height: 10),

              TextFormField(
                  controller: _passwordTEController,
                  decoration: InputDecoration(hintText: 'Password')),

              SizedBox(height: 10),


              SizedBox(height: 20),

              //----------button---------//
              FilledButton(
                onPressed: () {
                  _updateProfile();
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Profile updated successfully!'),
                  duration: Duration(seconds: 3),
                  ));
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>MainNavScreen()));
                },
                child: Icon(Icons.arrow_circle_right_outlined, size: 30),
              ),

              SizedBox(height: 40),


            ],
          ),
        ),
      ),

    );
  }
}
