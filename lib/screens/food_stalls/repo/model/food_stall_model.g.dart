// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'food_stall_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class FoodStallListAdapter extends TypeAdapter<FoodStallList> {
  @override
  final int typeId = 4;

  @override
  FoodStallList read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return FoodStallList(
      (fields[0] as List?)?.cast<FoodStall>(),
    );
  }

  @override
  void write(BinaryWriter writer, FoodStallList obj) {
    writer
      ..writeByte(1)
      ..writeByte(0)
      ..write(obj.foodStalls);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FoodStallListAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class FoodStallAdapter extends TypeAdapter<FoodStall> {
  @override
  final int typeId = 5;

  @override
  FoodStall read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return FoodStall(
      name: fields[0] as String,
      image_url: fields[1] as String,
      menu_image_url: fields[9] as String?,
      id: fields[2] as int,
      closed: fields[3] as bool,
      description: fields[6] as String,
      max_price: fields[5] as int,
      min_price: fields[4] as int,
      tags: fields[7] as String,
      menu: (fields[8] as List).cast<MenuItem>(),
    );
  }

  @override
  void write(BinaryWriter writer, FoodStall obj) {
    writer
      ..writeByte(10)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.image_url)
      ..writeByte(2)
      ..write(obj.id)
      ..writeByte(3)
      ..write(obj.closed)
      ..writeByte(4)
      ..write(obj.min_price)
      ..writeByte(5)
      ..write(obj.max_price)
      ..writeByte(6)
      ..write(obj.description)
      ..writeByte(7)
      ..write(obj.tags)
      ..writeByte(8)
      ..write(obj.menu)
      ..writeByte(9)
      ..write(obj.menu_image_url);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FoodStallAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class MenuItemAdapter extends TypeAdapter<MenuItem> {
  @override
  final int typeId = 6;

  @override
  MenuItem read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return MenuItem(
      name: fields[1] as String,
      description: fields[3] as String,
      id: fields[5] as int,
      is_available: fields[4] as bool,
      price: fields[0] as int,
      is_combo: fields[7] as bool,
      is_veg: fields[2] as bool,
      vendor_id: fields[6] as int,
    );
  }

  @override
  void write(BinaryWriter writer, MenuItem obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.price)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.is_veg)
      ..writeByte(3)
      ..write(obj.description)
      ..writeByte(4)
      ..write(obj.is_available)
      ..writeByte(5)
      ..write(obj.id)
      ..writeByte(6)
      ..write(obj.vendor_id)
      ..writeByte(7)
      ..write(obj.is_combo);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MenuItemAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FoodStall _$FoodStallFromJson(Map<String, dynamic> json) => FoodStall(
      name: json['name'] as String,
      image_url: json['image_url'] as String,
      menu_image_url: json['menu_image_url'] as String?,
      id: json['id'] as int,
      closed: json['closed'] as bool,
      description: json['description'] as String,
      max_price: json['max_price'] as int,
      min_price: json['min_price'] as int,
      tags: json['tags'] as String,
      menu: (json['menu'] as List<dynamic>)
          .map((e) => MenuItem.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$FoodStallToJson(FoodStall instance) => <String, dynamic>{
      'name': instance.name,
      'image_url': instance.image_url,
      'id': instance.id,
      'closed': instance.closed,
      'min_price': instance.min_price,
      'max_price': instance.max_price,
      'description': instance.description,
      'tags': instance.tags,
      'menu': instance.menu,
      'menu_image_url': instance.menu_image_url,
    };

MenuItem _$MenuItemFromJson(Map<String, dynamic> json) => MenuItem(
      name: json['name'] as String,
      description: json['description'] as String,
      id: json['id'] as int,
      is_available: json['is_available'] as bool,
      price: json['price'] as int,
      is_combo: json['is_combo'] as bool,
      is_veg: json['is_veg'] as bool,
      vendor_id: json['vendor_id'] as int,
    );

Map<String, dynamic> _$MenuItemToJson(MenuItem instance) => <String, dynamic>{
      'price': instance.price,
      'name': instance.name,
      'is_veg': instance.is_veg,
      'description': instance.description,
      'is_available': instance.is_available,
      'id': instance.id,
      'vendor_id': instance.vendor_id,
      'is_combo': instance.is_combo,
    };
