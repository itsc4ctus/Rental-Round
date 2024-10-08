import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:rentel_round/Screens/Car%20Screen/Car%20Service/CarOnservice.dart';
import 'package:rentel_round/Screens/Car%20Screen/Car%20Service/CarToService.dart';
import 'package:rentel_round/Services/car_services.dart';

import '../../../Models/car_model.dart';

class CarServiceScreen extends StatefulWidget {
  const CarServiceScreen({super.key});

  @override
  State<CarServiceScreen> createState() => _CarServiceScreenState();
}
class _CarServiceScreenState extends State<CarServiceScreen> {

  @override
  void initState() {
    _loadAvlbecars();
    // TODO: implement initState
    super.initState();
  }

  Future<void> _loadAvlbecars()async{
   ServicableCars =  await CarServices().getAvailableCar();
   setState(() {
   });
  }
  Future<void> _loadInServicecars()async{
    ServicableCars = await CarServices().getServicingCars();
    setState(() {

    });
  }

  Future<void>_takeDown(Cars car)async{
    await CarServices().addAvailableCar(car);
    await CarServices().deleteOnHoldCar(car.vehicleNo);
    await CarServices().deleteServicedCar(car.vehicleNo);
    await CarServices().getServicingCars();
    await CarServices().addExpSerCar(car);
    await CarServices().getExpSerCar();
    setState(() {

    });
  }

  List<Cars> ServicableCars=[];



  int _selectedIndex =0;
Future<void> service(Cars car)async{
  await CarServices().updateCar(car.vehicleNo, car);
  await CarServices().addServiceCars(car);
  await CarServices().addOnHoldCar(car);
  await CarServices().deleteAvailableCar(car.vehicleNo);
  await CarServices().getAvailableCar();
  setState(() {

  });
}
  @override
  Widget build(BuildContext context) {
    switch(_selectedIndex){
      case 0:
      _loadAvlbecars();
      break;

      case 1:
      _loadInServicecars();
      break;

      default:
      _loadAvlbecars();
    }


    List options = [
      Container(
        child:ServicableCars.isEmpty?Center(child: Text("No cars to display!"),) : ListView.builder(
          itemCount: ServicableCars.length,
          itemBuilder: (context, index) => CarToService(image: ServicableCars[index].carImage,brandName: ServicableCars[index].brandName,carName: ServicableCars[index].carName,vNo: ServicableCars[index].vehicleNo,pollutionDate: ServicableCars[index].pollutionDate,onService: () {
            service(ServicableCars[index]);
            Navigator.pop(context);
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Car added for service!")));
          },car: ServicableCars[index],),),
      ),
      Container(
        child:ServicableCars.isEmpty?Center(child: Text("No cars are currently on service!"),) : ListView.builder(
            itemCount: ServicableCars.length,
            itemBuilder: (context, index) => CarOnService(image: ServicableCars[index].carImage,carName:ServicableCars[index].carName,vehicleNo: ServicableCars[index].vehicleNo ,
            car: ServicableCars[index],
            )),
      ),
    ];
    return Scaffold(
      appBar: AppBar(
        title: const Text("Car Service"),
      ),
      body: Container(
child: Padding(
  padding: const EdgeInsets.all(12.0),
  child: Column(
    children: [
      Container(
        padding: const EdgeInsets.all(6),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.blue.shade900),
          borderRadius: BorderRadius.circular(10),
        ),
        child: GNav(
          onTabChange: (value){
            setState(() {
              _selectedIndex = value;
            });

          },
          color: Colors.grey,
            selectedIndex: _selectedIndex,
            gap: 8,
            activeColor: Colors.blue.shade900,
          rippleColor: Colors.blue.shade50,
            hoverColor: Colors.blue.shade100,
            tabBackgroundColor: Colors.blue.shade100,
            tabs: const [
          GButton(icon: Icons.car_rental,text: "Service Car",),
          GButton(icon: Icons.car_crash,text: "On Service",)
        ]),
      ),
      Expanded(
        child: Container(
          child: options[_selectedIndex],
        ),
      ),
    ],
  ),
),
      ),
      
    );
  }
}
