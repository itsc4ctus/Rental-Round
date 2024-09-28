import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rentel_round/Services/car_services.dart';
import 'package:rentel_round/utils/car/car_tile.dart';
import 'package:rentel_round/utils/car/editcar_screen.dart';
import 'package:rentel_round/utils/car/View%20Car/viewcar_screen.dart';

import '../Models/car_model.dart';

class HomePage extends StatefulWidget {

   HomePage({ super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String filterValue = "all";

  TextEditingController searchConroller = TextEditingController();
  List<Cars> homeCar = [];
  List<Cars> onHoldCars = [];
  List<Cars> filteredCar = [];



  @override
  void initState()  {
   _loadCars();
   searchConroller.addListener(_filterSearch);
    // TODO: implement initState
    super.initState();
  }

  void _filterSearch(){
    String query = searchConroller.text.toLowerCase();
 filteredCar = homeCar.where((car){
   bool matchedQuery = car.carName.toLowerCase().contains(query);
   bool matchedValue = filterValue == "all"|| car.fuelType.toLowerCase() == filterValue;
   bool matchedTransmission = filterValue == "manual" || filterValue == "automatic" ? car.carType.toLowerCase()== filterValue:true;
  return matchedValue && (matchedQuery || matchedTransmission);
 }).toList();
  }



  @override
  void dispose(){
    searchConroller.dispose();
    super.dispose();
  }


  Future<void> _loadCars() async {
    List<Cars> car = await CarServices().getCar();
    List<Cars> avCar = await CarServices().getAvailableCar();
    List<Cars> onHCar = await CarServices().getOnHoldCar();
    for (var cars in car) {
      bool isOnHold = onHCar.any((onHoldCar) => onHoldCar.vehicleNo == cars.vehicleNo);
      cars.availability = !isOnHold;
    }
    setState(() {
      onHoldCars = onHCar;
      homeCar = car;
      filteredCar = homeCar;
    });
  }






Future<void> _deleteCars(String vehicleNo)async{
    bool carContains = await onHoldCars.any((car)=>car.vehicleNo == vehicleNo);
    if(carContains){
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: Colors.yellow.shade600,
          content: Text("Can't delete,Car is On Hold!",
            style: TextStyle(
                color: Colors.black
            ),
          )));
      Navigator.pop(context);
    }
    else{
      await CarServices().deleteCar(vehicleNo);
      await CarServices().deleteAvailableCar(vehicleNo);
      setState(() {
        _loadCars();
      });
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: Colors.red,
          content: Text("Car Deleted!",
            style: TextStyle(
                color: Colors.white
            ),
          )));
    }

}
Future<void> _editCar(Cars editCar)async{
    bool CarContain = await onHoldCars.any((car)=>car.vehicleNo == editCar.vehicleNo);

    if(CarContain){
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: Colors.yellow.shade600,
          content: Text("Can't edit,Car is On Hold!",
            style: TextStyle(
                color: Colors.black
            ),
          )));

    }
    else{
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

    return Scaffold(

        body:homeCar.isEmpty ? Container(
          child: Center(
            child: Text("Add Car to Display!"),
          ),
        ) :
        Column(
          children: [
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextField(
                        controller: searchConroller,
                        decoration: InputDecoration(
                          labelStyle: TextStyle(
                            fontFamily: "Roboto"
                          ),
                          labelText: "Search",
                          hintText: "Search...",
                          border: OutlineInputBorder(
                          ),
                          suffixIcon: Icon(CupertinoIcons.search_circle_fill),
                        ),
                      ),
                    ),
                  ),
                  Container(
                      child: DropdownButton<String>(
                        value: filterValue,
                          icon: Icon(Icons.menu),
                          items: [
                            DropdownMenuItem(child: Text("All Cars"),value: "all",),
                            DropdownMenuItem(child: Text("EV"),value: "ev",),
                            DropdownMenuItem(child: Text("CNG"),value: "cng",),
                            DropdownMenuItem(child: Text("Petrol"),value: "petrol",),
                            DropdownMenuItem(child: Text("Deisel"),value: "deisel",),
                            DropdownMenuItem(child: Text("Automatic"),value: "automatic",),
                            DropdownMenuItem(child: Text("Manual"),value: "manual",)
                          ], onChanged: (String? newValue){
                          setState(() {

                            setState(() {
                              filterValue = newValue!;
                              _filterSearch();
                            });
                          });
                      })),
                ],
              ),
            ),
            Expanded(
              child: Container(
                child:filteredCar.isEmpty?Center(child: Text("No cars to display"),) : ListView.builder(
                  itemCount: filteredCar.length,
                  itemBuilder: (context, index) => CarTile(
                      carName: filteredCar[index].carName,
                      vehicleNo:  filteredCar[index].vehicleNo,
                      kmDriven: filteredCar[index].kmDriven,
                      seatCapacity: filteredCar[index].seatCapacity,
                      cubicCapacity:filteredCar[index].rcNo,
                      pollutionDate:filteredCar[index].pollutionDate,
                      fuelType: filteredCar[index].fuelType,
                      amtPerDay: filteredCar[index].amtPerDay,
                      carImage: filteredCar[index].carImage,
                      brandName: filteredCar[index].brandName,
                      carType: filteredCar[index].carType,
                      pcImage:filteredCar[index].pcImage,
                      rcImage:filteredCar[index].rcImage,
                  rcNo:filteredCar[index].rcNo,
                    onDelete: ()=>_deleteCars(filteredCar[index].vehicleNo),
                    onEdit: ()=>_editCar(filteredCar[index]),
                    viewCar: ()=>_viewCar(filteredCar[index]),
availability:  filteredCar[index].availability,
                  ),

                ),
              ),
            ),
          ],
        ));
  }
}
