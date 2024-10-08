import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:rentel_round/Models/car_model.dart';
import 'package:rentel_round/Screens/Car%20Screen/Add%20Car/Feilds/addCarFeilds.dart';
import 'package:rentel_round/Services/car_services.dart';

import '../Feilds/carImageWIdget.dart';

class AddcarScreen extends StatefulWidget {
  const AddcarScreen({super.key});

  @override
  State<AddcarScreen> createState() => _AddcarScreenState();
}

class _AddcarScreenState extends State<AddcarScreen> {
  final GlobalKey<FormState> _key = GlobalKey();
  TextEditingController carnameController = TextEditingController();
  TextEditingController brandController = TextEditingController();
  TextEditingController vehiclenoController = TextEditingController();
  TextEditingController rcnoController = TextEditingController();
  TextEditingController ccController = TextEditingController();
  TextEditingController kmdrivenController = TextEditingController();
  TextEditingController amountController = TextEditingController();
  TextEditingController seatCapacityController = TextEditingController();
  XFile? carImage;
  XFile? rcImage;
  XFile? pcImage;

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
  Future<void> addCar() async {
    Cars newCar = Cars(
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
    await CarServices().addCar(
      newCar,
    );
    await CarServices().addAvailableCar(newCar);
    await CarServices().getCar();
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        backgroundColor: Colors.green,
        content: Text(
          "New Car Added!",
          style: TextStyle(color: Colors.white),
        )));
    Navigator.popUntil(context, (route) => route.isFirst);
  }
  void _showDialogue(String messege, String btnName, VoidCallback btnfn,
      BuildContext context) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(messege),
            actions: [
              ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text("CANCEL")),
              ElevatedButton(onPressed: btnfn, child: Text(btnName))
            ],
          );
        });
  }
  String dropDownValue = "M";
  String fuelDownValue = "PETROL";
  DateTime dateNow = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          actions: [
            IconButton(
                onPressed: () {
                  _showDialogue("Do you want to go back without adding?", "OK",
                      () {
                    Navigator.popUntil(context, (route) => route.isFirst);
                  }, context);
                },
                icon: const Icon(
                  Icons.close_rounded,
                  color: Colors.white,
                ))
          ],
          title: const Text("ADD NEW CAR"),
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
                        carImageWidget(carImage: carImage),
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
                    AddCarFeilds().addCarFeilds("please fill valid feild",
                        "car name", "enter your car name", carnameController),
                    const SizedBox(
                      height: 10,
                    ),
                    AddCarFeilds().addCarFeilds("please fill valid feild",
                        "brandname", "enter brand name", brandController),
                    const SizedBox(
                      height: 10,
                    ),
                    AddCarFeilds().addCarFeilds("please fill valid feild",
                        "vehicle no", "enter vehicle no", vehiclenoController),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: 200,
                          child: AddCarFeilds().addCarFeilds(
                              "please fill valid feild",
                              "RC no",
                              "enter RC no",
                              rcnoController,
                              TextInputType.number,
                              [FilteringTextInputFormatter.digitsOnly]),
                        ),
                        ElevatedButton(
                          onPressed: () async {
                            await pickRcImage();
                          },
                          child: const Text(
                            "UPLOAD RC",
                            style: TextStyle(
                                color: Colors.white, fontFamily: "jaro"),
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
                                          onDateTimeChanged:
                                              (DateTime newValue) {
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
                            style: TextStyle(
                                color: Colors.white, fontFamily: "jaro"),
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
                        SizedBox(
                          width: 110,
                          child: AddCarFeilds().addCarFeildsTwo(
                              "please fill valid feild",
                              "CC",
                              ccController,
                              TextInputType.number,
                              [FilteringTextInputFormatter.digitsOnly]),
                        ),
                        SizedBox(
                          width: 110,
                          child:
                          AddCarFeilds().addCarFeildsTwo(
                              "please fill valid feild",
                              "KM Driven",
                              kmdrivenController,
                              TextInputType.number,
                              [FilteringTextInputFormatter.digitsOnly]),
                        ),
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
                        SizedBox(
                          width: 110,
                          child:
                          AddCarFeilds().addCarFeildsTwo(
                              "please fill valid feild",
                              "AMOUNT",
                              amountController,
                              TextInputType.number,
                              [FilteringTextInputFormatter.digitsOnly]),

                        ),
                        SizedBox(
                          width: 110,
                          child:
                          AddCarFeilds().addCarFeildsTwo(
                              "please fill valid feild",
                              "seat capacity",
                              seatCapacityController,
                              TextInputType.number,
                              [FilteringTextInputFormatter.digitsOnly],
                          ),

                        ),
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
                                    value: "PETROL", child: Text("PETROL")),
                                DropdownMenuItem<String>(
                                    value: "DEISEL", child: Text("DEISEL")),
                                DropdownMenuItem<String>(
                                    value: "ELECTRIC", child: Text("ELECTRIC")),
                                DropdownMenuItem<String>(
                                    value: "CNG", child: Text("CNG")),
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
                            _showDialogue("Do you want to cancel?", "OK", () {
                              Navigator.popUntil(
                                  context, (route) => route.isFirst);
                            }, context);
                          },
                          child: const Text(
                            "CANCEL",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            if (_key.currentState!.validate()) {
                              if (carImage == null) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        content: Text("Upload a car image")));
                                return;
                              }
                              if (rcImage == null) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        content: Text("Upload a RC image")));
                                return;
                              }
                              if (pcImage == null) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        content: Text("Upload a PC image")));
                                return;
                              }
                              int seatCp = int.parse(seatCapacityController.text);
                              if (seatCp > 6) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        content: Text("Enter seat below 6!")));
                                return;
                              }

                              _showDialogue("Click ok to Add new car", "Add",
                                  addCar, context);
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
      ),
    );
  }
}
