// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PlayermodelAdapter extends TypeAdapter<Playermodel> {
  @override
  final int typeId = 1;

  @override
  Playermodel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Playermodel(
      name: fields[0] as String,
      songid: (fields[1] as List).cast<int>(),
    );
  }

  @override
  void write(BinaryWriter writer, Playermodel obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.songid);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PlayermodelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
