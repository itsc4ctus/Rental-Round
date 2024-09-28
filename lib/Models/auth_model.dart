import 'package:hive/hive.dart';

part 'auth_model.g.dart';

@HiveType(typeId: 0)
class Auth {
  Auth({
    required this.username,
    required this.password,
    required this.shopname,
    required this.shopownername,
    required this.shoplocation,
    required this.phonenumer,
    required this.email,
    required this.image,
  });

  @HiveField(0)
  late String username;

  @HiveField(1)
  late String password;

  @HiveField(2)
  late String shopname;

  @HiveField(3)
  late String shopownername;

  @HiveField(4)
  late String shoplocation;

  @HiveField(5)
  late int phonenumer;

  @HiveField(6)
  late String email;

  @HiveField(7)
  late String image;
}
