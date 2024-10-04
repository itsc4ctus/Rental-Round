import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:rentel_round/Models/car_model.dart';
import 'package:rentel_round/Screens/Customer/bottomsheetcar_tile.dart';
import 'package:rentel_round/Screens/Customer/customerFeilds.dart';
import 'package:rentel_round/Services/car_services.dart';
import 'package:rentel_round/Services/status_services.dart';

import '../../Models/status_model.dart';

class AddScreen extends StatefulWidget {
  final Function(int) goToStatus;
  const AddScreen({required this.goToStatus, super.key});

  @override
  State<AddScreen> createState() => _AddScreenState();
}

class _AddScreenState extends State<AddScreen> {
  DateTime dateNow = DateTime.now();
  DateTime lastdateTime = DateTime.now();

  int? finalAmount;
  List<Cars> listCar = [];
  Cars? selectedCar;
  int? noOfDays;
  int? total=0;
  TextEditingController cnameController = TextEditingController();
  TextEditingController cidController = TextEditingController();
  TextEditingController endDateController = TextEditingController();
  TextEditingController noOfDaysController = TextEditingController();
  TextEditingController currentKmController = TextEditingController();
  TextEditingController amountController = TextEditingController();
  TextEditingController extraAmtController = TextEditingController();
  final GlobalKey<FormState> _key = GlobalKey();
  CustomerFeilds customerFields = CustomerFeilds();
  ImagePicker picker = ImagePicker();
  XFile? proofImg;

  @override
  void initState() {
    _loadCars();
    amountController.addListener(_updateAmount);
    super.initState();
  }

  @override
  void dispose() {
    cidController.dispose();
    cnameController.dispose();
    currentKmController.dispose();
    amountController.removeListener(_updateAmount);
    endDateController.dispose();
    extraAmtController.dispose();
    // TODO: implement dispose
    super.dispose();
  }

void _clearFeilds(){
      extraAmtController.text.isEmpty;
      cidController.clear();
      cnameController.clear();
      currentKmController.clear();
      amountController.clear();
      endDateController.clear();
      amountController.clear();
      selectedCar = null;
      proofImg = null;
      lastdateTime = DateTime.now();
      _key.currentState!.reset();

setState(() {

});
}
  void _loadCars() async {
    List<Cars> car = await CarServices().getAvailableCar();
    setState(() {
      listCar = car;
    });
  }
  void _updateAmount() {
    setState(() {});
  }

  void _addStatus(status status) async {
    await StatusServices().addStatus(status);
  }
  void _getStatus() async {
    await StatusServices().getStatus();
  }

  void _pickImage() async {
    final XFile? pickedImage =
        await picker.pickImage(source: ImageSource.gallery);
    setState(() {
      proofImg = pickedImage;
    });
  }

