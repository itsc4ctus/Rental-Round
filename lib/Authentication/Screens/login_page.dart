import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rentel_round/Authentication/Screens/signup_page.dart';
import 'package:rentel_round/Models/auth_model.dart';
import 'package:rentel_round/Screens/Drawer%20Screens/profile_screen.dart';
import 'package:rentel_round/Screens/navbar.dart';
import 'package:rentel_round/Services/auth_services.dart';

import '../../Models/auth_model.dart';

class LoginPage extends StatefulWidget {

   LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
TextEditingController usernameController = TextEditingController();
TextEditingController passwordController = TextEditingController();
GlobalKey<FormState> _formKey = GlobalKey();
AuthServices authServices = AuthServices();

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            child: Form(
              key: _formKey,
              child: Column(

                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text("RENTAL\nROUND",textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 50,
                        color: Colors.blue.shade900,
                      fontFamily: "jaro"
                    ),),
                  SizedBox(
                    height: 50,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10.0,horizontal: 20),
                    child: TextFormField(
                      validator: (value){
                        if(value==null || value.isEmpty){
                          return "Enter a username";
                        }
                      },
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      controller: usernameController,
                      decoration: InputDecoration(

                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                        hintStyle: TextStyle(
                          fontFamily: 'Roboto',
                        ),
                        hintText: "enter your username",
                        label: Text("username"),

                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: TextFormField(
                      validator: (value){
                        if(value==null || value.isEmpty){
                          return "Enter a Password";
                        }
                      },
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      obscureText: true,
                      controller: passwordController,
                      decoration: InputDecoration(
                        hintStyle: TextStyle(
                          fontFamily: 'Roboto',
                        ),
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                        hintText: "enter your password" ,
                        label: Text("password"),

                      ),
                    ),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  ElevatedButton(onPressed: () async{
                    if(_formKey.currentState!.validate()){
                      await _login();
                    }
                  else{
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("User not found!")));
                    }
                  }, child: Text("LOGIN",
                  style: TextStyle(
                    color: Colors.white
                  ),
                  ),

                  ),
                  SizedBox(
                    height: 50,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Dont't have an account?",
                      style: TextStyle(
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.w500,

                      ),
                      ),
                      SizedBox(
                        width: 15,
                      ),
                      ElevatedButton(onPressed: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>SignupPage()));
                      }, child: Text("CREATE ACCOUNT",
                        style: TextStyle(
                            color: Colors.white
                        ),
                      ),

                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
  Future<void> _login() async{

    //getdata
    List<Auth> users = await authServices.getData();

    bool? loginSuccesfull= false;

    for(var user in users){
      if(user.username == usernameController.text && user.password == passwordController.text){
        loginSuccesfull = true;
        await authServices.setLoginStatus(true);
        await authServices.writeData(user);

        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => NavBar(auth: user,),), (route) => false,);
        break;
      }
    }
    if(loginSuccesfull==false){
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Invalid User Name Or Password!")));
    }
  }
}
