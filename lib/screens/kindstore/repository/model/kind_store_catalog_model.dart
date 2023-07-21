import 'package:json_annotation/json_annotation.dart';

part "kind_store_catalog_model.g.dart";

@JsonSerializable()
class KindStoreResult {
  KindStoreResult({
    this.items_details,
  });

  List<KindStoreItem>? items_details;

  factory KindStoreResult.fromJson(Map<String, dynamic> json) =>
      _$KindStoreResultFromJson(json);
  Map<String, dynamic> toJson() => _$KindStoreResultToJson(this);
}

@JsonSerializable()
class KindStoreItem {
  KindStoreItem({
    this.name,
    this.price,
    this.is_available,
    this.image,
  });

  String? name;
  int? price;
  bool? is_available;
  String? image;

  factory KindStoreItem.fromJson(Map<String, dynamic> json) =>
      _$KindStoreItemFromJson(json);
  Map<String, dynamic> toJson() => _$KindStoreItemToJson(this);
}
