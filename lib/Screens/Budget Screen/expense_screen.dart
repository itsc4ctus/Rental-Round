import 'package:flutter/material.dart';
import 'package:rentel_round/Models/expences_model.dart';
import 'package:rentel_round/Screens/Budget%20Screen/add_other_expense_screen.dart';
import 'package:rentel_round/Screens/Budget%20Screen/otherExpenseTile.dart';
import 'package:rentel_round/Screens/Budget%20Screen/servicedCarTile.dart';
import 'package:rentel_round/Services/car_services.dart';
import 'package:rentel_round/Services/expence_services.dart';

import '../../Models/car_model.dart';

class ExpenseScreen extends StatefulWidget {
  const ExpenseScreen({super.key});

  @override
  State<ExpenseScreen> createState() => _ExpenseScreenState();
}

class _ExpenseScreenState extends State<ExpenseScreen> {
  List<Cars> servicedCars =[];
  List<expenses> otherExpList = [];
  @override
  void initState() {
    getServicedCar();
    getOtherExp();
    // TODO: implement initState
    super.initState();
  }
  Future<void> getServicedCar()async{
    servicedCars = await CarServices().getExpSerCar();
    setState(() {

    });
  }

  Future<void> getOtherExp() async{
    otherExpList = await ExpenceServices().getExpenses();
    setState(() {

    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text("EXPENSES"),
        actions: [
          IconButton(onPressed: (){
            Navigator.popUntil(context, (route) => route.isFirst);
            setState(() {

            });
          }, icon: Icon(Icons.close))
        ],
      ),
      body: SingleChildScrollView(
        child: SizedBox(
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text("CAR'S SERVICE EXPENSES:"),
              ),
              Card(
                elevation: 8,
                child: Container(
                  height: 400,
                  width: 350,
                  decoration: BoxDecoration(
                    color: Colors.blue.shade50,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child:servicedCars.isEmpty?Center(child: Text("No cars to display!"),) : Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ListView.builder(
                      itemCount: servicedCars.length,
                      itemBuilder: (context, index) => ServicedCarTile(car: servicedCars[index],),),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text("OTHER EXPENSES:"),
              ),
              Card(
                elevation: 8,
                child: Container(
                  height: 400,
                  width: 350,
                  decoration: BoxDecoration(
                    color: Colors.blue.shade50,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        border: Border.all(),
                        borderRadius: BorderRadius.circular(10)
                      ),
                      child: Column(
                        children: [
                          const Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(
                                height: 25,
                                width: 100,

                                child: Text("Date"),
                              ),
                              SizedBox(
                                height: 25,
                                width: 120,

                                child: Text("Expence"),
                              ),
                              SizedBox(
                                height: 25,
                                width: 70,

                                child: Text("Amount"),
                              ),
                            ],
                          ),
                          const Divider(),
                          Expanded(
                            child:otherExpList.isEmpty?Center(child: Text("Add expenses to display here!"),) : ListView.builder(
                              itemCount: otherExpList.length,
                              itemBuilder: (context, index) =>Otherexpensetile(dateTime: otherExpList[index].dateTime,expAmt: otherExpList[index].expenceAmt,expType: otherExpList[index].expenceType,)),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              ElevatedButton(onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) => const OtherExpScreen(),));
                
              }, child: const Text("ADD OTHER EXPENSES")),
            ],
          ),
        ),
      ),
    );
  }
}
