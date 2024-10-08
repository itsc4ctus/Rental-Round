
import 'package:flutter/material.dart';

import '../../../viewPCscreen.dart';
import '../../viewcar_screen.dart';

class PCButton extends StatelessWidget {
  const PCButton({
    super.key,
    required this.widget,
  });

  final ViewcarScreen widget;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFF60A5FA), // Light Blue
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
      child: const Padding(
        padding: EdgeInsets.all(16.0),
        child: Text(
          "View Pollution Certificate",
          style: TextStyle(fontSize: 16, color: Colors.white),
        ),
      ),
    );
  }
}