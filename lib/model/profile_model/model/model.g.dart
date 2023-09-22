// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ProfilemodelAdapter extends TypeAdapter<Profilemodel> {
  @override
  final int typeId = 2;

  @override
  Profilemodel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Profilemodel(
      userimage: fields[1] as String,
      username: fields[0] as String,
      id: fields[2] as int,
    );
  }

  @override
  void write(BinaryWriter writer, Profilemodel obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.username)
      ..writeByte(1)
      ..write(obj.userimage)
      ..writeByte(2)
      ..write(obj.id);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ProfilemodelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
