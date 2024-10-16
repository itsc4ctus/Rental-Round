import 'package:hive/hive.dart';

import '../Models/auth_model.dart';

class AuthServices{
  Box<Auth>? _authBox;

  Future<void> openBox() async {
    _authBox = await Hive.openBox("AuthBox");
  }

  Future<void> closeBox() async{
    await _authBox!.close();
  }

  //Add User
Future<void> addUser(Auth auth) async{
    if(_authBox == null){
      await openBox();
    }
   await _authBox!.put("USER",auth);
}

//getUser

Future<Auth?> getUser(String user) async{
  if(_authBox == null){
    await openBox();
  }
  return _authBox!.get(user);
}

  Future<void> updateUser(Auth auth) async {
    if (_authBox == null) {
      await openBox();
    }
    await _authBox!.put("USER", auth);
  }

  // Delete User
  Future<void> deleteUser(String phoneNumber) async {
    if (_authBox == null) {
      await openBox();
    }
    await _authBox!.delete(phoneNumber);
  }



}