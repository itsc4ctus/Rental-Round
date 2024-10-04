import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rentel_round/Screens/Car%20Screen/Car%20Service/renew_pollution.dart';



import '../../../Models/car_model.dart';

class CarToService extends StatefulWidget {
  String image;
  String carName;
  String brandName;
  String vNo;
  DateTime pollutionDate;
  VoidCallback onService;
  Cars car;
  CarToService({required this.brandName,required this.carName,required this.image,required this.vNo,required this.pollutionDate,required this.onService ,required this.car,super.key,});

  @override
  State<CarToService> createState() => _CarToServiceState();
}

class _CarToServiceState extends State<CarToService> {
  @override
  void initState() {
    pollutionDate = widget.pollutionDate;
    // TODO: implement initState
    super.initState();
  }
 late DateTime pollutionDate;
  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      elevation: 3,
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
        ),
        margin: const EdgeInsets.symmetric(vertical: 8),
        height: 140,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              height: 100,
              width: 100,
              child: Image(image: FileImage(File(widget.image)),),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(widget.brandName),
                Text(widget.carName),
                Text(widget.vNo),
                Container(
                  child: Column(
                    children: [
                      const Text("Last Date of PC"),
                      Text("${widget.pollutionDate.day} - ${widget.pollutionDate.month} - ${widget.pollutionDate.year}",
                      style: TextStyle(
                        color:widget.pollutionDate.isAfter(DateTime.now())?Colors.green:Colors.red  ,
                      ),
                      ),
                    ],
                  ),
                )
              ],
            ),
            Column(
              children: [
                ElevatedButton(onPressed: _showServiceList, child: const Text("SERVICE")),
                ElevatedButton(onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => RenewPollution(car: widget.car,pollutionDate: widget.pollutionDate,),));
                }, child: const Text("RENEW"))
              ],
            ),
          ],
        ),
      ),
    );
  }
  Future<void> _showServiceList() async{
    return showDialog(context: context, builder: (context) => AlertDialog(
      title: const Text("are you giving your car to service?"),
      content: Container(
        child: const Column(
          mainAxisSize: MainAxisSize.min,
          children: [

          ],
        ),
      ),
      actions: [
        ElevatedButton(onPressed: (){
          Navigator.pop(context);
        }, child: const Text("CANCEL")),
        ElevatedButton(onPressed: widget.onService, child: const Text("OK")),
      ],
    ));
  }
  Future<void> _renewPollution()async{

    return showDialog(context: context, builder: (context) => AlertDialog(
      title: const Text("PICK THE RENEWEL DATE"),
      content: Container(
        child: Column(
          children: [
            CupertinoButton(child: Text("${pollutionDate.day} - ${pollutionDate.month} - ${pollutionDate.year}"), onPressed: (){
               showCupertinoModalPopup(context: context, builder: (context) => SizedBox(
                 height: 250,
                 child: CupertinoDatePicker(
                   minimumDate: DateTime.now(),
                   mode: CupertinoDatePickerMode.date,
                     backgroundColor: Colors.white,
                     onDateTimeChanged: (DateTime newValue){
                   setState(() {
                     pollutionDate = newValue;
                   });
                 }),
               ),);
            })
          ],
        ),
      ),
    ));
  }




}
