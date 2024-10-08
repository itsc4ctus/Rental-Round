
import 'package:hive/hive.dart';
import 'package:rentel_round/Models/car_model.dart';


part 'workshop_model.g.dart';
@HiveType(typeId: 4)
class WorKShopModel{
  WorKShopModel({
    required this.car,
    required this.dateTime,
    required this.serviceAmount
});


  @HiveField(0)
  late Cars car;

  @HiveField(1)
  late DateTime dateTime;

  @HiveField(2)
  late int serviceAmount;
}