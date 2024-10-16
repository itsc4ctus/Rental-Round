// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class AuthAdapter extends TypeAdapter<Auth> {
  @override
  final int typeId = 0;

  @override
  Auth read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Auth(
      shopname: fields[1] as String,
      shopownername: fields[2] as String,
      shoplocation: fields[3] as String,
      phonenumer: fields[4] as int,
      email: fields[5] as String,
      image: fields[6] as String,
      status: fields[7] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, Auth obj) {
    writer
      ..writeByte(7)
      ..writeByte(1)
      ..write(obj.shopname)
      ..writeByte(2)
      ..write(obj.shopownername)
      ..writeByte(3)
      ..write(obj.shoplocation)
      ..writeByte(4)
      ..write(obj.phonenumer)
      ..writeByte(5)
      ..write(obj.email)
      ..writeByte(6)
      ..write(obj.image)
      ..writeByte(7)
      ..write(obj.status);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AuthAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
