import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
class ShowAnimation{
  void showAnimation(BuildContext context){
    showDialog(context: context, builder: (context){
      return Dialog(
        backgroundColor: Colors.transparent,
        child:SizedBox(
          child:Lottie.asset("lib/assets/animations/completed.json"),

        )

      );
    },);
  }
}
