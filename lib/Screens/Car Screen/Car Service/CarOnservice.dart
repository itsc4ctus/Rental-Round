import 'package:flutter/material.dart';
import 'dart:io';

import '../../../Models/car_model.dart';
import '../../../Services/car_services.dart';

class CarOnService extends StatefulWidget {
  String image;
  String carName;
  String vehicleNo;
  Cars car;
 CarOnService({required this.image,required this.carName,required this.vehicleNo,required this.car, super.key});

  @override
  State<CarOnService> createState() => _CarOnServiceState();
}

class _CarOnServiceState extends State<CarOnService> {
  Future<void>_takeDown(Cars car,int serviceCharge)async{
    await CarServices().addAvailableCar(car);
    await CarServices().deleteOnHoldCar(car.vehicleNo);
    await CarServices().deleteServicedCar(car.vehicleNo);
    await CarServices().getServicingCars();
    car.servicedDate = DateTime.now();
    await CarServices().updateCar(car.vehicleNo, car);
    car.serviceAmount = serviceCharge;
    await CarServices().addExpSerCar(car);
    await CarServices().getExpSerCar();
    setState(() {

    });
  }
  TextEditingController serviceChargeController = TextEditingController();
  final GlobalKey<FormState> _key = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      color: Colors.white,

      child: Container(
        padding: const EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              height: 100,
              width: 100,
              child: Image(image: FileImage(File(widget.image)),),
            ),
Column(
  children: [
    Text(widget.carName),
    Text(widget.vehicleNo),
  ],
),
            ElevatedButton(onPressed: (){
              showDialog(context: context, builder: (context) => AlertDialog(
                content: Form(
                  key: _key,
                  child: TextFormField(
                    keyboardType: TextInputType.number,
                    controller: serviceChargeController,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (value){
                      if(value!.isEmpty){
                        return "Enter Service charge";
                      }
                      return null;
                    },
                    decoration: const InputDecoration(
                      label: Text("AMOUNT PAID"),
                    ),
                  ),
                ),
              actions: [
                ElevatedButton(onPressed: (){Navigator.pop(context);}, child: const Text("CANCEL")),
                ElevatedButton(onPressed:(){
                  if(_key.currentState!.validate()){
                    _takeDown(widget.car,int.parse(serviceChargeController.text));
                    Navigator.pop(context);
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      backgroundColor: Colors.green,
                        content: Text("Succesfully completed!")
                    ));
                  }
                }, child: const Text("OK"))
              ],

              ),);
            }, child: const Text("TAKE BACK"))
          ],
        ),
      ),
    );
  }

  showError() {
    return ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Enter Service Charge")));
  }

}
