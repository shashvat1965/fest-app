// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'miscEventResult.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class MiscEventListAdapter extends TypeAdapter<MiscEventList> {
  @override
  final int typeId = 2;

  @override
  MiscEventList read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return MiscEventList(
      (fields[0] as List?)?.cast<MiscEventData>(),
    );
  }

  @override
  void write(BinaryWriter writer, MiscEventList obj) {
    writer
      ..writeByte(1)
      ..writeByte(0)
      ..write(obj.events);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MiscEventListAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class MiscEventDataAdapter extends TypeAdapter<MiscEventData> {
  @override
  final int typeId = 3;

  @override
  MiscEventData read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return MiscEventData(
      id: fields[0] as int?,
      name: fields[1] as String?,
      about: fields[6] as String?,
      organiser: fields[2] as String?,
      time: fields[3] as String?,
      date_time: fields[4] as String?,
      venue_name: fields[5] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, MiscEventData obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.organiser)
      ..writeByte(3)
      ..write(obj.time)
      ..writeByte(4)
      ..write(obj.date_time)
      ..writeByte(5)
      ..write(obj.venue_name)
      ..writeByte(6)
      ..write(obj.about);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MiscEventDataAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MiscEventCategory _$MiscEventCategoryFromJson(Map<String, dynamic> json) =>
    MiscEventCategory(
      category_name: json['category_name'] as String?,
      events: (json['events'] as List<dynamic>?)
          ?.map((e) => MiscEventData.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$MiscEventCategoryToJson(MiscEventCategory instance) =>
    <String, dynamic>{
      'category_name': instance.category_name,
      'events': instance.events,
    };

MiscEventData _$MiscEventDataFromJson(Map<String, dynamic> json) =>
    MiscEventData(
      id: json['id'] as int?,
      name: json['name'] as String?,
      about: json['about'] as String?,
      organiser: json['organiser'] as String?,
      time: json['time'] as String?,
      date_time: json['date_time'] as String?,
      venue_name: json['venue_name'] as String?,
    );

Map<String, dynamic> _$MiscEventDataToJson(MiscEventData instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'organiser': instance.organiser,
      'time': instance.time,
      'date_time': instance.date_time,
      'venue_name': instance.venue_name,
      'about': instance.about,
    };
