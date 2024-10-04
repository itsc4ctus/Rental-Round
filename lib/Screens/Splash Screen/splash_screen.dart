import 'package:flutter/material.dart';
import 'package:rentel_round/Authentication/Screens/login_page.dart';
import 'package:rentel_round/Models/auth_model.dart';
import 'package:rentel_round/Services/auth_services.dart';
import 'package:rentel_round/Services/car_services.dart';

import '../Navbar Screen/navbar.dart';



class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final AuthServices authServices = AuthServices();
  final CarServices carServices = CarServices();
  @override
  void initState()
  {


_navigateToHome();
    // TODO: implement initState
    super.initState();
  }


Future<void> _navigateToHome()async{
  bool? status=  await authServices.getloginStatus();
  if(status==true){
    Auth? lastuser =await authServices.getLastUser();

    if(lastuser !=null) {
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (context) => NavBar(auth: lastuser),));
    }else{
      _navigateToLogin();
    }
  }else{
    _navigateToLogin();
  }
}

  Future<void> _navigateToLogin() async{
    await Future.delayed(const Duration(seconds: 3));
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) =>const LoginPage()));

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     backgroundColor: Colors.blue.shade900,
body: const Center(child: Text("RENTAL\nROUND",textAlign: TextAlign.center,
style: TextStyle(
  fontFamily: "jaro",
fontSize: 80,
  color: Colors.white
),
)),
    );
  }
}
