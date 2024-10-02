import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:rentel_round/Authentication/Screens/Sign-Up/signupfeild.dart';
import 'package:rentel_round/Authentication/Screens/login_page.dart';
import 'package:rentel_round/Models/auth_model.dart';
import 'package:rentel_round/Services/auth_services.dart';


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
  final ImagePicker _picker = ImagePicker();
  XFile? _image;

  Future<void> pickImage() async{
   final XFile? pickedimg = await _picker.pickImage(source: ImageSource.gallery);
   if(pickedimg!=null){
     setState(() {
       _image = pickedimg;
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
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      IconButton(onPressed: (){
                       Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => const LoginPage()
                         ,), (route) => false);
                      }, icon: const Icon(CupertinoIcons.back)),
                      Container(

                        child: const Text(
                          "SIGNUP",
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 30, color: Colors.black),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Container(
                      height: 80,
                      width: 80,
                      color: Colors.purple.shade100,
                      child: _image == null?const Icon(Icons.image):Image(image: FileImage(File(_image!.path)))

                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  ElevatedButton(
                    onPressed: () async{
                     await pickImage();
                    },
                    child: const Text(
                      "UPLOAD",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  feilds.feild("shop name", "enter your shop name", shopnameController, (value){
                    if(value==null||value.isEmpty){
                      return 'Enter a valid name';
                    }
                    return null;
                  }),
                  const SizedBox(
                    height: 10,
                  ),
                  feilds.feild("shop owner name", "enter your shop owner name", shopownernameController, (value){
                    if(value==null||value.isEmpty){
                      return 'Enter a valid shop owner name';
                    }
                    return null;
                  }),
                  const SizedBox(
                    height: 10,
                  ),feilds.feild("shop location", "enter your shop location", shoplocationController, (value){
                    if(value==null||value.isEmpty){
                      return 'Enter a location';
                    }
                    return null;
                  }),
                  const SizedBox(
                    height: 10,
                  ),
                  feilds.feild("phone number", "enter your phone number", shopphonenoController,(value){
                    if(value==null||value.isEmpty){
                      return 'Enter a valid phone number';
                    }
                    if(value.length!=10){
                      return 'Enter A 10 digit number';
                    }
                    return null;
                  },TextInputType.phone,[FilteringTextInputFormatter.digitsOnly]),
                  const SizedBox(
                    height: 10,
                  ),
                  feilds.feild("username", "enter username", usernameController, (value){
                    if(value==null||value.isEmpty){
                      return 'Enter a username';
                    }
                    return null;
                  }),
                  const SizedBox(
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
                  const SizedBox(
                    height: 10,
                  ),
                  feilds.feild("password", "enter your password", passwordController, (value){
                    if(value==null||value.isEmpty){
                      return 'Enter a password';
                    }
                    return null;
                  },TextInputType.text,[],true),
                  const SizedBox(
                    height: 10,
                  ),
                  feilds.feild("confirm password", "enter your password", cpasswordController, (value){
                    if(value==null||value.isEmpty){
                      return 'Enter a password';
                    }
                    return null;
                  },TextInputType.text,[],true),
                  const SizedBox(
                    height: 10,
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      if(_formKey.currentState!.validate()){
                        if(_image==null){
                          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Upload an image")));
                          return;
                        }
                        if(passwordController.text != cpasswordController.text){
                          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("passwords must be same!")));
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
                                builder: (context) => const LoginPage()));
                      }else{
                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Please fill the above details!")));
                      }
                    },
                    child: const Text(
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
