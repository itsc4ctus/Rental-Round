import 'package:flutter/material.dart';
import 'package:rentel_round/Screens/Customer/completed_deals.dart';
import 'package:rentel_round/Screens/Status/edit_customer.dart';
import 'package:rentel_round/Screens/Status/status_tile.dart';
import 'package:rentel_round/Services/status_services.dart';

import '../../Models/status_model.dart';

class StatusScreen extends StatefulWidget {

  const StatusScreen({super.key});

  @override
  State<StatusScreen> createState() => _StatusScreenState();
}

class _StatusScreenState extends State<StatusScreen> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getStatus();

  }

  Future<void> getStatus() async {
    statusList = await StatusServices().getStatus();
    setState(() {});
  }

  Future<void> editStatus(status customer) async{
    await Navigator.push(context, MaterialPageRoute(builder: (context) => EditScreenCustomer(customer: customer),));
    await getStatus();
  }


  List<status> statusList = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("RENTEL ROUND"),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child:statusList.isEmpty ? const Center(
              child: Text("No deals to show!"),
            ): ListView.builder(
              itemCount: statusList.length,
              itemBuilder: (context, index) => StatusTile(
                cName: statusList[index].cName,
                cId: statusList[index].cId,
                startDate: statusList[index].startDate,
                endDate: statusList[index].endDate,
                advAmount: statusList[index].advAmount,
                extraAmount: statusList[index].extraAmount,
                proofImage: statusList[index].proofImage,
                selectedCar: statusList[index].selectedCar,
                totalAmount: statusList[index].totalAmount,
                editStatus: ()=>editStatus(statusList[index]),
            Status: statusList[index],
              ),
            ),
          ),
          ElevatedButton(onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context) => const CompletedDeals(),));
          }, child: const Text("Completed deals"))
        ],
      ),
    );
  }
}
