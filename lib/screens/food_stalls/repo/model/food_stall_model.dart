import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';

part 'food_stall_model.g.dart';

@HiveType(typeId: 4)
class FoodStallList extends HiveObject {
  FoodStallList(this.foodStalls);

  @HiveField(0)
  List<FoodStall>? foodStalls;
}

@HiveType(typeId: 5)
@JsonSerializable()
class FoodStall {
  @HiveField(0)
  String name;
  @HiveField(1)
  String image_url;
  @HiveField(2)
  int id;
  @HiveField(3)
  bool closed;
  @HiveField(4)
  int min_price;
  @HiveField(5)
  int max_price;
  @HiveField(6)
  String description;
  @HiveField(7)
  String tags;
  @HiveField(8)
  List<MenuItem> menu;
  @HiveField(9)
  String? menu_image_url;

  FoodStall(
      {required this.name,
      required this.image_url,
      required this.menu_image_url,
      required this.id,
      required this.closed,
      required this.description,
      required this.max_price,
      required this.min_price,
      required this.tags,
      required this.menu});

  factory FoodStall.fromJson(Map<String, dynamic> json) =>
      _$FoodStallFromJson(json);

  Map<String, dynamic> toJson() => _$FoodStallToJson(this);
}

@HiveType(typeId: 6)
@JsonSerializable()
class MenuItem {
  @HiveField(0)
  int price;
  @HiveField(1)
  String name;
  @HiveField(2)
  bool is_veg;
  @HiveField(3)
  String description;
  @HiveField(4)
  bool is_available;
  @HiveField(5)
  int id;
  @HiveField(6)
  int vendor_id;
  @HiveField(7)
  bool is_combo;

  MenuItem(
      {required this.name,
      required this.description,
      required this.id,
      required this.is_available,
      required this.price,
      required this.is_combo,
      required this.is_veg,
      required this.vendor_id});

  factory MenuItem.fromJson(Map<String, dynamic> json) =>
      _$MenuItemFromJson(json);

  Map<String, dynamic> toJson() => _$MenuItemToJson(this);
}
