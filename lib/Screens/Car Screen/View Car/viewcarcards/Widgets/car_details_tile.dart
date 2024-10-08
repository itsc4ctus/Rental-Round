
import 'package:flutter/cupertino.dart';

import '../../viewcar_screen.dart';

class CarCarName extends StatelessWidget {
  const CarCarName({
    super.key,
    required this.widget,
  });

  final ViewcarScreen widget;

  @override
  Widget build(BuildContext context) {
    return Text(
      widget.car.carName,
      style: const TextStyle(
        fontSize: 22,
        fontWeight: FontWeight.w500,
        color: Color(0xFF60A5FA), // Light Blue
      ),
    );
  }
}

class CarBrandName extends StatelessWidget {
  const CarBrandName({
    super.key,
    required this.widget,
  });

  final ViewcarScreen widget;

  @override
  Widget build(BuildContext context) {
    return Text(
      widget.car.brandName,
      style: const TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 18,
        color: Color(0xFF1E3A8A), // Dark Blue
      ),
    );
  }
}