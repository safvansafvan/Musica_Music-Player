// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ProfilemodelAdapter extends TypeAdapter<Profilemodel> {
  @override
  final int typeId = 1;

  @override
  Profilemodel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Profilemodel(
      userimage: fields[1] as dynamic,
      username: fields[0] as dynamic,
    );
  }

  @override
  void write(BinaryWriter writer, Profilemodel obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.username)
      ..writeByte(1)
      ..write(obj.userimage);
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
