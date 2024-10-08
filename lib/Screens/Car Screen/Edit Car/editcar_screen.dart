import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:rentel_round/Models/car_model.dart';
import 'package:rentel_round/Services/car_services.dart';

import 'Widgets/image.dart';
import 'Widgets/numberFeilds.dart';

class EditCarScreen extends StatefulWidget {

  final Cars car;
  const EditCarScreen({super.key,required this.car});

  @override
  State<EditCarScreen> createState() => _EditCarScreenState();
}

class _EditCarScreenState extends State<EditCarScreen> {
  final GlobalKey<FormState> _key = GlobalKey();
 late TextEditingController carnameController = TextEditingController();
 late TextEditingController brandController = TextEditingController();
 late TextEditingController vehiclenoController = TextEditingController();
 late TextEditingController rcnoController = TextEditingController();
 late TextEditingController ccController = TextEditingController();
 late TextEditingController kmdrivenController = TextEditingController();
 late TextEditingController amountController = TextEditingController();
 late TextEditingController seatCapacityController = TextEditingController();
  XFile? carImage;
  XFile? rcImage;
  XFile? pcImage;
@override
  void initState() {
  carnameController = TextEditingController(text: widget.car.carName);
  brandController = TextEditingController(text: widget.car.brandName);
  vehiclenoController = TextEditingController(text: widget.car.vehicleNo);
  rcnoController = TextEditingController(text: widget.car.rcNo.toString());
  ccController = TextEditingController(text: widget.car.cubicCapacity.toString());
  kmdrivenController = TextEditingController(text: widget.car.kmDriven.toString());
  amountController = TextEditingController(text: widget.car.amtPerDay.toString());
  seatCapacityController = TextEditingController(text: widget.car.seatCapacity.toString());
  carImage = XFile(widget.car.carImage);
  rcImage = XFile(widget.car.rcImage);
  pcImage = XFile(widget.car.pcImage);
  dropDownValue = widget.car.carType;
  fuelDownValue = widget.car.fuelType;
  dateNow = widget.car.pollutionDate;



  // TODO: implement initState
    super.initState();
  }

  final ImagePicker _picker = ImagePicker();
  Future<void> pickCarImage() async {
    XFile? pickImage = await _picker.pickImage(source: ImageSource.gallery);
    setState(() {
      carImage = pickImage;
    });
  }

  Future<void> pickRcImage() async {
    XFile? pickImage = await _picker.pickImage(source: ImageSource.gallery);
    setState(() {
      rcImage = pickImage;
    });
  }

  Future<void> pickPcImage() async {
    XFile? pickImage = await _picker.pickImage(source: ImageSource.gallery);
    setState(() {
      pcImage = pickImage;
    });
  }

  String dropDownValue = "M";
  String fuelDownValue = "P";
  DateTime dateNow = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,

