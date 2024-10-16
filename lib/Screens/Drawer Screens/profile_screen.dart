import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rentel_round/Authentication/Screens/new_to_app.dart';
import 'package:rentel_round/Screens/Drawer%20Screens/edit_profile.dart';
import 'package:rentel_round/Services/auth_services.dart';
import 'package:rentel_round/Services/car_services.dart';
import 'package:rentel_round/Services/expence_services.dart';
import 'package:rentel_round/Services/status_services.dart';
import 'package:rentel_round/Services/workshop_services.dart';
import 'dart:io';
import '../../Models/auth_model.dart';


class ProfileScreen extends StatefulWidget {
 final Auth auth;
  ProfileScreen({required this.auth, super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("SHOP DETAILS"),
        actions: [
          IconButton(onPressed: (){
Navigator.push(context, MaterialPageRoute(builder: (context) => EditProfile(auth: widget.auth,),));
          }, icon: Icon(Icons.edit_rounded))
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding:const EdgeInsets.all(12),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all()

              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 100,
                    width: 100,

                    child: CircleAvatar(
                      backgroundImage: widget.auth.image.isNotEmpty?FileImage(File(widget.auth.image)):null,
                      child: widget.auth.image.isEmpty?const Icon(CupertinoIcons.car):null,
                    ),
                  ),
                  Text(widget.auth.shopname,style: const TextStyle(
                      fontSize: 24
                  ),),
                ],
              ),
            ),


            showDetails("OWNER", widget.auth.shopownername),
            showDetails("LOCATION", widget.auth.shoplocation),
            showDetails("SHOP PHONE NUMBER", widget.auth.phonenumer.toString()),
            showDetails("SHOP E-MAIL", widget.auth.email),
ElevatedButton(onPressed: ()async{
  _showDialogue("Are you sure close shop?. It will remove all data!", "OK", ()async{
    await CarServices().clearBox();
    await ExpenceServices().clearBox();
    await StatusServices().clearBox();
    await WorkshopServices().clearBox();
    widget.auth.status = false;
    await AuthServices().updateUser(widget.auth);
    Navigator.pushReplacement(context, MaterialPageRoute(builder:(context) => NewToHome(),));
  }, context);

}, child: Text("LOGOUT"))
          ],
        ),
      ),
    );
  }

  Widget showDetails(String label,String data){
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(



        child: Column(
          children: [
            Text(label,
            style: const TextStyle(
              fontFamily: "Roboto"
            ),
            ),
            Text(data,
            style: const TextStyle(
              fontSize: 24
            ),
            ),
          ],
        ),
      ),
    );
  }

  void _showDialogue(String messege,String btnName,VoidCallback btnfn,BuildContext context){
    showDialog(context: context,builder: (context) {
      return AlertDialog(
        title: Text(messege),
        actions: [
          ElevatedButton(onPressed: (){
            Navigator.pop(context);
          }, child: const Text("CANCEL")),
          ElevatedButton(onPressed: btnfn, child: Text(btnName))
        ],
      );

    });

  }



}
