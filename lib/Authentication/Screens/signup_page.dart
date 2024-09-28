import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:rentel_round/Authentication/Screens/Sign-Up/signupfeild.dart';
import 'package:rentel_round/Authentication/Screens/login_page.dart';
import 'package:rentel_round/Models/auth_model.dart';
import 'package:rentel_round/Screens/navbar.dart';
import 'package:rentel_round/Services/auth_services.dart';

import '../../Screens/Drawer Screens/profile_screen.dart';

class SignupPage extends StatefulWidget {

  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

TextEditingController shopnameController = TextEditingController();
TextEditingController shopownernameController = TextEditingController();
TextEditingController shoplocationController = TextEditingController();
TextEditingController shopphonenoController = TextEditingController();
TextEditingController usernameController = TextEditingController();
TextEditingController emailController = TextEditingController();
TextEditingController passwordController = TextEditingController();
TextEditingController cpasswordController = TextEditingController();
final GlobalKey<FormState> _formKey = GlobalKey();
XFile? img;

class _SignupPageState extends State<SignupPage> {
  SignUpFeilds feilds = SignUpFeilds();
  ImagePicker _picker = ImagePicker();
  XFile? _image;

  Future<void> pickImage() async{
   final XFile? _pickedimg = await _picker.pickImage(source: ImageSource.gallery);
   if(_pickedimg!=null){
     setState(() {
       _image = _pickedimg;
     });

   }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _formKey,
        child: Center(
          child: SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.all(20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      IconButton(onPressed: (){
                       Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => LoginPage()
                         ,), (route) => false);
                      }, icon: Icon(CupertinoIcons.back)),
                      Container(

                        child: Text(
                          "SIGNUP",
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 30, color: Colors.black),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Container(
                      height: 80,
                      width: 80,
                      color: Colors.purple.shade100,
                      child: _image == null?Icon(Icons.image):Image(image: FileImage(File(_image!.path)))

                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  ElevatedButton(
                    onPressed: () async{
                     await pickImage();
                    },
                    child: Text(
                      "UPLOAD",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  feilds.feild("shop name", "enter your shop name", shopnameController, (value){
                    if(value==null||value.isEmpty){
                      return 'Enter a valid name';
                    }
                  }),
                  SizedBox(
                    height: 10,
                  ),
                  feilds.feild("shop owner name", "enter your shop owner name", shopownernameController, (value){
                    if(value==null||value.isEmpty){
                      return 'Enter a valid shop owner name';
                    }
                  }),
                  SizedBox(
                    height: 10,
                  ),feilds.feild("shop location", "enter your shop location", shoplocationController, (value){
                    if(value==null||value.isEmpty){
                      return 'Enter a location';
                    }
                  }),
                  SizedBox(
                    height: 10,
                  ),
                  feilds.feild("phone number", "enter your phone number", shopphonenoController,(value){
                    if(value==null||value.isEmpty){
                      return 'Enter a valid phone number';
                    }
                    if(value.length!=10){
                      return 'Enter A 10 digit number';
                    }
                  },TextInputType.phone,[FilteringTextInputFormatter.digitsOnly]),
                  SizedBox(
                    height: 10,
                  ),
                  feilds.feild("username", "enter username", usernameController, (value){
                    if(value==null||value.isEmpty){
                      return 'Enter a username';
                    }
                  }),
                  SizedBox(
                    height: 10,
                  ),
                  feilds.feild("email", "enter your email", emailController, (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter an email address';
                    }
                    if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                      return 'Please enter a valid email';
                    }
                    return null;
                  },),
                  SizedBox(
                    height: 10,
                  ),
                  feilds.feild("password", "enter your password", passwordController, (value){
                    if(value==null||value.isEmpty){
                      return 'Enter a password';
                    }
                  },TextInputType.text,[],true),
                  SizedBox(
                    height: 10,
                  ),
                  feilds.feild("confirm password", "enter your password", cpasswordController, (value){
                    if(value==null||value.isEmpty){
                      return 'Enter a password';
                    }
                  },TextInputType.text,[],true),
                  SizedBox(
                    height: 10,
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      if(_formKey.currentState!.validate()){
                        if(_image==null){
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Upload an image")));
                          return;
                        }
                        if(passwordController.text != cpasswordController.text){
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("passwords must be same!")));
                          return;
                        }
                        Auth auth = Auth(
                            username: usernameController.text,
                            password: passwordController.text,
                            shopname: shopnameController.text,
                            shopownername: shopownernameController.text,
                            shoplocation: shoplocationController.text,
                            phonenumer: int.parse(shopphonenoController.text),
                            email: emailController.text,
                            image: _image!.path
                        );
                        await AuthServices().writeData(auth);
                        await AuthServices().setLoginStatus(true);
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => LoginPage()));
                      }else{
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Please fill the above details!")));
                      }
                    },
                    child: Text(
                      "CREATE ACCOUNT",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
