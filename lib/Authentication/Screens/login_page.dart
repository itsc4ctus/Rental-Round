import 'package:flutter/material.dart';
import 'package:rentel_round/Authentication/Screens/signup_page.dart';
import 'package:rentel_round/Models/auth_model.dart';
import 'package:rentel_round/Screens/Navbar%20Screen/navbar.dart';
import 'package:rentel_round/Services/auth_services.dart';


class LoginPage extends StatefulWidget {

   const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
TextEditingController usernameController = TextEditingController();
TextEditingController passwordController = TextEditingController();
final GlobalKey<FormState> _formKey = GlobalKey();
// AuthServices authServices = AuthServices();

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
                  const SizedBox(
                    height: 50,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10.0,horizontal: 20),
                    child: TextFormField(
                      validator: (value){
                        if(value==null || value.isEmpty){
                          return "Enter a username";
                        }
                        return null;
                      },
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      controller: usernameController,
                      decoration: InputDecoration(

                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                        hintStyle: const TextStyle(
                          fontFamily: 'Roboto',
                        ),
                        hintText: "enter your username",
                        label: const Text("username"),

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
                        return null;
                      },
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      obscureText: true,
                      controller: passwordController,
                      decoration: InputDecoration(
                        hintStyle: const TextStyle(
                          fontFamily: 'Roboto',
                        ),
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                        hintText: "enter your password" ,
                        label: const Text("password"),

                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  ElevatedButton(onPressed: () async{
                    if(_formKey.currentState!.validate()){

                    }
                  else{
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("User not found!")));
                    }
                  }, child: const Text("LOGIN",
                  style: TextStyle(
                    color: Colors.white
                  ),
                  ),

                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Dont't have an account?",
                      style: TextStyle(
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.w500,

                      ),
                      ),
                      const SizedBox(
                        width: 15,
                      ),
                      ElevatedButton(onPressed: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>const SignupPage()));
                      }, child: const Text("CREATE ACCOUNT",
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

}
