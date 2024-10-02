import 'package:flutter/material.dart';
import 'package:rentel_round/Screens/Status/completedStatusTile.dart';

import '../../Models/status_model.dart';
import '../../Services/status_services.dart';


class CompletedDeals extends StatefulWidget {
  const CompletedDeals({super.key});

  @override
  State<CompletedDeals> createState() => _CompletedDealsState();
}

class _CompletedDealsState extends State<CompletedDeals> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getStatus();
  }

  Future<void> getStatus() async {
    statusList = await StatusServices().getCompletedStatus();
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
        title: const Text("COMPLETED DEALS"),
      ),
      body:statusList.isEmpty ? const Center(
        child: Text("No completed deals to show"),
      ) : ListView.builder(
        itemCount: statusList.length,
        itemBuilder: (context, index) => StatusTileCompleted(
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
