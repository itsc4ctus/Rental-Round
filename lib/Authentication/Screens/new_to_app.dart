import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:rentel_round/Authentication/Screens/enter_profile.dart';
import 'package:rentel_round/Authentication/Screens/signup_page.dart';
import 'package:rentel_round/Models/auth_model.dart';
import 'package:rentel_round/Screens/Navbar%20Screen/navbar.dart';
import 'package:rentel_round/Services/auth_services.dart';


class NewToHome extends StatefulWidget {

  const NewToHome({super.key});

  @override
  State<NewToHome> createState() => _NewToHomeState();
}

class _NewToHomeState extends State<NewToHome> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey();


  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var screenHeigth = size.height;
    var screenWidth = size.width;

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
                  Text("WELCOME TO RENTAL ROUND,"),
                  Text("RENTAL\nROUND",textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 50,
                        color: Colors.blue.shade900,
                        fontFamily: "jaro"
                    ),),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                 
                    child: Lottie.asset('lib/assets/animations/car.json'),
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  Text("Enter your details to get started."),
                 const SizedBox(
                    height: 50,
                  ),
                  ElevatedButton(onPressed: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>const AddProfile()));
                  }, child: const Text("OPEN SHOP",
                    style: TextStyle(
                        color: Colors.white
                    ),
                  ),

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
