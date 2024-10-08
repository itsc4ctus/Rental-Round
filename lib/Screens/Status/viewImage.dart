import 'dart:io';

import 'package:flutter/material.dart';


class ViewImage extends StatelessWidget {
  String image;
  ViewImage({required this.image,super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

      ),
      backgroundColor: Colors.white,
      body: Center(
        child: Container(

          height: 350,
          width: 350,
          child: Image(image: FileImage(File(image))),
        ),
      ),
    );


  }
}
