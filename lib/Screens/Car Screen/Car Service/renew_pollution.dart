import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:rentel_round/Screens/Car%20Screen/Car%20Service/Car_Service.dart';

import 'package:rentel_round/Services/car_services.dart';


import '../../../Models/car_model.dart';

class RenewPollution extends StatefulWidget {
Cars car;
  DateTime pollutionDate;
   RenewPollution({required this.car, required this.pollutionDate, super.key});

  @override
  State<RenewPollution> createState() => _RenewPollutionState();
}

class _RenewPollutionState extends State<RenewPollution> {
  final ImagePicker _imagePicker = ImagePicker();


  Future<void> pickImage()async{
    XFile? pickedimage = await _imagePicker.pickImage(source: ImageSource.gallery);
    image = pickedimage;
    setState(() {});
  }
  XFile? image;
  late DateTime pollutionDate;

  Future<void> renew(DateTime NewpollutionDate,Cars car) async{
    car.pollutionDate = NewpollutionDate;
    car.pcImage = image!.path;
    await CarServices().updateCar(car.vehicleNo, car);
    await CarServices().getAvailableCar();
    await CarServices().getCar();
    ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            backgroundColor: Colors.green,
            content: Text("Pollution renewd!")));
    setState(() {

    });
  }
  @override
  void initState() {
    pollutionDate = widget.pollutionDate;
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("RENEW POLLUTION"),
      ),
      body: SizedBox(
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            SizedBox(
              height: 250,
              width: 250,
              child:image == null?Container(
                  height: 250,
                  width: 250,
                
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.pink.shade100,
                  ),
                  child: const Center(child: Icon(Icons.image)))  : Image(image: FileImage(File(image!.path)),),
            ),

            ElevatedButton(onPressed: (){
              pickImage();

            }, child: const Text("UPLOAD RENEWD CERTIFICATE")),

            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                border: Border.all(),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  const Text("POLLUTION DATE",
                  style: TextStyle(
                    fontSize: 16,
                  ),
                  ),

                  Text("${pollutionDate.day} - ${pollutionDate.month} - ${pollutionDate.year}",
                      style: const TextStyle(
                        fontSize: 16,
                      )
                  )
                ],
              ),
            ),

            ElevatedButton(onPressed: (){
              showCupertinoModalPopup(context: context, builder: (context) => SizedBox(
                height: 250,
                child: CupertinoDatePicker(
                  backgroundColor: Colors.white,
                  minimumDate: DateTime.now(),
                  mode: CupertinoDatePickerMode.date,
                  onDateTimeChanged: (DateTime value){
                  setState(() {
                    pollutionDate = value;
                  });
                },),
              ),);
            }, child: const Text("UPDATE DATE")),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(onPressed: (){
                  _showDialogue("Do you want to cancel process?", "OK", (){
                    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => const CarServiceScreen(),), (route) => route.isFirst,);
                  }, context);

                }, child: const Text("CANCEL")),
                ElevatedButton(onPressed: (){
                  if(image == null){
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Upload pollution certificate!")));
                  }
                  else{
                    _showDialogue("Confirm Renew.", "CONFIRM", (){
                      renew(pollutionDate, widget.car);
                      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => const CarServiceScreen(),), (route) => route.isFirst,);
                    }, context);
                  }


                }, child: const Text("RENEW")),
              ],
            ),
          ],
        ),
      ),
    );
  }
  void _showDialogue(String messege,String btnName,VoidCallback btnfn,BuildContext context){
    showDialog(context: context,builder: (context) {
      return AlertDialog(
        title: Text(messege),
        actions: [
          ElevatedButton(onPressed: (){
            Navigator.pop(context);
          }, child: const Text("CANCEL")),
          ElevatedButton(onPressed: btnfn, child: Text(btnName))
        ],
      );
    });
  }
}
