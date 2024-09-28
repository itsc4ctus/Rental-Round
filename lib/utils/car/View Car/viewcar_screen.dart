import 'dart:io';
import 'package:flutter/material.dart';
import 'package:rentel_round/utils/car/View%20Car/viewcartiles.dart';
import 'package:rentel_round/utils/car/car_tile.dart';
import 'package:rentel_round/utils/car/viewPCscreen.dart';
import 'package:rentel_round/utils/car/viewRcscreen.dart';

import '../../../Models/car_model.dart';

class ViewcarScreen extends StatefulWidget {
  final Cars car;
  const ViewcarScreen({required this.car, super.key});

  @override
  State<ViewcarScreen> createState() => _ViewcarScreenState();
}

class _ViewcarScreenState extends State<ViewcarScreen> {
  late DateTime _dateTime;

  @override
  void initState() {
    _dateTime = widget.car.pollutionDate;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          "Car Details",
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 20,
          ),
        ),
        backgroundColor: Color(0xFF1E3A8A),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [

            Container(
              child: Image(image: FileImage(File(widget.car.carImage))),
              padding: EdgeInsets.symmetric(vertical: 8),
              height: 160,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.blue.shade100),
                color: Colors.blue.shade50, // Light Gray Border
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    spreadRadius: 2,
                    blurRadius: 8,
                  ),
                ],
              ),
            ),

            SizedBox(height: 16),
            Column(
              children: [
                Text(
                  widget.car.brandName,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: Color(0xFF1E3A8A), // Dark Blue
                  ),
                ),
                Text(
                  widget.car.carName,
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFF60A5FA), // Light Blue
                  ),
                ),
              ],
            ),

            SizedBox(height: 20),
            Card(
              color: Colors.blue.shade50,
              elevation: 4,
              shadowColor: Colors.black26,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    buildInfoRow("Vehicle No:", widget.car.vehicleNo),
                    buildInfoRow("Amount/Day:", widget.car.amtPerDay.toString()),
                    buildInfoRow("Cubic Capacity:", widget.car.cubicCapacity.toString()),
                  ],
                ),
              ),
            ),


            SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: ViewCarTiles().BlueTile("Seat Capacity:", widget.car.seatCapacity.toString()),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: ViewCarTiles().BlueTile("KM Driven:", widget.car.kmDriven.toString()),
                ),
              ],
            ),


            SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: buildCardWithLabel(
                    label: "Transmission",
                    value: widget.car.carType == "M" ? "Manual" : "Automatic",
                  ),
                ),
              ],
            ),


            SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: buildCardWithLabel(
                    label: "Fuel Type",
                    value: widget.car.fuelType,
                  ),
                ),
              ],
            ),


            SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "Pollution Validity",
                        style: TextStyle(
                          fontSize: 14,
                          color: Color(0xFF1E3A8A),
                          fontWeight: FontWeight.w500,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 8),
                      ViewCarTiles().viewDate(_dateTime),
                    ],
                  ),
                ),
              ],
            ),

            SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF60A5FA), // Light Blue
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Viewpcscreen(cars: widget.car),
                  ),
                );
              },
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  "View Pollution Certificate",
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
              ),
            ),

            SizedBox(height: 10),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF1E3A8A), // Dark Blue
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ViewRcscreen(cars: widget.car),
                  ),
                );
              },
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  "View RC: ${widget.car.rcNo}",
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: Color(0xFF1E3A8A),
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: 16,
              color: Color(0xFF1E40AF),
            ),
          ),
        ],
      ),
    );
  }


  Widget buildCardWithLabel({required String label, required String value}) {
    return Card(
      color: Colors.blue.shade50,
      elevation: 4,
      shadowColor: Colors.black12,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(
              label,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Color(0xFF1E3A8A),
              ),
            ),
            SizedBox(height: 8),
            Text(
              value,
              style: TextStyle(
                fontSize: 20,
                color: Color(0xFF1E40AF),
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
