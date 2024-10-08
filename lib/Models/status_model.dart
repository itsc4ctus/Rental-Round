import 'package:hive_flutter/hive_flutter.dart';
import 'package:rentel_round/Models/car_model.dart';


part 'status_model.g.dart';
@HiveType(typeId: 2)
class status{
  status({
    required this.cName,
    required this.cId,
    required this.startDate,
    required this.endDate,
    required this.selectedCar,
    required this.advAmount,
    required this.extraAmount,
    required this.proofImage,
    required this.totalAmount,
    required this.amountReceived,
});
  @HiveField(0)
  String cName;
  @HiveField(1)
  String cId;
  @HiveField(2)
  DateTime startDate;
  @HiveField(3)
  DateTime endDate;
  @HiveField(4)
  Cars selectedCar;
  @HiveField(5)
  int advAmount;
  @HiveField(6)
  int totalAmount;
  @HiveField(7)
  int extraAmount;
  @HiveField(8)
  String proofImage;
  @HiveField(9)
  int amountReceived;



}