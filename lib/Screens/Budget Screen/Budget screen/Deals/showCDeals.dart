import 'package:flutter/material.dart';
import 'package:rentel_round/Screens/Budget%20Screen/Budget%20screen/Deals/showCDealsTile.dart';

import '../../../../Models/status_model.dart';
import '../../../../Services/status_services.dart';


class ShowCDeals extends StatefulWidget {
  const ShowCDeals({super.key});

  @override
  State<ShowCDeals> createState() => _ShowCDealsState();
}

class _ShowCDealsState extends State<ShowCDeals> {
  @override
  void initState() {
    getStatus();
    // TODO: implement initState
    super.initState();

  }

  Future<void> getStatus() async {
    statusList = await StatusServices().getCompletedDealStatus();
    setState(() {});
  }

  Future<void> deleteCompletedStatus(String customerId)async{
    await StatusServices().deleteCompletedStatus(customerId);
    getStatus();
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        backgroundColor: Colors.red,
        content: Text("Deleted Succesfully!",
          style: TextStyle(
              color: Colors.white
          ),
        )));
  }


  List<status> statusList = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("ALL DEALS"),
      ),
      body:statusList.isEmpty ? const Center(
        child: Text("No completed deals to show"),
      ) : ListView.builder(
        itemCount: statusList.length,
        itemBuilder: (context, index) => ShowCDealsTile(
          cName: statusList[index].cName,
          cId: statusList[index].cId,
          startDate: statusList[index].startDate,
          endDate: statusList[index].endDate,
          advAmount: statusList[index].advAmount,
          extraAmount: statusList[index].extraAmount,
          proofImage: statusList[index].proofImage,
          selectedCar: statusList[index].selectedCar,
          totalAmount: statusList[index].totalAmount,
          completedCustomer: statusList[index],
          ondelete: (){
            _showDialogue("Do you want to delete?", "OK", (){deleteCompletedStatus(statusList[index].cId);
            Navigator.pop(context);
            }, context);

          },
amountRecieved: statusList[index].amountReceived,
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
