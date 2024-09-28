import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BottomSheetCarTile extends StatelessWidget {
  final String carName;
  final String vehicleNo;
  final int kmDriven;
  final int seatCapacity;
  final int cubicCapacity;
  final int rcNo;
  final DateTime pollutionDate;
  final String fuelType;
  final int amtPerDay;
  final String carImage;
  final String rcImage;
  final String pcImage;
  final String brandName;
  final String carType;


  const BottomSheetCarTile({
    Key? key,
    required this.carName,
    required this.vehicleNo,
    required this.kmDriven,
    required this.seatCapacity,
    required this.cubicCapacity,
    required this.rcNo,
    required this.pollutionDate,
    required this.fuelType,
    required this.amtPerDay,
    required this.carImage,
    required this.brandName,
    required this.carType,
    required this.pcImage,
    required this.rcImage,

  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        elevation: 2,

        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Container(

              child: Column(
                children: [
                  Image(
                      fit: BoxFit.cover,
                      image: FileImage(File(carImage))

                  ),
                  Text("$brandName",
                  style: TextStyle(
                    fontFamily: "Roboto",
                  ),
                  ),
                  Text("$carName"),
                  Text("amt/day:$amtPerDay"),
                ],
              ),
            ),
          ),
        )
      ),
    );
  }


}
