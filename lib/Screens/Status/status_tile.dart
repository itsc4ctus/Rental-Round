import 'dart:io';

import 'package:flutter/material.dart';
import 'package:rentel_round/Screens/Status/showDeal.dart';
import 'package:rentel_round/Services/car_services.dart';

import '../../Models/car_model.dart';
import '../../Models/status_model.dart';
import '../../Services/status_services.dart';

class StatusTile extends StatefulWidget {
  final String cName;
  final String cId;
  final DateTime startDate;
  final DateTime endDate;
  final Cars selectedCar;
  final int advAmount;
  final int totalAmount;
  final int extraAmount;
  final String proofImage;
  final VoidCallback editStatus;
  final status Status;

  const StatusTile({
    required this.cName,
    required this.cId,
    required this.startDate,
    required this.endDate,
    required this.selectedCar,
    required this.advAmount,
    required this.extraAmount,
    required this.proofImage,
    required this.totalAmount,
    required this.editStatus,
    required this.Status,
    super.key
  });

  @override
  State<StatusTile> createState() => _StatusTileState();
}

class _StatusTileState extends State<StatusTile> {
  bool isCompleted = false;

  Future<void> CarToAvailable() async {
    await CarServices().addAvailableCar(widget.selectedCar);
    await CarServices().deleteOnHoldCar(widget.selectedCar.vehicleNo);
  }

  Future<void> StatusToCompleted() async {}

  List<String> month = ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"];

  String monthToWords(int monthNumber) {
    return month[monthNumber - 1];
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: isCompleted ? null : widget.editStatus,
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
              mainAxisAlignment: MainAxisAlignment.start,
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
                const SizedBox(width: 16),

                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Customer Name
                      Text(
                        widget.cName,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                      const SizedBox(height: 8),
                      // Return Date
                      Text(
                        "Return Date:\n ${widget.endDate.day} ${monthToWords(widget.endDate.month)} ${widget.endDate.year}",
                        style: TextStyle(
                          fontSize: 14,
                          color: widget.endDate.isBefore(DateTime.now()) ? Colors.red : Colors.green,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),

                ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: isCompleted ? Colors.grey : Colors.blue,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  ),
                  icon: const Icon(Icons.handshake_rounded),
                  label: const Text(
                    "Deal",
                    style: TextStyle(fontSize: 14),
                  ),
                  onPressed: isCompleted
                      ? null
                      : () async {
                    final result = await showDialog(
                      context: context,
                      builder: (context) => ShowDeal(
                        carAmount: widget.selectedCar.amtPerDay,
                        advAmount: widget.advAmount,
                        extraAmount: widget.extraAmount,
                        kmDriven: widget.selectedCar.kmDriven,
                        Status: widget.Status,
                        selectedCar: widget.selectedCar,
                      ),
                    );
                    if (result == true) {
                      await StatusServices().getStatus();
                      setState(() {
                        isCompleted = true;
                      });
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
