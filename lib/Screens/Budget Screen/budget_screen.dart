import 'package:flutter/material.dart';
import 'package:rentel_round/Screens/Budget%20Screen/expense_screen.dart';
import 'package:rentel_round/Screens/Budget%20Screen/latestdeals.dart';
import 'package:rentel_round/Screens/Budget%20Screen/showCDeals.dart';
import 'package:rentel_round/Services/car_services.dart';
import 'package:rentel_round/Services/expence_services.dart';
import 'package:rentel_round/Services/status_services.dart';

import '../../Models/car_model.dart';
import '../../Models/expences_model.dart';
import '../../Models/status_model.dart';

class BudgetScreen extends StatefulWidget {
  const BudgetScreen({super.key});

  @override
  State<BudgetScreen> createState() => _BudgetScreenState();
}

class _BudgetScreenState extends State<BudgetScreen> {
  int totalIncome =0;
  int totalExpense=0;
  int totalServiceCharges=0;
  int totalOtherExp=0;
  int profit=0;
  List<status> CStatusList =[];
  @override
  void initState() {
    _loadCompletedStatus();
    super.initState();
  }

  Future<void> _loadCompletedStatus()async{
    List<status> list = await StatusServices().getCompletedDealStatus();
    CStatusList = list;
    CStatusList = CStatusList.reversed.toList();
    for(var Status in  CStatusList){
      totalIncome = totalIncome + Status.amountReceived;
    }
    List<Cars> carList = await CarServices().getExpSerCar();
    for(var cars in carList){
      totalServiceCharges = totalServiceCharges + cars.serviceAmount;
    }
    List<expenses> expList = await ExpenceServices().getExpenses();
    for(var expense in expList){
      totalOtherExp = totalOtherExp + expense.expenceAmt;
    }
    totalExpense = totalServiceCharges + totalOtherExp;
    profit = totalIncome - totalExpense;
    setState(() {

    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
backgroundColor: Colors.white,
      body: SizedBox(
        width: double.infinity,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text("BUDGET TRACKER"),
              ),
              Card(
                elevation: 8,
                child: Container(
                  padding: const EdgeInsets.all(12),
                  height: 160,
                  width: 300,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.blue.shade50
                  ),
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const SizedBox(
                            height: 25,
                            width: 150,

                            child: Text("TOTAL INCOME"),
                          ),
                          SizedBox(
                            height: 25,
                            width: 100,

                            child: Text(": $totalIncome"),
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
                            height: 25,
                            width: 150,

                            child: Text("TOTAL EXPENSE"),
                          ),
                          SizedBox(
                            height: 25,
                            width: 100,

                            child: Text(": $totalExpense"),
                          ),
                        ],
                      ), const SizedBox(
                        height: 10,
                      ),
                      Divider(
                        color: Colors.blue.shade600,
                      ),
                      const SizedBox(
                        height: 10,
                      ),

                       Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            height: 25,
                            width: 150,

                            child: Text("PROFIT"),
                          ),
                          SizedBox(
                            height: 25,
                            width: 100,

                            child: Text(": $profit"),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Card(
                elevation: 8,
                child: Container(
                  width: 350,
                  height: 320,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.blue.shade50
                  ),
                  child: Column(
                    children: [
                      const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text("LASTEST DEALS"),
                      ),
                      Container(
                        padding: const EdgeInsets.all(10),
                        height: 200,
                        width: 300,
                        decoration: BoxDecoration(
                          border: Border.all(),

                        ),
                        child:CStatusList.isEmpty ? const Center(
                          child: Text("No Deals to show"),
                        )  : ListView.builder(
                            itemCount:CStatusList.length > 7 ? 7 : CStatusList.length,
                            itemBuilder: (context, index) => LatestDeals(cName: CStatusList[index].cName, amountRecieved: CStatusList[index].amountReceived)
                        ),),

                      Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: ElevatedButton(onPressed: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context) => const ShowCDeals(),));
                        }, child: const Text("SHOW ALL DEALS")),
                      )
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Card(
                elevation: 8,
                child: Container(
                  width: 350,
                  height: 210,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.blue.shade50
                  ),
                  child: Column(
                    children: [
                      const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text("EXPENSES"),
                      ),
                      Container(
                        padding: const EdgeInsets.all(10),
                        height: 92,
                        width: 300,
                        decoration: BoxDecoration(
                          border: Border.all(),

                        ),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const SizedBox(
                                  height: 25,
                                  width: 150,

                                  child: Text("SERVICE CHARGES"),
                                ),
                                SizedBox(
                                  height: 25,
                                  width: 100,

                                  child: Text(": $totalServiceCharges"),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const SizedBox(
                                  height: 25,
                                  width: 150,

                                  child: Text("OTHER EXPENSES"),
                                ),
                                SizedBox(
                                  height: 25,
                                  width: 100,

                                  child: Text(": $totalOtherExp"),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                          ],
                        ),),

                      Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: ElevatedButton(onPressed: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context) => const ExpenseScreen(),));
                        }, child: const Text("EXPENSE")),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
