


import 'package:hive/hive.dart';

Future<void> sample() async{


  Box<String> boxname;
  boxname = await Hive.openBox('myBox');
  await boxname.put("key", "hello");
  boxname.get("key");

}