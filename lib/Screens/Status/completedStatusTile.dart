import 'dart:io';

import 'package:flutter/material.dart';
import 'package:rentel_round/Screens/Status/viewCompletedStatus.dart';

import '../../Models/car_model.dart';
import '../../Models/status_model.dart';

class StatusTileCompleted extends StatefulWidget {
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

  const StatusTileCompleted({
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
    super.key,
  });

  @override
  State<StatusTileCompleted> createState() => _StatusTileCompletedState();
}

class _StatusTileCompletedState extends State<StatusTileCompleted> {
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
                IconButton(
                  onPressed: widget.ondelete,
                  icon: const Icon(
                    Icons.delete_rounded,
                    color: Colors.redAccent,
                  ),
                  tooltip: 'Delete',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