        title: const Text("EDIT CAR"),
        centerTitle: true,
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(20),
            child: Form(
              key: _key,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      EditCarImage(carImage: carImage),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ElevatedButton(
                            onPressed: () async {
                              await pickCarImage();
                            },
                            child: const Text(
                              "UPLOAD",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          Text(
                            "upload car photo here",
                            style: TextStyle(
                                fontFamily: "Roboto",
                                color: Colors.grey.shade500),
                          )
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    validator: (value){
                      if(value==null || value == ""){
                        return "please fill valid feild";
                      }
                      return null;
                    },       autovalidateMode: AutovalidateMode.onUserInteraction,
                    controller: carnameController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)),
                      hintStyle: TextStyle(
                        fontFamily: 'Roboto',
                      ),
                      hintText: "enter your car name",
                      label: Text(
                        "car name",
                        style: TextStyle(fontFamily: "Roboto"),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    validator: (value){
                      if(value==null || value == ""){
                        return "please fill valid feild";
                      }
                      return null;
                    },       autovalidateMode: AutovalidateMode.onUserInteraction,
                    controller: brandController,
                    decoration: InputDecoration(
                      hintStyle: const TextStyle(
                        fontFamily: 'Roboto',
                      ),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)),
                      hintText: "enter brand name",
                      label: const Text(
                        "brandname",
                        style: TextStyle(fontFamily: "Roboto"),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    validator: (value){
                      if(value==null || value == ""){
                        return "please fill valid feild";
                      }
                      return null;
                    },
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    controller: vehiclenoController,
                    decoration: InputDecoration(
                      hintStyle: const TextStyle(
                        fontFamily: 'Roboto',
                      ),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)),
                      hintText: "enter vehicle no",
                      label: const Text(
                        "vehicle no",
                        style: TextStyle(fontFamily: "Roboto"),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: 200,
                        child: TextFormField(
                          validator: (value){
                            if(value==null || value == ""){
                              return "please fill valid feild";
                            }
                            return null;
                          },  inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly
                        ],
                          keyboardType: TextInputType.number,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          controller: rcnoController,
                          decoration: InputDecoration(
                            hintStyle: const TextStyle(
                              fontFamily: 'Roboto',
                            ),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10)),
                            hintText: "enter RC no",
                            label: const Text(
                              "RC no",
                              style: TextStyle(fontFamily: "Roboto"),
                            ),
                          ),
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () async {
                          await pickRcImage();
                        },
                        child: const Text(
                          "UPLOAD RC",
                          style: TextStyle(color: Colors.white,
                          fontFamily: "jaro"
                          ),
                        ),
                      ),
                      Checkbox(
                          value: rcImage == null ? false : true,
                          onChanged: (value) {})
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const SizedBox(
                      width: double.infinity,
                      child: Text(
                        "Last date of pollution",
                        textAlign: TextAlign.start,
                      )),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                          width: 200,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(color: Colors.black45)),
                          child: Row(
                            children: [
                              CupertinoButton(
                                onPressed: () {
                                  showCupertinoModalPopup(
                                    context: context,
                                    builder: (context) => SizedBox(
                                      height: 250,
                                      child: CupertinoDatePicker(
                                        backgroundColor: Colors.white,
                                        onDateTimeChanged: (DateTime newValue) {
                                          setState(() {
                                            dateNow = newValue;
                                          });
                                        },
                                        mode: CupertinoDatePickerMode.date,
                                      ),
                                    ),
                                  );
                                },
                                child: Text(
                                  "${dateNow.day} - ${dateNow.month} - ${dateNow.year}",
                                  style: const TextStyle(
                                      fontSize: 20, color: Colors.black),
                                ),
                              ),
                              const Icon(Icons.date_range)
                            ],
                          )),
                      ElevatedButton(
                        onPressed: () async {
                          await pickPcImage();
                        },
                        child: const Text(
                          "UPLOAD PC",
                          style: TextStyle(color: Colors.white,
                          fontFamily: "jaro",
                          ),
                        ),
                      ),
                      Checkbox(
                          value: pcImage == null ? false : true,
                          onChanged: (value) {})
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InputFeilds(ccController: ccController,label: "CC",),
                      InputFeilds(ccController: kmdrivenController,label: "KM Driven"),
                      SizedBox(
                        width: 120,
                        child: DropdownButton<String>(
                          onChanged: (String? newValue) {
                            setState(() {
                              dropDownValue = newValue!;
                            });
                          },
                          items: const [
                            DropdownMenuItem<String>(
                              value: "M",
                              child: Text("Manual"),
                            ),
                            DropdownMenuItem<String>(
                              value: "A",
                              child: Text("Automatic"),
                            ),
                          ],
                          icon: const Icon(Icons.menu),
                          value: dropDownValue,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InputFeilds(ccController: amountController, label: "amount"),
                      InputFeilds(ccController: seatCapacityController, label: "seat capacity"),
                      SizedBox(
                          width: 120,
                          child: DropdownButton<String>(
                            focusColor: Colors.black,
                            onChanged: (String? fuelValue) {
                              setState(() {
                                fuelDownValue = fuelValue!;
                              });
                            },
                            items: const [
                              DropdownMenuItem<String>(
                                  value: "PETROL",
                                  child: Text("PETROL")),
                              DropdownMenuItem<String>(
                                  value: "DEISEL",
                                  child: Text("DEISEL")),
                              DropdownMenuItem<String>(
                                  value: "ELECTRIC",
                                  child: Text("ELECTRIC")),
                              DropdownMenuItem<String>(
                                  value: "CNG",
                                  child: Text("CNG")),
                            ],
                            icon: const Icon(Icons.menu),
                            value:
                            fuelDownValue, // Ensure fuelDownValue is correctly initialized
                          )),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          _showDialogue("Do you want to cancel edit?", "OK", (){
                            Navigator.pop(context);
                            Navigator.pop(context);
                          }, context);

                        },
                        child: const Text(
                          "CANCEL",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          if(_key.currentState!.validate()){
                            if(carImage == null){
                              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Upload a car image")));
                              return;
                            }
                            if(rcImage == null){
                              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Upload a RC image")));
                              return;
                            }
                            if(pcImage == null){
                              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Upload a PC image")));
                              return;
                            }
                            _showDialogue("Click ok to Add new car", "EDIT", _editCar, context);
                          }
                         },
                        child: const Text(
                          "SAVE",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _editCar() async {
    Cars editCar = Cars(
        carName: carnameController.text,
        vehicleNo: vehiclenoController.text,
        kmDriven: int.parse(kmdrivenController.text),
        seatCapacity: int.parse(seatCapacityController.text),
        cubicCapacity: int.parse(ccController.text),
        rcNo: int.parse(rcnoController.text),
        pollutionDate: dateNow,
        fuelType: fuelDownValue,
        amtPerDay: int.parse(amountController.text),
        carImage: carImage!.path,
        rcImage: rcImage!.path,
        pcImage: pcImage!.path,
        brandName: brandController.text,
        carType: dropDownValue,

    );
await CarServices().updateCar(widget.car.vehicleNo, editCar);
await CarServices().getCar();
    Navigator.popUntil(context, (route) => route.isFirst);
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        backgroundColor: Colors.blue,
        content: Text("Car Edited Succesfully!",
        style: TextStyle(
          color: Colors.white
        ),
        )));
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
