// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'car_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CarsAdapter extends TypeAdapter<Cars> {
  @override
  final int typeId = 1;

  @override
  Cars read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Cars(
      carName: fields[0] as String,
      vehicleNo: fields[1] as String,
      kmDriven: fields[2] as int,
      seatCapacity: fields[3] as int,
      cubicCapacity: fields[4] as int,
      rcNo: fields[5] as int,
      pollutionDate: fields[6] as DateTime,
      fuelType: fields[7] as String,
      amtPerDay: fields[8] as int,
      carImage: fields[9] as String,
      rcImage: fields[12] as String,
      pcImage: fields[13] as String,
      brandName: fields[10] as String,
      carType: fields[11] as String,
      availability: fields[14] as bool,
      servicedDate: fields[15] as DateTime?,
      serviceAmount: fields[16] as int,
    );
  }

  @override
  void write(BinaryWriter writer, Cars obj) {
    writer
      ..writeByte(17)
      ..writeByte(0)
      ..write(obj.carName)
      ..writeByte(1)
      ..write(obj.vehicleNo)
      ..writeByte(2)
      ..write(obj.kmDriven)
      ..writeByte(3)
      ..write(obj.seatCapacity)
      ..writeByte(4)
      ..write(obj.cubicCapacity)
      ..writeByte(5)
      ..write(obj.rcNo)
      ..writeByte(6)
      ..write(obj.pollutionDate)
      ..writeByte(7)
      ..write(obj.fuelType)
      ..writeByte(8)
      ..write(obj.amtPerDay)
      ..writeByte(9)
      ..write(obj.carImage)
      ..writeByte(10)
      ..write(obj.brandName)
      ..writeByte(11)
      ..write(obj.carType)
      ..writeByte(12)
      ..write(obj.rcImage)
      ..writeByte(13)
      ..write(obj.pcImage)
      ..writeByte(14)
      ..write(obj.availability)
      ..writeByte(15)
      ..write(obj.servicedDate)
      ..writeByte(16)
      ..write(obj.serviceAmount);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CarsAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
