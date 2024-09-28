// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'status_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class statusAdapter extends TypeAdapter<status> {
  @override
  final int typeId = 2;

  @override
  status read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return status(
      cName: fields[0] as String,
      cId: fields[1] as String,
      startDate: fields[2] as DateTime,
      endDate: fields[3] as DateTime,
      selectedCar: fields[4] as Cars,
      advAmount: fields[5] as int,
      extraAmount: fields[7] as int,
      proofImage: fields[8] as String,
      totalAmount: fields[6] as int,
      amountReceived: fields[9] as int,
    );
  }

  @override
  void write(BinaryWriter writer, status obj) {
    writer
      ..writeByte(10)
      ..writeByte(0)
      ..write(obj.cName)
      ..writeByte(1)
      ..write(obj.cId)
      ..writeByte(2)
      ..write(obj.startDate)
      ..writeByte(3)
      ..write(obj.endDate)
      ..writeByte(4)
      ..write(obj.selectedCar)
      ..writeByte(5)
      ..write(obj.advAmount)
      ..writeByte(6)
      ..write(obj.totalAmount)
      ..writeByte(7)
      ..write(obj.extraAmount)
      ..writeByte(8)
      ..write(obj.proofImage)
      ..writeByte(9)
      ..write(obj.amountReceived);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is statusAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
