import 'dart:io';
import 'package:flutter/material.dart';
import 'package:rentel_round/Screens/Car%20Screen/View%20Car/viewcarcards/Widgets/PCbutton.dart';
import 'package:rentel_round/Screens/Car%20Screen/View%20Car/viewcarcards/Widgets/RCButton.dart';
import 'package:rentel_round/Screens/Car%20Screen/View%20Car/viewcarcards/Widgets/car_details_tile.dart';
import 'package:rentel_round/Screens/Car%20Screen/View%20Car/viewcarcards/Widgets/car_image_tile.dart';
import 'package:rentel_round/Screens/Car%20Screen/View%20Car/viewcarcards/Widgets/headingTile.dart';
import 'package:rentel_round/Screens/Car%20Screen/View%20Car/viewcarcards/view_car_cards.dart';
import 'package:rentel_round/Screens/Car%20Screen/View%20Car/viewcartiles.dart';



import '../../../Models/car_model.dart';
import '../viewPCscreen.dart';
import '../viewRcscreen.dart';

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
        title: const Text(
          "Car Details",
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 20,
          ),
        ),
        backgroundColor: const Color(0xFF1E3A8A),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            CarImageTile(widget: widget),
            const SizedBox(height: 16),
            Column(
              children: [
                CarBrandName(widget: widget),
                CarCarName(widget: widget),
              ],
            ),

            const SizedBox(height: 20),
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
                    ViewCarCards.buildInfoRow("Vehicle No:", widget.car.vehicleNo),
                    ViewCarCards.buildInfoRow("Amount/Day:", widget.car.amtPerDay.toString()),
                    ViewCarCards.buildInfoRow("Cubic Capacity:", widget.car.cubicCapacity.toString()),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: ViewCarTiles().BlueTile("Seat Capacity:", widget.car.seatCapacity.toString()),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: ViewCarTiles().BlueTile("KM Driven:", widget.car.kmDriven.toString()),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: ViewCarCards.buildCardWithLabel(
                    label: "Transmission",
                    value: widget.car.carType == "M" ? "Manual" : "Automatic",
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: ViewCarCards.buildCardWithLabel(
                    label: "Fuel Type",
                    value: widget.car.fuelType,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      headingTile(heading: "Pollution Validity",),
                      const SizedBox(height: 8),
                      ViewCarTiles().viewDate(_dateTime),
                    ],
                  ),
                ),
              ],
            ),
            Container(
              child: widget.car.servicedDate == null?null :
              Column(
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        const Text("LAST SERVICED:"),
                        ViewCarTiles().viewDate(widget.car.servicedDate!),
                      ],
                    ),
                  ),
                ],
              )
              ,
            ),
            const SizedBox(height: 20),
            PCButton(widget: widget),
            const SizedBox(height: 10),
            RCButton(widget: widget),
          ],
        ),
      ),
    );
  }
}


