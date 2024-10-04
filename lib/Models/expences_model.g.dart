// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'expences_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class expensesAdapter extends TypeAdapter<expenses> {
  @override
  final int typeId = 3;

  @override
  expenses read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return expenses(
      expenceType: fields[0] as String,
      expenceAmt: fields[1] as int,
      dateTime: fields[2] as DateTime,
      id: fields[3] as String,
    );
  }

  @override
  void write(BinaryWriter writer, expenses obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.expenceType)
      ..writeByte(1)
      ..write(obj.expenceAmt)
      ..writeByte(2)
      ..write(obj.dateTime)
      ..writeByte(3)
      ..write(obj.id);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is expensesAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
