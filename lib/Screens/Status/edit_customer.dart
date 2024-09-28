import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:image_picker/image_picker.dart';
import 'package:rentel_round/Models/car_model.dart';
import 'package:rentel_round/Models/status_model.dart';
import 'package:rentel_round/Screens/Customer/bottomsheetcar_tile.dart';
import 'package:rentel_round/Screens/Customer/customerFeilds.dart';
import 'package:rentel_round/Screens/Status/status_screen.dart';
import 'package:rentel_round/Services/car_services.dart';
import 'package:rentel_round/Services/status_services.dart';

import '../../Models/status_model.dart';

class EditScreenCustomer extends StatefulWidget {
final status customer;
  EditScreenCustomer({required this.customer, super.key});

  @override
  State<EditScreenCustomer> createState() => _EditScreenCustomerState();
}

class _EditScreenCustomerState extends State<EditScreenCustomer> {

  late DateTime dateNow;
  late DateTime lastdateTime;
  int? finalAmount;
  List<Cars> listCar = [];
  int? noOfDays;
  int? total=0;
  TextEditingController cnameController = TextEditingController();
  TextEditingController cidController = TextEditingController();
  TextEditingController endDateController = TextEditingController();
  TextEditingController noOfDaysController = TextEditingController();
  TextEditingController currentKmController = TextEditingController();
  TextEditingController amountController = TextEditingController();
  TextEditingController extraAmtController = TextEditingController();

  late Cars carSelected;
  final GlobalKey<FormState> _key = GlobalKey();
  CustomerFeilds customerFields = CustomerFeilds();
  ImagePicker picker = ImagePicker();
  XFile? proofImg;
  @override
  void initState() {
    _loadCars();
    amountController.addListener(_updateAmount);
    super.initState();
    cnameController = TextEditingController(text: widget.customer.cName);
     cidController = TextEditingController(text: widget.customer.cId);
     endDateController = TextEditingController(text: widget.customer.endDate.toString());
     amountController = TextEditingController(text: widget.customer.advAmount.toString());
     extraAmtController = TextEditingController(text: widget.customer.extraAmount.toString());
     dateNow  = DateTime(widget.customer.startDate.year, widget.customer.startDate.month, widget.customer.startDate.day);
    lastdateTime = DateTime(widget.customer.endDate.year, widget.customer.endDate.month, widget.customer.endDate.day);
      carSelected = widget.customer.selectedCar;
      proofImg = XFile(widget.customer.proofImage);
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

  void _editStatus(String customerID,status updatedStatus) async {
    await StatusServices().updateStatus(customerID, updatedStatus);
    _getStatus();
    Navigator.popUntil(context, (route) => route.isFirst);
  }
  Future<void> _getStatus() async {
    await StatusServices().getStatus();
    setState(() {

    });
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
    int noOfDays = duration.inDays + 1; // Calculate number of days
    return Scaffold(
      appBar: AppBar(
        title: Text("${widget.customer.cName}"),
        centerTitle: true,
      ),
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
                              ? Image(
                              fit: BoxFit.cover,
                              image: FileImage(File(widget.customer.proofImage)))
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
                    "extra amount per 100 KM",
                    "enter amount",
                    extraAmtController,
                    TextInputType.number,
                  ),
                  const SizedBox(height: 10),
                  Container(
                         height: 200,
                         width: 200,
                         child: SingleChildScrollView(
                           child: BottomSheetCarTile(
                             carName: carSelected!.carName,
                             vehicleNo: carSelected!.vehicleNo,
                             kmDriven: carSelected!.kmDriven,
                             seatCapacity: carSelected!.seatCapacity,
                             cubicCapacity: carSelected!.cubicCapacity,
                             rcNo: carSelected!.rcNo,
                             pollutionDate: carSelected!.pollutionDate,
                             fuelType: carSelected!.fuelType,
                             amtPerDay: carSelected!.amtPerDay,
                             carImage:carSelected!.carImage,
                             brandName: carSelected!.brandName,
                             carType: carSelected!.carType,
                             pcImage: carSelected!.pcImage,
                             rcImage: carSelected!.rcImage,
                           ),
                         ),
                       ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      const Text("Click to Extend End Date:"),
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
                                  minimumYear: widget.customer.startDate.year,
                                  minimumDate:dateNow,
                                  initialDateTime: lastdateTime,
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
                        child:  Center(
                                child: Text(
                                  "${calculateTotal(noOfDays, amountController, carSelected!)} for $noOfDays days",
                                ),
                              ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          _showDialogue("Do you need to cancel edit?", "OK", navigateToStatus, context);
                        },
                        child: const Text(
                          "CANCEL",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {


                          if (_key.currentState!.validate()) {
                            if (proofImg == null || widget.customer.proofImage == null) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text("Add Proof Image!")));
                              return;
                            }
                          _showDialogue("Click ok to save", "OK", _editCustomer, context);

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
  Future<void> _editCustomer()async{
    status newStatus = status(
        cName: cnameController.text,
        cId: cidController.text,
        startDate: dateNow,
        endDate: lastdateTime,
        selectedCar: carSelected,
        advAmount: int.parse(amountController.text),
        extraAmount: int.parse(extraAmtController.text),
        proofImage: proofImg!.path,
        totalAmount: total!,
    amountReceived: 0
    );
    _editStatus(cidController.text,newStatus);
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        backgroundColor: Colors.blue,
        content: Text("Customer details edited!")));
  }
Future<void> navigateToStatus()async{
    Navigator.popUntil(context, (route) => route.isFirst,);
}

  int calculateTotal(
      int noOfDays, TextEditingController amountController, Cars? selectedCar) {
    if (amountController.text.isEmpty || selectedCar == null) {
      return 0;
    }

    int advanceAmount = int.parse(amountController.text);
    int amtPerDay = selectedCar.amtPerDay;
    int total = (advanceAmount + amtPerDay) * noOfDays;

    return total;
  }
  void _showDialogue(String messege,String btnName,VoidCallback btnfn,BuildContext context){
    showDialog(context: context,builder: (context) {
      return AlertDialog(
        title: Text("$messege"),
        actions: [
          ElevatedButton(onPressed: (){
            Navigator.pop(context);
          }, child: Text("CANCEL")),
          ElevatedButton(onPressed: btnfn, child: Text("$btnName"))
        ],
      );

    });

  }
}
