import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:rentel_round/Authentication/Screens/signup_page.dart';
import 'dart:io';
import '../../Models/auth_model.dart';


class ProfileScreen extends StatefulWidget {
  final Auth auth;
  const ProfileScreen({required this.auth, super.key});

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
        title: Text("SHOP DETAILS"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding:EdgeInsets.all(12),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all()
              
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: 100,
                    width: 100,

                    child: CircleAvatar(
                      backgroundImage: widget.auth.image.isNotEmpty?FileImage(File(widget.auth.image)):null,
                      child: widget.auth.image.isEmpty?Icon(CupertinoIcons.car):null,
                    ),
                  ),
                  Text(widget.auth.shopname,style: TextStyle(
                      fontSize: 24
                  ),),
                ],
              ),
            ),


            showDetails("OWNER", widget.auth.shopownername),
            showDetails("LOCATION", widget.auth.shoplocation),
            showDetails("SHOP PHONE NUMBER", widget.auth.phonenumer.toString()),
            showDetails("SHOP E-MAIL", widget.auth.email)
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
            Text("$label",
            style: TextStyle(
              fontFamily: "Roboto"
            ),
            ),
            Text("$data",
            style: TextStyle(
              fontSize: 24
            ),
            ),
          ],
        ),
      ),
    );
  }





}
