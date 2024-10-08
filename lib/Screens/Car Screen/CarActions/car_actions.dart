import 'package:flutter/material.dart';
import '../../../Models/car_model.dart';
import '../../../Services/car_services.dart';
import '../View Car/viewcar_screen.dart';
import '../Edit Car/editcar_screen.dart';

class CarActions {
  static Future<void> editCar(BuildContext context, Cars editCar, List<Cars> onHoldCars) async {
    bool carOnHold = onHoldCars.any((car) => car.vehicleNo == editCar.vehicleNo);
    if (carOnHold) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        backgroundColor: Colors.yellow.shade600,
        content: const Text(
          "Can't delete, Car is On Hold!",
          style: TextStyle(color: Colors.black),
        ),
      ));
    } else {
      await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => EditCarScreen(car: editCar),
        ),
      );
    }
  }

  static Future<void> deleteCar(BuildContext context, String vehicleNo, List<Cars> onHoldCars) async {
    bool carContains = onHoldCars.any((car) => car.vehicleNo == vehicleNo);
    if (carContains) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        backgroundColor: Colors.yellow.shade600,
        content: const Text(
          "Can't delete, Car is On Hold!",
          style: TextStyle(color: Colors.black),
        ),
      ));
    } else {
      await CarServices().deleteCar(vehicleNo);
      await CarServices().deleteAvailableCar(vehicleNo);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
         backgroundColor: Colors.red,
          content: Text("Car deleted succesfully!")));
    }
    Navigator.pop(context);
  }

  static Future<void> viewCar(BuildContext context, Cars car) async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ViewcarScreen(car: car),
      ),
    );
  }
}
