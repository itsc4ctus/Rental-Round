import 'dart:io';

import 'package:flutter/material.dart';
import 'package:rentel_round/Models/workshop_model.dart';

class WorkShoptile extends StatefulWidget {
  WorKShopModel workshop;
  WorkShoptile({required this.workshop, super.key});

  @override
  State<WorkShoptile> createState() => _WorkShoptileState();
}

class _WorkShoptileState extends State<WorkShoptile> {

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
                child: Image(image: FileImage(File(widget.workshop.car.carImage)),),
              ),
              Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("SERVICE DATE"),
                    Text("${widget.workshop.dateTime.day} - ${widget.workshop.dateTime.month} - ${widget.workshop.dateTime.year}"),
                  ],
                ),
              ),
              SizedBox(
                height: 30,
                width: 80,

                child: Row(
                  children: [

                    Text("₹ ${widget.workshop.serviceAmount}"),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );;
  }
}
