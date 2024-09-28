import 'package:hive/hive.dart';

part 'car_model.g.dart';

@HiveType(typeId: 1)
class Cars {
  Cars({
    required this.carName,
    required this.vehicleNo,
    required this.kmDriven,
    required this.seatCapacity,
    required this.cubicCapacity,
    required this.rcNo,
    required this.pollutionDate,
    required this.fuelType,
    required this.amtPerDay,
    required this.carImage,
    required this.rcImage,
    required this.pcImage,
    required this.brandName,
    required this.carType,
     this.availability=true,
  });

  @HiveField(0)
  late String carName;

  @HiveField(1)
  late String vehicleNo;

  @HiveField(2)
  late int kmDriven;

  @HiveField(3)
  late int seatCapacity;

  @HiveField(4)
  late int cubicCapacity;

  @HiveField(5)
  late int rcNo;

  @HiveField(6)
  late DateTime pollutionDate;

  @HiveField(7)
  late String fuelType;

  @HiveField(8)
  late int amtPerDay;

  @HiveField(9)
  late String carImage;

  @HiveField(10)
  late String brandName;

  @HiveField(11)
  late String carType;

  @HiveField(12)
  late String rcImage;

  @HiveField(13)
  late String pcImage;


  @HiveField(14)
  late bool availability;
}
