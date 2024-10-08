
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../viewcar_screen.dart';

class CarImageTile extends StatelessWidget {
  const CarImageTile({
    super.key,
    required this.widget,
  });

  final ViewcarScreen widget;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8),
      height: 160,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.blue.shade100),
        color: Colors.blue.shade50, // Light Gray Border
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            spreadRadius: 2,
            blurRadius: 8,
          ),
        ],
      ),
      child: Image(image: FileImage(File(widget.car.carImage))),
    );
  }
}
