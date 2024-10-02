import 'package:hive_flutter/hive_flutter.dart';

import '../Models/auth_model.dart';


class AuthServices{

  Box<Auth>? _authBox;
  Box<bool>? _loginStatus;
  Box<int>? _lastLoginIndex;
  String? loogedinUserId;
Future<void> login(String username,String loginId)async{
  loogedinUserId = username;
}
String? getUserId(){
  return loogedinUserId;
}

  Future<void> openBox()async{
    _authBox = await Hive.openBox('authBox');
    _loginStatus = await Hive.openBox('loginBox');
    _lastLoginIndex = await Hive.openBox('indexBox');
  }

  Future<void> closeBox()async{
    await _authBox!.close();
    await _loginStatus!.close();
  }

Future<void> setLoginStatus(bool status)async{
  if(_loginStatus==null){
    await openBox();
  }
  await _loginStatus!.put('status', status);
}

Future<bool?> getloginStatus()async{
  if(_loginStatus==null){
    await openBox();
  }
  return  _loginStatus!.get('status',defaultValue: false);
}


  Future <void> writeData(Auth auth) async{
    if(_authBox==null){
      await openBox();
    }
    int? index =await _authBox!.add(auth);
    await _lastLoginIndex!.put("index",index);
    print("Data added");
  }

  Future <List<Auth>> getData()async{
    if(_authBox==null){
      await openBox();
    }
   return _authBox!.values.toList();

  }

  Future<Auth?> getLastUser()async{
    if(_authBox==null){
      await openBox();
    }
    int? lastUserIndex =   _lastLoginIndex!.get("index");
    if(lastUserIndex != null){
      return _authBox!.get(lastUserIndex);
    }else{
      return null;
    }
  }



  Future<void> updateData(int index,Auth auth) async{
    if(_authBox==null){
      await openBox();
    }
    await _authBox!.put(index,auth);
  }

  Future<void> deleteData(int index)async{
    if(_authBox==null){
      await openBox();
    }
    await _authBox!.deleteAt(index);
  }
}