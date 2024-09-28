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
      username: fields[0] as String,
      password: fields[1] as String,
      shopname: fields[2] as String,
      shopownername: fields[3] as String,
      shoplocation: fields[4] as String,
      phonenumer: fields[5] as int,
      email: fields[6] as String,
      image: fields[7] as String,
    );
  }

  @override
  void write(BinaryWriter writer, Auth obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.username)
      ..writeByte(1)
      ..write(obj.password)
      ..writeByte(2)
      ..write(obj.shopname)
      ..writeByte(3)
      ..write(obj.shopownername)
      ..writeByte(4)
      ..write(obj.shoplocation)
      ..writeByte(5)
      ..write(obj.phonenumer)
      ..writeByte(6)
      ..write(obj.email)
      ..writeByte(7)
      ..write(obj.image);
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
