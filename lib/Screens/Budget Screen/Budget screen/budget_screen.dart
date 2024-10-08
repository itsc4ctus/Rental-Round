import 'package:flutter/material.dart';
import 'package:rentel_round/Screens/Budget%20Screen/Budget%20screen/widget/cards/budget_screen_card.dart';
import 'package:rentel_round/Screens/Budget%20Screen/Expense%20screen/expense_screen.dart';
import 'package:rentel_round/Screens/Budget%20Screen/Budget%20screen/latestdeals.dart';
import 'package:rentel_round/Screens/Budget%20Screen/Budget%20screen/Deals/showCDeals.dart';
import 'package:rentel_round/Services/car_services.dart';
import 'package:rentel_round/Services/expence_services.dart';
import 'package:rentel_round/Services/status_services.dart';
import 'package:rentel_round/Services/workshop_services.dart';

import '../../../Models/car_model.dart';
import '../../../Models/expences_model.dart';
import '../../../Models/status_model.dart';
import '../../../Models/workshop_model.dart';

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
    List<WorKShopModel> workshopList = await WorkshopServices().getWorkshopList();
    for(var work in workshopList){
      totalServiceCharges = totalServiceCharges + work.serviceAmount;
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
      appBar: AppBar(
        title: const Text("RENTEL ROUND"),
        centerTitle: true,
      ),
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
              budgetCard.buildInfoCard(
                title: "TOTAL INCOME",
                subtitle: "",
                child: Column(
                  children: [
                    budgetCard.buildStatCard("TOTAL INCOME", totalIncome.toString()),
                    budgetCard.buildStatCard("TOTAL EXPENSE", totalExpense.toString()),
                    const Divider(color: Colors.blue),
                    budgetCard.buildStatCard("PROFIT", profit.toString()),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              budgetCard.buildInfoCard(
                title: "LATEST DEALS",
                subtitle: "",
                child: Container(
                  padding: const EdgeInsets.all(10),
                  height: 200,
                  width: 300,
                  decoration: BoxDecoration(border: Border.all()),
                  child: CStatusList.isEmpty
                      ? const Center(child: Text("No Deals to show"))
                      : ListView.builder(
                    itemCount: CStatusList.length > 7 ? 7 : CStatusList.length,
                    itemBuilder: (context, index) => LatestDeals(
                      cName: CStatusList[index].cName,
                      amountRecieved: CStatusList[index].amountReceived,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const ShowCDeals()));
                  },
                  child: const Text("SHOW ALL DEALS"),
                ),
              ),
              const SizedBox(height: 5),
              budgetCard.buildInfoCard(
                title: "EXPENSES",
                subtitle: "",
                child: Column(
                  children: [
                    budgetCard.buildStatCard("SERVICE CHARGES", totalServiceCharges.toString()),
                    budgetCard.buildStatCard("OTHER EXPENSES", totalOtherExp.toString()),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(6.0),
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => ExpenseScreen()),
                          (route) => route.isFirst,
                    );
                  },
                  child: const Text("EXPENSE"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}