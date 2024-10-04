import 'package:hive/hive.dart';
import 'package:rentel_round/Models/expences_model.dart';

class ExpenceServices{
  Box<expenses>? _expBox;


  Future<void> openBox() async{
   _expBox = await Hive.openBox("expBox");
  }

  Future<void> closeBox()async{
    await _expBox!.close();
  }


  Future<void> addExpenses(expenses Expence)async{
    if(_expBox == null){
      await openBox();
    }
    await _expBox!.add(Expence);
  }

  Future<List<expenses>> getExpenses()async{
    if(_expBox == null){
      await openBox();
    }
    return _expBox!.values.toList();
  }

  Future<void> deleteExpence(String id)async {
    if(_expBox == null){
      await openBox();
    }

    for(var key in _expBox!.keys){
      final Expenses = _expBox!.get(key) as expenses;
      if(Expenses.id == id){
        await _expBox!.delete(key);
      }
    }
  }


  Future<void> updateExpences(String id,expenses Expence)async{
    if(_expBox == null){
      await openBox();
    }
    for(var key in _expBox!.keys){
      final Expenses = _expBox!.get(key) as expenses;
      if(Expenses.id == id){
        await _expBox!.put(key, Expence);
      }
    }
  }




}