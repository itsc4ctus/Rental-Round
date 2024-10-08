
import 'package:flutter/material.dart';

import '../../../viewRcscreen.dart';
import '../../viewcar_screen.dart';

class RCButton extends StatelessWidget {
  const RCButton({
    super.key,
    required this.widget,
  });

  final ViewcarScreen widget;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFF1E3A8A), // Dark Blue
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
          style: const TextStyle(fontSize: 16, color: Colors.white),
        ),
      ),
    );
  }
}
