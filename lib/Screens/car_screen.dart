import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:rentel_round/utils/car/addcar_screen.dart';

import '../Models/car_model.dart';
import '../Services/car_services.dart';
import '../utils/car/car_tile.dart';
import '../utils/car/editcar_screen.dart';
import '../utils/car/View Car/viewcar_screen.dart';

class CarScreen extends StatefulWidget {

 const CarScreen({ super.key});

  @override
  State<CarScreen> createState() => _CarScreenState();
}

class _CarScreenState extends State<CarScreen> {

String filterValue = "all";
List<Cars> homeCar=[];
List<Cars> availableCars=[];
List<Cars> onHoldCars=[];
int _selectedIndex = 0;
bool? availability;
  @override
  void initState()  {

    _loadCars();
    // TODO: implement initState
    super.initState();
  }
  Future<void> _loadCars()async{
    List<Cars> car = await CarServices().getCar();
    List<Cars> avlbeCar = await CarServices().getAvailableCar();
    List<Cars> onHdCar = await CarServices().getOnHoldCar();
    for(var cars in car){
      bool onHd = onHdCar.any((onHoldCar)=>onHoldCar.vehicleNo == cars.vehicleNo);
      cars.availability = !onHd;
    }
    setState(() {
      homeCar = car;
      availableCars = avlbeCar;
      onHoldCars = onHdCar;
    });

  }

  Future<void> _deleteCars(String vehicleNo)async{

    bool? carContains = onHoldCars.any((car)=>car.vehicleNo == vehicleNo);


    if(carContains){
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: Colors.yellow.shade600,
          content: const Text("Can't edit,Car is On Hold!",
          style: TextStyle(
            color: Colors.black
          ),
          )));
      Navigator.pop(context);
    }else{
    await CarServices().deleteCar(vehicleNo);
    await CarServices().deleteAvailableCar(vehicleNo);
    setState(() {
      _loadCars();
    });
    Navigator.pop(context);
  }}
  Future<void> _editCar(Cars editCar)async{
    bool carOnHold = onHoldCars.any((car)=>car.vehicleNo == editCar.vehicleNo);
    if(carOnHold){
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: Colors.yellow.shade600,
          content: const Text("Can't delete,Car is On Hold!",
            style: TextStyle(
                color: Colors.black
            ),
          )));

    }else{
      await Navigator.push(context, MaterialPageRoute(builder: (context) => EditCarScreen(car: editCar,),));
      setState(() {
        _loadCars();
      });
    }




  }
  Future<void> _viewCar(Cars car)async{
    await Navigator.push(context, MaterialPageRoute(builder: (context) => ViewcarScreen(car: car),));
  }


  @override
  Widget build(BuildContext context) {
    setState(() {
      _loadCars();
    });
List<Cars> displayedCars = [];
switch(_selectedIndex){
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
        onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (context) => const AddcarScreen(),));
        },
        child: const Icon(Icons.add_circle_outline_rounded,color: Colors.white,),
      ),
      body: Column(
        children: [
          Container(
            margin: const EdgeInsets.all(10),
            decoration: BoxDecoration(
                border: Border.all(),
              borderRadius: BorderRadius.circular(10)
            ),
      child: Column(
        children: [
          GNav(
            onTabChange: (index){
setState(() {
  _selectedIndex = index;
});
            },
              gap: 8,
              tabs: [
            GButton(icon: CupertinoIcons.infinite,text: "All cars",iconColor: Colors.blue,rippleColor: Colors.blue.shade100,iconActiveColor: Colors.blue,textColor: Colors.blue,),
            GButton(icon: CupertinoIcons.checkmark_shield_fill,text: "Available",iconColor: Colors.green,rippleColor: Colors.green.shade100,iconActiveColor: Colors.green,textColor: Colors.green,),
            GButton(icon:Icons.warning,text: "On Hold", iconColor: Colors.red,rippleColor: Colors.red.shade100,iconActiveColor: Colors.red,textColor: Colors.red,),
          ]
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
                onDelete: () => _deleteCars(displayedCars[index].vehicleNo),
                onEdit: () => _editCar(displayedCars[index]),
                viewCar: () => _viewCar(displayedCars[index]),
                availability:displayedCars == onHoldCars ? false: displayedCars[index].availability,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

