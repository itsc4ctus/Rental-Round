import 'package:flutter/material.dart';
import 'package:rentel_round/Authentication/Screens/new_to_app.dart';
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

  final CarServices carServices = CarServices();
  @override
  void initState()
  {
    checkStatus();
    // TODO: implement initState
    super.initState();
  }


  Future<void> checkStatus()async{
    final Auth? auth = await AuthServices().getUser("USER");
    if(auth == null){
      _navigateToNewToHome();
    }
    else if(auth.status == true){
      _navigateToRentalRound(auth);
    }

    else{
      _navigateToNewToHome();
    }

  }

  Future<void> _navigateToNewToHome() async{
    await Future.delayed(const Duration(seconds: 3));
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) =>NewToHome()));
  }

  Future<void> _navigateToRentalRound(Auth auth) async{
    await Future.delayed(const Duration(seconds: 3));
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) =>NavBar(auth: auth)));
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
