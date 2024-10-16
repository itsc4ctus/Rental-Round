import 'package:hive/hive.dart';

part 'auth_model.g.dart';

@HiveType(typeId: 0)
class Auth {
  Auth({
    required this.shopname,
    required this.shopownername,
    required this.shoplocation,
    required this.phonenumer,
    required this.email,
    required this.image,
    required this.status,

  });
  @HiveField(1)
  late String shopname;

  @HiveField(2)
  late String shopownername;

  @HiveField(3)
  late String shoplocation;

  @HiveField(4)
  late int phonenumer;

  @HiveField(5)
  late String email;

  @HiveField(6)
  late String image;
  @HiveField(7)
  late bool status;
}
