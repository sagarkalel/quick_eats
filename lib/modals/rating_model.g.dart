// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'rating_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class RatingModelAdapter extends TypeAdapter<RatingModel> {
  @override
  final int typeId = 2;

  @override
  RatingModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return RatingModel(
      rating: fields[0] as double,
      uid: fields[1] as String,
    );
  }

  @override
  void write(BinaryWriter writer, RatingModel obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.rating)
      ..writeByte(1)
      ..write(obj.uid);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is RatingModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
