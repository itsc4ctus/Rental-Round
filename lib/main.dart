import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:rentel_round/Models/auth_model.dart';
import 'package:rentel_round/Models/expences_model.dart';
import 'package:rentel_round/Services/auth_services.dart';
import 'package:rentel_round/Services/car_services.dart';
import 'package:rentel_round/Services/expence_services.dart';
import 'package:rentel_round/Services/status_services.dart';


import 'Models/car_model.dart';
import 'Models/status_model.dart';
import 'Screens/splash_screen.dart';

void main() async{
  await Hive.initFlutter();
  Hive.registerAdapter(AuthAdapter());
  Hive.registerAdapter(CarsAdapter());
  Hive.registerAdapter(statusAdapter());
  Hive.registerAdapter(expensesAdapter());
  await AuthServices().openBox();
  await CarServices().openBox();
  await StatusServices().openBox();
  await ExpenceServices().openBox();

  runApp(const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
debugShowCheckedModeBanner: false,
      theme: ThemeData(

        scaffoldBackgroundColor: Colors.blue.shade50,
          elevatedButtonTheme: ElevatedButtonThemeData(
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue.shade900,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(7)),
                textStyle: const TextStyle(
                  fontFamily: "fredoka"
                ),
              )

          ),

          appBarTheme: AppBarTheme(
            iconTheme: const IconThemeData(
              color: Colors.white
            ),
            titleTextStyle: const TextStyle(
                color: Colors.white,
                fontFamily: 'jaro',
                fontSize: 24
            ),
            color: Colors.blue.shade900,

          ),
          fontFamily: 'fredoka'
      ),
      home: const SplashScreen(),
    );
  }
}
