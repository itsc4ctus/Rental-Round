import 'package:hive/hive.dart';
import 'package:rentel_round/Models/workshop_model.dart';

class WorkshopServices{
  Box<WorKShopModel>? workshopBox;

  Future<void> openBox() async{
    workshopBox = await Hive.openBox("WorkShopBox");
  }
  Future<void> closeBox()async {
    workshopBox!.close();
  }

  Future<void> addWorkshop(WorKShopModel service) async{
    if(workshopBox == null){
      await openBox();
    }
    await workshopBox!.add(service);
  }
  Future<List<WorKShopModel>> getWorkshopList()async{
    if(workshopBox == null){
      await openBox();
    }
    return workshopBox!.values.toList();
  }



}