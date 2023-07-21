// To parse this JSON data, do
//
//     final miscEvent = miscEventFromJson(jsonString);
import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';

part 'miscEventResult.g.dart';

@JsonSerializable()
class MiscEventCategory {
  MiscEventCategory({
    this.category_name,
    this.events,
  });

  String? category_name;
  List<MiscEventData>? events;

  factory MiscEventCategory.fromJson(Map<String, dynamic> json) =>
      _$MiscEventCategoryFromJson(json);
}

@HiveType(typeId: 2)
class MiscEventList extends HiveObject {
  MiscEventList(this.events);
  @HiveField(0)
  List<MiscEventData>? events;
}

@HiveType(typeId: 3)
@JsonSerializable()
class MiscEventData extends HiveObject {
  MiscEventData(
      {this.id,
      this.name,
      this.about,
      this.organiser,
      this.time, //like TBA will be same as backend puts it
      this.date_time, // to get date
      this.venue_name});

  @HiveField(0)
  int? id;
  @HiveField(1)
  String? name;
  @HiveField(2)
  String? organiser;
  @HiveField(3)
  String? time;
  @HiveField(4)
  String? date_time;
  @HiveField(5)
  String? venue_name;
  @HiveField(6)
  String? about;

  factory MiscEventData.fromJson(Map<String, dynamic> json) =>
      _$MiscEventDataFromJson(json);
}
