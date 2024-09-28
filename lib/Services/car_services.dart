


import 'package:hive/hive.dart';

import '../Models/car_model.dart';

class CarServices{

  Box<Cars>? _carBox;
  Box<Cars>? _availableCarBox;
  Box<Cars>? _onHoldCarBox;

  Future<void> openBox()async{
   _carBox = await Hive.openBox("carBox");
   _availableCarBox = await Hive.openBox("availableBox");
   _onHoldCarBox = await Hive.openBox("onHoldBox");
  }

  Future<void> cloaseBox() async{
    await _carBox!.close();
    await _availableCarBox!.close();
    await _onHoldCarBox!.close();
}

  //add car
Future<void> addCar(Cars car) async{
    if(_carBox ==null){
      await openBox();
    }
    await _carBox!.add(car);
}
  Future<void> addAvailableCar(Cars car) async{
    if(_availableCarBox ==null){
      await openBox();
    }
    await _availableCarBox!.add(car);
  }
  Future<void> addOnHoldCar(Cars car) async{
    if(_onHoldCarBox ==null){
      await openBox();
    }
    await _onHoldCarBox!.add(car);
  }


//getCar
Future<List<Cars>> getCar() async{
  if(_carBox ==null){
    await openBox();
  }
  return _carBox!.values.toList();
}

  Future<List<Cars>> getAvailableCar() async{
    if(_availableCarBox ==null){
      await openBox();
    }
    return _availableCarBox!.values.toList();
  }

  Future<List<Cars>> getOnHoldCar() async{
    if(_onHoldCarBox ==null){
      await openBox();
    }
    return _onHoldCarBox!.values.toList();
  }









//deletecar
Future<void> deleteCar(String vehicleNo) async{
  if(_carBox ==null){
    await openBox();
  }

  for(var key in _carBox!.keys){
    final car = await _carBox!.get(key) as Cars;
    if(car.vehicleNo == vehicleNo){
      await _carBox!.delete(key);
      await _availableCarBox!.delete(key);
      break;
    }
  }
}

  Future<void> deleteAvailableCar(String vehicleNo) async{
    if(_availableCarBox ==null){
      await openBox();
    }

    for(var key in _availableCarBox!.keys){
      final car = await _availableCarBox!.get(key) as Cars;
      if(car.vehicleNo == vehicleNo){
        await _availableCarBox!.delete(key);
        break;
      }
    }
  }
  Future<void> deleteOnHoldCar(String vehicleNo) async{
   if(_onHoldCarBox == null){
     await openBox();
   }
   for(var key in _onHoldCarBox!.keys){
     final car = await _onHoldCarBox!.get(key) as Cars;
     if(car.vehicleNo == vehicleNo){
       await _onHoldCarBox!.delete(key);
     }
   }
  }


//updatecar
  Future<void> updateCar(String vehicleNo, Cars updatedCar) async {
    if (_carBox == null) {
      await openBox();
    }
    if (_availableCarBox == null) {
      await openBox();
    }


    for (var key in _carBox!.keys) {
      final car = _carBox!.get(key) as Cars?;
      if (car != null && car.vehicleNo == vehicleNo) {
        await _carBox!.put(key, updatedCar);
        break;
      }
    }


    for (var key in _availableCarBox!.keys) {
      final avCar = _availableCarBox!.get(key) as Cars?;
      if (avCar != null && avCar.vehicleNo == vehicleNo) {
        await _availableCarBox!.put(key, updatedCar);
        break; // Car found, no need to continue
      }
    }
  }




}