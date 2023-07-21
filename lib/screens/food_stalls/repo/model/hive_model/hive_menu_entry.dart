import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';

part 'hive_menu_entry.g.dart';

@HiveType(typeId: 1)
class HiveMenuEntry {
  HiveMenuEntry(
      {required this.price,
      required this.isVeg,
      required this.menuItemName,
      required this.FoodStall,
      required this.quantity,
      required this.FoodStallId});

  @HiveField(0)
  int price;

  @HiveField(1)
  String FoodStall;

  @HiveField(2)
  int quantity;

  @HiveField(3)
  int FoodStallId;

  @HiveField(4)
  String menuItemName;

  @HiveField(5)
  bool isVeg;
}
