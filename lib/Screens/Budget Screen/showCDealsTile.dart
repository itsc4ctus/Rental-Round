import 'dart:io';

import 'package:flutter/material.dart';
import 'package:rentel_round/Screens/Status/viewCompletedStatus.dart';

import '../../Models/car_model.dart';
import '../../Models/status_model.dart';

class ShowCDealsTile extends StatefulWidget {
  final String cName;
  final String cId;
  final DateTime startDate;
  final DateTime endDate;
  final Cars selectedCar;
  final int advAmount;
  final int totalAmount;
  final int extraAmount;
  final String proofImage;
  final VoidCallback ondelete;
  final status completedCustomer;
  final int amountRecieved;

  const ShowCDealsTile({
    required this.cName,
    required this.cId,
    required this.startDate,
    required this.endDate,
    required this.selectedCar,
    required this.advAmount,
    required this.extraAmount,
    required this.proofImage,
    required this.totalAmount,
    required this.completedCustomer,
    required this.ondelete,
    required this.amountRecieved,
    super.key,
  });

  @override
  State<ShowCDealsTile> createState() => _ShowCDealsTileState();
}

class _ShowCDealsTileState extends State<ShowCDealsTile> {
  List<String> month = ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"];

  String monthToWords(int monthNumber) {
    return month[monthNumber - 1];
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => CompletedCustomer(customer: widget.completedCustomer),
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
        child: Card(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
          elevation: 4.0,
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.white, Colors.grey.shade200],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [

                Container(
                  height: 80,
                  width: 80,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    image: DecorationImage(
                      image: FileImage(File(widget.proofImage)),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                // Customer Info
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          widget.cName,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          "Returned Date:\n ${widget.endDate.day} ${monthToWords(widget.endDate.month)} ${widget.endDate.year}",
                          style: const TextStyle(
                            fontSize: 14,
                            color: Colors.black54,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                // Delete Icon Button
                SizedBox(
                  height: 60,
                  width: 100,

                  child: Column(
                    children: [
                      const Text("Amount "),
                      Text("₹${widget.amountRecieved.toString()}"),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
