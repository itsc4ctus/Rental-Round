import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rentel_round/Screens/Status/status_screen.dart';
import 'package:rentel_round/Services/car_services.dart';
import 'package:rentel_round/Services/status_services.dart';

import '../../Models/car_model.dart';
import '../../Models/status_model.dart';

class ShowDeal extends StatefulWidget {
  final int carAmount;
  final int advAmount;
  final int extraAmount;
  final int kmDriven;
  final status Status;
  final Cars selectedCar;


  ShowDeal({
    required this.carAmount,
    required this.advAmount,
    required this.extraAmount,
    required this.kmDriven,
    required this.selectedCar,
required this.Status,

  });

  @override
  State<ShowDeal> createState() => _ShowDealState();
}

class _ShowDealState extends State<ShowDeal> {
  int extraKmDriven = 0;
  int totalAmount = 0;

  TextEditingController extraKmDrivenController = TextEditingController();
  TextEditingController amountController = TextEditingController();
GlobalKey<FormState> _key = GlobalKey();
  @override
  void initState() {

    extraKmDrivenController = TextEditingController(text: widget.kmDriven.toString());
    calculateExtraKm();
    // TODO: implement initState
    super.initState();

  }

Future<void> moveToCompleted(status Status) async{
    await StatusServices().addCompletedStatus(Status);
    await StatusServices().deleteStatus(Status.cId);
    await CarServices().addAvailableCar(widget.selectedCar);
    await CarServices().deleteOnHoldCar(widget.selectedCar.vehicleNo);
    Navigator.of(context).pop(true);
setState(() {
});
  }

  Future<void> updateCarKM(String vehicleNo,Cars updatedCar,int newKM) async{
    updatedCar.kmDriven = newKM;
    await CarServices().updateCar(vehicleNo, updatedCar);

  }
Future<void> updateStatusTM(int totalAmt,status completedStatus)async {
    completedStatus.amountReceived = totalAmt;
    await StatusServices().updateCompletedStatus(completedStatus.cId, completedStatus);
}


  void calculateExtraKm() {
    setState(() {
      int newKm = int.tryParse(extraKmDrivenController.text) ?? widget.kmDriven;
      extraKmDriven = (newKm - widget.kmDriven);
      int extraCharges = (extraKmDriven ~/ 50) * widget.extraAmount;
      totalAmount = widget.carAmount + extraCharges - widget.advAmount;
      totalAmount > 0 ? totalAmount = totalAmount  : totalAmount=0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Deal"),
      content: SingleChildScrollView(
        child: Container(
          height: 450,
          child: Form(
            key: _key,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                TextFormField(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (value){
                    if(value == null || value.isEmpty){
                      return "Enter current Car KM";
                    }
                    if(int.parse(value!)<widget.kmDriven){
                      return "KM must be greater than the old one";
                    }
                  },
                  controller: extraKmDrivenController,

                  onChanged: (value){
                    calculateExtraKm();
                  },
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "KM driven",
                    hintText: "Enter km driven after use",
                  ),
                  keyboardType: TextInputType.number,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text("Amount of Car/day"),
                      Text(": ${widget.carAmount}"),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text("Advance amount"),
                      Text(": ${widget.advAmount}"),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text("Amount / 50KM"),
                      Text(": ${widget.extraAmount}"),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text("Extra KM Driven"),
                      Text(": $extraKmDriven"),
                    ],
                  ),
                ),
                const SizedBox(height: 30),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text("Total amount"),
                      Text(": $totalAmount"),
                    ],
                  ),
                ),
                TextFormField(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (value){
                    if(amountController.text.isEmpty){
                      return "Enter total amount paid";
                    }
                  },
                  controller: amountController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Amount Paid",
                    hintText: "Enter amount paid",
                  ),
                  keyboardType: TextInputType.number,
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pop(); // Close the dialog
                      },
                      child: const Text("CANCEL"),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        if(_key.currentState!.validate()){
                          _showDialogue("Do you want complete the deal?", "COMPLETE",()async{

                            await moveToCompleted(widget.Status);
                            await CarServices().getAvailableCar();
                            await CarServices().getCar();
                            await updateCarKM(widget.selectedCar.vehicleNo, widget.selectedCar, int.parse(extraKmDrivenController.text));
                            await updateStatusTM(int.parse(amountController.text), widget.Status);
                            Navigator.of(context).pop(true);
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                backgroundColor: Colors.green,
                                content: Text("Deal Completed!",
                                style: TextStyle(
                                  color: Colors.white
                                ),
                                )));
                          } , context);


                        }

                      },
                      child: const Text("DEAL"),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
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
