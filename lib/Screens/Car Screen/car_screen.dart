import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:rentel_round/Screens/Car%20Screen/Add%20Car/Screen/addcar_screen.dart';
import 'package:rentel_round/Screens/Car%20Screen/car_tile.dart';

import '../../Models/car_model.dart';
import '../../Services/car_services.dart';
import 'CarActions/car_actions.dart';

class CarScreen extends StatefulWidget {
  const CarScreen({super.key});

  @override
  State<CarScreen> createState() => _CarScreenState();
}

class _CarScreenState extends State<CarScreen> {
  String filterValue = "all";
  List<Cars> homeCar = [];
  List<Cars> availableCars = [];
  List<Cars> onHoldCars = [];
  int _selectedIndex = 0;

  @override
  void initState() {
    _loadCars();
    super.initState();
  }

  Future<void> _loadCars() async {
    List<Cars> car = await CarServices().getCar();
    List<Cars> avlbeCar = await CarServices().getAvailableCar();
    List<Cars> onHdCar = await CarServices().getOnHoldCar();
    for (var cars in car) {
      bool onHd = onHdCar.any((onHoldCar) => onHoldCar.vehicleNo == cars.vehicleNo);
      cars.availability = !onHd;
    }
    setState(() {
      homeCar = car;
      availableCars = avlbeCar;
      onHoldCars = onHdCar;
    });
  }

  @override
  Widget build(BuildContext context) {
    setState(() {
      _loadCars();
    });

    List<Cars> displayedCars = [];
    switch (_selectedIndex) {
      case 0:
        displayedCars = homeCar;
        break;
      case 1:
        displayedCars = availableCars;
        break;
      case 2:
        displayedCars = onHoldCars;
        break;
      default:
        displayedCars = homeCar;
    }

    return Scaffold(
      backgroundColor: Colors.blue.shade50,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.black,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AddcarScreen()),
          );
        },
        child: const Icon(Icons.add_circle_outline_rounded, color: Colors.white),
      ),
      body: Column(
        children: [
          Container(
            margin: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              border: Border.all(),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              children: [
                GNav(
                  onTabChange: (index) {
                    setState(() {
                      _selectedIndex = index;
                    });
                  },
                  gap: 8,
                  tabs: [
                    GButton(
                      icon: CupertinoIcons.infinite,
                      text: "All cars",
                      iconColor: Colors.blue,
                      rippleColor: Colors.blue.shade100,
                      iconActiveColor: Colors.blue,
                      textColor: Colors.blue,
                    ),
                    GButton(
                      icon: CupertinoIcons.checkmark_shield_fill,
                      text: "Available",
                      iconColor: Colors.green,
                      rippleColor: Colors.green.shade100,
                      iconActiveColor: Colors.green,
                      textColor: Colors.green,
                    ),
                    GButton(
                      icon: Icons.warning,
                      text: "On Hold",
                      iconColor: Colors.red,
                      rippleColor: Colors.red.shade100,
                      iconActiveColor: Colors.red,
                      textColor: Colors.red,
                    ),
                  ],
                ),
              ],
            ),
          ),
          Expanded(
            child: displayedCars.isEmpty
                ? const Center(child: Text("No cars to display"))
                : ListView.builder(
              itemCount: displayedCars.length,
              itemBuilder: (context, index) => CarTile(
                carName: displayedCars[index].carName,
                vehicleNo: displayedCars[index].vehicleNo,
                kmDriven: displayedCars[index].kmDriven,
                seatCapacity: displayedCars[index].seatCapacity,
                cubicCapacity: displayedCars[index].cubicCapacity,
                pollutionDate: displayedCars[index].pollutionDate,
                fuelType: displayedCars[index].fuelType,
                amtPerDay: displayedCars[index].amtPerDay,
                carImage: displayedCars[index].carImage,
                brandName: displayedCars[index].brandName,
                carType: displayedCars[index].carType,
                pcImage: displayedCars[index].pcImage,
                rcImage: displayedCars[index].rcImage,
                rcNo: displayedCars[index].rcNo,
                onDelete: () => CarActions.deleteCar(context, displayedCars[index].vehicleNo, onHoldCars),
                onEdit: () => CarActions.editCar(context, displayedCars[index], onHoldCars),
                viewCar: () => CarActions.viewCar(context, displayedCars[index]),
                availability: displayedCars == onHoldCars ? false : displayedCars[index].availability,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
