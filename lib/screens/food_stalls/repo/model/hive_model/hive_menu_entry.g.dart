// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hive_menu_entry.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class HiveMenuEntryAdapter extends TypeAdapter<HiveMenuEntry> {
  @override
  final int typeId = 1;

  @override
  HiveMenuEntry read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return HiveMenuEntry(
      price: fields[0] as int,
      isVeg: fields[5] as bool,
      menuItemName: fields[4] as String,
      FoodStall: fields[1] as String,
      quantity: fields[2] as int,
      FoodStallId: fields[3] as int,
    );
  }

  @override
  void write(BinaryWriter writer, HiveMenuEntry obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.price)
      ..writeByte(1)
      ..write(obj.FoodStall)
      ..writeByte(2)
      ..write(obj.quantity)
      ..writeByte(3)
      ..write(obj.FoodStallId)
      ..writeByte(4)
      ..write(obj.menuItemName)
      ..writeByte(5)
      ..write(obj.isVeg);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HiveMenuEntryAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
