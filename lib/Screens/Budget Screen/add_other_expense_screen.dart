import 'package:flutter/material.dart';
import 'package:rentel_round/Models/expences_model.dart';
import 'package:rentel_round/Services/expence_services.dart';

import 'expense_screen.dart';

class OtherExpScreen extends StatefulWidget {
  const OtherExpScreen({super.key});

  @override
  State<OtherExpScreen> createState() => _OtherExpScreenState();
}

class _OtherExpScreenState extends State<OtherExpScreen> {
  TextEditingController expNameController = TextEditingController();
  TextEditingController amtController = TextEditingController();
  final GlobalKey<FormState> _key = GlobalKey();

  Future<void> addNewExpence(expenses Expence) async {
    await ExpenceServices().addExpenses(Expence);

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add New Expenses"),
      ),
      body: Center(
        child: Container(
          padding: const EdgeInsets.all(20),
          child: Form(
            key: _key,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextFormField(
                  validator: (value){
                    if(value!.isEmpty){
                      return "Enter the feild";
                    }
                  },
                  controller: expNameController,
                  decoration: const InputDecoration(
                      labelText: "Expence",
                      hintText: "enter your type of expence",
                      border: OutlineInputBorder()),
                ),
                const SizedBox(
                  height: 15,
                ),
                TextFormField(
                  validator: (value){
                    if(value!.isEmpty){
                      return "Enter the feild";
                    }
                  },
                  keyboardType: TextInputType.number,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  controller: amtController,
                  decoration: const InputDecoration(
                      labelText: "Amount",
                      hintText: "enter your amount",
                      border: OutlineInputBorder()),
                ),
                const SizedBox(
                  height: 15,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ElevatedButton(onPressed: () {
                      _showDialogue("Do you want to cancel?", "OK", (){
                        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => ExpenseScreen()),(route) => route.isFirst,);
                      }, context);
                    }, child: const Text("CANCEL")),
                    ElevatedButton(
                        onPressed: () {
                          if(_key.currentState!.validate()){
                            expenses newExpence = expenses(
                                expenceType: expNameController.text,
                                expenceAmt: int.parse(amtController.text),
                                dateTime: DateTime.now(),
                                id: DateTime.now().toString() +
                                    expNameController.text);
                            addNewExpence(newExpence);
                            setState(() {

                            });
                            Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => ExpenseScreen(),), (route) => route.isFirst,);
                          }

                        },
                        child: const Text("ADD")),
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
