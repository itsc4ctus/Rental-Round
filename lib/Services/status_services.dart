


import 'package:hive/hive.dart';

import '../Models/status_model.dart';

class StatusServices{
  Box<status>? statusBox;
  Box<status>? completedStatusBox;

  Future<void> openBox() async {
    statusBox = await Hive.openBox("satusBox");
    completedStatusBox = await Hive.openBox("compledtedStatusBox");
}
  Future<void> closeBox() async{
    await statusBox!.close();
    await completedStatusBox!.close();
  }

  Future<void> addStatus(status status)async{
    if(statusBox == null){
     await openBox();
    }
    await statusBox!.add(status);
  }

  Future<void> addCompletedStatus(status status)async{
    if(completedStatusBox == null){
      await openBox();
    }
    await completedStatusBox!.add(status);
  }







  Future<List<status>> getStatus() async{
    if(statusBox == null){
     await openBox();
    }
    return statusBox!.values.toList();
  }

  Future<List<status>> getCompletedStatus()async{
    if(completedStatusBox == null){
      await openBox();
    }
    return completedStatusBox!.values.toList();
  }


  Future<void> deleteStatus(String customerId) async {
    if(statusBox == null){
      await openBox();
    }
    for(var key in statusBox!.keys){
      final selectedstatus = await statusBox!.get(key) as status;
      if(selectedstatus.cId == customerId){
        await statusBox!.delete(key);
      }
    }
  }


  Future<void> deleteCompletedStatus(String customerId) async {
    if(completedStatusBox == null){
      await openBox();
    }
    for(var key in completedStatusBox!.keys){
      final selectedstatus = await completedStatusBox!.get(key) as status;
      if(selectedstatus.cId == customerId){
        await completedStatusBox!.delete(key);
      }
    }
  }







  Future<void> updateStatus(String customerID,status updatedStatus)async{
    if(statusBox == null){
      await openBox();
    }
    for(var key in statusBox!.keys){
      final Status = await statusBox!.get(key) as status;
      if(Status.cId == customerID){
        await statusBox!.put(key, updatedStatus);
        break;
      }
    }
  }
  Future<void> updateCompletedStatus(String customerID,status updatedStatus)async{
    if(completedStatusBox== null){
      await openBox();
    }
    for(var key in completedStatusBox!.keys){
      final Status = await completedStatusBox!.get(key) as status;
      if(Status.cId == customerID){
        await completedStatusBox!.put(key, updatedStatus);
        break;
      }
    }
  }



}