  @override
  Widget build(BuildContext context) {

    Duration duration = lastdateTime.difference(dateNow);
    int noOfDays = duration.inDays+1;
    return GestureDetector(
      onTap: (){
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        backgroundColor: Colors.white,
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
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Container(
                            height: 130,
                            width: 130,
                            color: Colors.pink.shade50,
                            child: proofImg == null
                                ? const Center(
                                    child: Icon(
                                    Icons.image,
                                    size: 50,
                                    color: Colors.grey,
                                  ))
                                : Image(
                                    fit: BoxFit.cover,
                                    image: FileImage(File(proofImg!.path))),
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ElevatedButton(
                              onPressed: () {
                                _pickImage();
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
                              "upload proof photo here",
                              style: TextStyle(
                                  fontFamily: "Roboto",
                                  color: Colors.grey.shade500),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    customerFields.fields(
                      (value) {
                        if (cnameController.text.isEmpty) {
                          return "Enter a Customer name";
                        }
                        return null;
                      },
                      "customer name",
                      "enter customer name",
                      cnameController,
                    ),
                    const SizedBox(height: 10),
                    customerFields.fields(
                      (value) {
                        if (cidController.text.isEmpty) {
                          return "Enter a Customer ID";
                        }
                        return null;
                      },
                      "customer ID",
                      "enter customer ID",
                      cidController,
                    ),
                    const SizedBox(height: 10),
                    customerFields.fields(
                      (value) {
                        if (amountController.text.isEmpty) {
                          return "Enter an amount";
                        }
                        return null;
                      },
                      "advanced amount",
                      "enter amount",
                      amountController,
                      TextInputType.number,
                    ),
                    const SizedBox(height: 10),
                    customerFields.fields(
                      (value) {
                        if (extraAmtController.text.isEmpty) {
                          return "Enter an amount";
                        }
                        return null;
                      },
                      "extra amount per KM",
                      "enter amount",
                      extraAmtController,
                      TextInputType.number,
                    ),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            listCar.isEmpty?_noCarsAvailable() :
                            _showCars();
                          },
                          child: const Text("Select A Car"),
                        ),
                        selectedCar == null
                            ? Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.pink.shade50,
                                ),
                                height: 140,
                                width: 140,
                                child: const Icon(CupertinoIcons.car_detailed),
                              )
                            : SizedBox(
                                height: 200,
                                width: 200,
                                child: SingleChildScrollView(
                                  child: BottomSheetCarTile(
                                    carName: selectedCar!.carName,
                                    vehicleNo: selectedCar!.vehicleNo,
                                    kmDriven: selectedCar!.kmDriven,
                                    seatCapacity: selectedCar!.seatCapacity,
                                    cubicCapacity: selectedCar!.cubicCapacity,
                                    rcNo: selectedCar!.rcNo,
                                    pollutionDate: selectedCar!.pollutionDate,
                                    fuelType: selectedCar!.fuelType,
                                    amtPerDay: selectedCar!.amtPerDay,
                                    carImage: selectedCar!.carImage,
                                    brandName: selectedCar!.brandName,
                                    carType: selectedCar!.carType,
                                    pcImage: selectedCar!.pcImage,
                                    rcImage: selectedCar!.rcImage,
                                  ),
                                ),
                              ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        const Text("Select End Date:"),
                        CupertinoButton(
                          child: Text(
                              "${lastdateTime.day}-${lastdateTime.month}-${lastdateTime.year}"),
                          onPressed: () {
                            showCupertinoModalPopup(
                              context: context,
                              builder: (context) {
                                return SizedBox(
                                  height: 250,
                                  child: CupertinoDatePicker(
                                    minimumDate: DateTime.now(),
                                    onDateTimeChanged: (DateTime newDate) {
                                      setState(() {
                                        lastdateTime = newDate;
                                        noOfDays = lastdateTime
                                                .difference(dateNow)
                                                .inDays +
                                            1;
                                      });
                                    },
                                    backgroundColor: Colors.white,
                                    mode: CupertinoDatePickerMode.date,
                                  ),
                                );
                              },
                            );
                          },
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text("Total Amount:"),
                        Container(
                          decoration: BoxDecoration(
                            border: Border.all(),
                          ),
                          height: 80,
                          width: 250,
                          child: amountController.text.isEmpty ||
                                  selectedCar == null
                              ? const Center(
                                  child: Text(
                                      "Enter Advance amount and Select a Car"))
                              : Center(
                                  child: Text(
                                    "${calculateTotal(noOfDays, amountController, selectedCar!)} for $noOfDays days",
                                  ),
                                ),
                        ),
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
                                _showDialogue("Do you want to cancel the process?", "OK", (){
                                  _clearFeilds();
                                  Navigator.pop(context);
                                  Navigator.popUntil(context, (route) => route.isFirst);

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
                              if (proofImg == null) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(content: Text("Add Proof Image!")));
                                return;
                              }
                              if (selectedCar == null) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(content: Text("Select A Car!")));
                                return;
                              }
                              _showDialogue("Click OK to add customer.", "OK", (){
                                status newStatus = status(
                                    cName: cnameController.text,
                                    cId: cidController.text,
                                    startDate: dateNow,
                                    endDate: lastdateTime,
                                    selectedCar: selectedCar!,
                                    advAmount: int.parse(amountController.text),
                                    extraAmount: int.parse(extraAmtController.text),
                                    proofImage: proofImg!.path,
                                    totalAmount: total!,
                                amountReceived: 0
                                );
                                _addStatus(newStatus);
                                _getStatus();
                                moveToOnHold(selectedCar!, selectedCar!.vehicleNo);
                                Navigator.pop(context);
                                widget.goToStatus(1);
                                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                                    backgroundColor: Colors.green,
                                    content: Text("New Deal Started!",
                                      style: TextStyle(
                                          color: Colors.white
                                      ),
                                    )));
                              }, context);
                            }
                          },
                          child: const Text(
                            "ADD CUSTOMER",
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

  Future<void> moveToOnHold(Cars movingCar,String vehicleNo) async{
    setState(() async{
      await CarServices().deleteAvailableCar(vehicleNo);
      await CarServices().addOnHoldCar(movingCar);
      await CarServices().getAvailableCar();
      await CarServices().getOnHoldCar();
    });

  }

  int calculateTotal(
      int noOfDays, TextEditingController amountController, Cars? selectedCar) {
    if (amountController.text.isEmpty || selectedCar == null) {
      return 0;
    }
    int advanceAmount = int.parse(amountController.text);
    int amtPerDay = selectedCar.amtPerDay;
    int total = (amtPerDay * noOfDays)+advanceAmount;
    return total;
  }

  Future _noCarsAvailable(){
    return showModalBottomSheet(context: context, builder: (context) {
      return const Center(
        child: Text("No Cars are available"),
      );
    } ,);
  }

  Future _showCars() {
    return showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          child: GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
            ),
            itemCount: listCar.length,
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () {
                  setState(() {
                    selectedCar = listCar[index];
                  });
                  Navigator.pop(context);
                },
                child: BottomSheetCarTile(
                  carName: listCar[index].carName,
                  vehicleNo: listCar[index].vehicleNo,
                  kmDriven: listCar[index].kmDriven,
                  seatCapacity: listCar[index].seatCapacity,
                  cubicCapacity: listCar[index].cubicCapacity,
                  rcNo: listCar[index].rcNo,
                  pollutionDate: listCar[index].pollutionDate,
                  fuelType: listCar[index].fuelType,
                  amtPerDay: listCar[index].amtPerDay,
                  carImage: listCar[index].carImage,
                  brandName: listCar[index].brandName,
                  carType: listCar[index].carType,
                  pcImage: listCar[index].pcImage,
                  rcImage: listCar[index].rcImage,
                ),
              );
            },
          ),
        );
      },
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
