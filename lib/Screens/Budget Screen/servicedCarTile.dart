import 'dart:io';

import 'package:flutter/material.dart';

import '../../Models/car_model.dart';

class ServicedCarTile extends StatefulWidget {
   ServicedCarTile({required this.car, super.key});
Cars car;
  @override
  State<ServicedCarTile> createState() => _ServicedCarTileState();
}

class _ServicedCarTileState extends State<ServicedCarTile> {
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white
        ),
        width: 200,
        height: 80,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(

                height: 70,
                width: 70,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  
                ),
                child: Image(image: FileImage(File(widget.car.carImage)),),
              ),
              Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("SERVICE DATE"),
                    Text("${widget.car.servicedDate!.day} - ${widget.car.servicedDate!.month} - ${widget.car.servicedDate!.year}"),
                  ],
                ),
              ),
              SizedBox(
                height: 30,
                width: 80,

                child: Row(
                  children: [

                    Text("₹ ${widget.car.serviceAmount.toString()}"),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
