


import 'package:hive/hive.dart';

import '../Models/car_model.dart';

class CarServices{

  Box<Cars>? _carBox;
  Box<Cars>? _availableCarBox;
  Box<Cars>? _onHoldCarBox;
  Box<Cars>? _onServicingCarBox;
  Box<Cars>? _onSerCarForExpense;

  Future<void> openBox()async{
   _carBox = await Hive.openBox("carBox");
   _availableCarBox = await Hive.openBox("availableBox");
   _onHoldCarBox = await Hive.openBox("onHoldBox");
   _onServicingCarBox = await Hive.openBox("onServiceBox");
   _onSerCarForExpense = await Hive.openBox("ExpSerCar");
  }

  Future<void> cloaseBox() async{
    await _carBox!.close();
    await _availableCarBox!.close();
    await _onHoldCarBox!.close();
    await _onServicingCarBox!.close();
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
  Future<void> addServiceCars(Cars car) async{
    if(_onServicingCarBox == null){
      await openBox();
    }
    await _onServicingCarBox!.add(car);
  }

  Future<void> addExpSerCar(Cars car) async{
    if(_onSerCarForExpense==null){
      await openBox();
    }
    await _onSerCarForExpense!.add(car);
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

  Future<List<Cars>> getServicingCars()async{
    if(_onServicingCarBox == null){
      await openBox();
    }
    return _onServicingCarBox!.values.toList();
  }

Future<List<Cars>> getExpSerCar() async{
    if(_onSerCarForExpense == null){
      await openBox();
    }
    return _onSerCarForExpense!.values.toList();
}





//deletecar
Future<void> deleteCar(String vehicleNo) async{
  if(_carBox ==null){
    await openBox();
  }

  for(var key in _carBox!.keys){
    final car = _carBox!.get(key) as Cars;
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
      final car = _availableCarBox!.get(key) as Cars;
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
     final car = _onHoldCarBox!.get(key) as Cars;
     if(car.vehicleNo == vehicleNo){
       await _onHoldCarBox!.delete(key);
     }
   }
  }

  Future<void> deleteServicedCar(String vehicleNo)async{
    if(_onServicingCarBox == null){
      await openBox();
    }
    for(var key in _onServicingCarBox!.keys){
      final car = _onServicingCarBox!.get(key) as Cars;
      if(car.vehicleNo == vehicleNo){
        await _onServicingCarBox!.delete(key);
      }
    }

  }

  Future<void> deleteEsxpSerCar(String vehicleNo)async{
    if(_onSerCarForExpense == null){
      await openBox();
    }
    for(var key in _onSerCarForExpense!.keys){
      final car = _onSerCarForExpense!.get(key) as Cars;
      if(car.vehicleNo == vehicleNo){
        await _onSerCarForExpense!.delete(key);
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
      final car = _carBox!.get(key);
      if (car != null && car.vehicleNo == vehicleNo) {
        await _carBox!.put(key, updatedCar);
        break;
      }
    }


    for (var key in _availableCarBox!.keys) {
      final avCar = _availableCarBox!.get(key);
      if (avCar != null && avCar.vehicleNo == vehicleNo) {
        await _availableCarBox!.put(key, updatedCar);
        break; // Car found, no need to continue
      }
    }
  }






}