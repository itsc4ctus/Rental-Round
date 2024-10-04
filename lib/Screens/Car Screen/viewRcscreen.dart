import 'dart:io';

import 'package:flutter/material.dart';

import '../../Models/car_model.dart';

class ViewRcscreen extends StatefulWidget {
  final Cars cars;
  const ViewRcscreen({required this.cars, super.key});

  @override
  State<ViewRcscreen> createState() => _ViewRcscreenState();
}

class _ViewRcscreenState extends State<ViewRcscreen> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("POLUTION CERTIFICATE"),
      ),
      body: Center(
        child: Container(
          child: Image(image: FileImage(File(widget.cars.rcImage)),),
        ),
      ),
    );
  }
}
