import 'package:hive/hive.dart';
part 'expences_model.g.dart';
@HiveType(typeId: 3)
class expenses{
  expenses({
    required this.expenceType,
    required this.expenceAmt,
    required this.dateTime,
    required this.id,
});

  @HiveField(0)
  String expenceType;

  @HiveField(1)
  int expenceAmt;

  @HiveField(2)
  DateTime dateTime;

  @HiveField(3)
  String id;




}