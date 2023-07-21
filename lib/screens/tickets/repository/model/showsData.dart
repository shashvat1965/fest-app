import 'package:json_annotation/json_annotation.dart';

part 'showsData.g.dart';

@JsonSerializable()
class AllShowsData {
  AllShowsData(this.shows, this.combos);

  List<StoreItemData>? shows = [];
  List<CombosData>? combos = [];

  factory AllShowsData.fromJson(Map<String, dynamic> json) =>
      _$AllShowsDataFromJson(json);
}

@JsonSerializable()
class StoreItemData {
  int? id;
  int? price;
  String? name;
  String? venue;
  List<String> image_url;
  String? timestamp;
  bool? allow_bitsians,
      allow_participants,
      tickets_available,
      is_merch,
      available;

  StoreItemData({
    this.id,
    this.available,
    this.price,
    this.venue,
    this.timestamp,
    this.name,
    this.allow_participants,
    this.allow_bitsians,
    this.is_merch,
    required this.image_url,
    this.tickets_available,
  });

  factory StoreItemData.fromJson(Map<String, dynamic> json) =>
      _$StoreItemDataFromJson(json);
}

@JsonSerializable()
class CombosData {
  int? id;
  int? price;
  String? name;
  bool? allow_bitsians, allow_participants;
  List<Shows>? shows;

  CombosData({
    this.id,
    this.price,
    this.name,
    this.allow_participants,
    this.allow_bitsians,
    this.shows,
  });

  factory CombosData.fromJson(Map<String, dynamic> json) =>
      _$CombosDataFromJson(json);
}

@JsonSerializable()
class Shows {
  int? id;
  String? name;

  Shows({
    this.id,
    this.name,
  });

  factory Shows.fromJson(Map<String, dynamic> json) => _$ShowsFromJson(json);
}

class MerchCarouselItem {
  List<StoreItemData>? merch;
  String imageAsset;
  MerchCarouselItem({required this.imageAsset, this.merch});
}
