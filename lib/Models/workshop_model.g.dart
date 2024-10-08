// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'workshop_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class WorKShopModelAdapter extends TypeAdapter<WorKShopModel> {
  @override
  final int typeId = 4;

  @override
  WorKShopModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return WorKShopModel(
      car: fields[0] as Cars,
      dateTime: fields[1] as DateTime,
      serviceAmount: fields[2] as int,
    );
  }

  @override
  void write(BinaryWriter writer, WorKShopModel obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.car)
      ..writeByte(1)
      ..write(obj.dateTime)
      ..writeByte(2)
      ..write(obj.serviceAmount);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is WorKShopModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
