// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'showsData.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AllShowsData _$AllShowsDataFromJson(Map<String, dynamic> json) => AllShowsData(
      (json['shows'] as List<dynamic>?)
          ?.map((e) => StoreItemData.fromJson(e as Map<String, dynamic>))
          .toList(),
      (json['combos'] as List<dynamic>?)
          ?.map((e) => CombosData.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$AllShowsDataToJson(AllShowsData instance) =>
    <String, dynamic>{
      'shows': instance.shows,
      'combos': instance.combos,
    };

StoreItemData _$StoreItemDataFromJson(Map<String, dynamic> json) =>
    StoreItemData(
      id: json['id'] as int?,
      available: json['available'] as bool?,
      price: json['price'] as int?,
      venue: json['venue'] as String?,
      timestamp: json['timestamp'] as String?,
      name: json['name'] as String?,
      allow_participants: json['allow_participants'] as bool?,
      allow_bitsians: json['allow_bitsians'] as bool?,
      is_merch: json['is_merch'] as bool?,
      image_url:
          (json['image_url'] as List<dynamic>).map((e) => e as String).toList(),
      tickets_available: json['tickets_available'] as bool?,
    );

Map<String, dynamic> _$StoreItemDataToJson(StoreItemData instance) =>
    <String, dynamic>{
      'id': instance.id,
      'price': instance.price,
      'name': instance.name,
      'venue': instance.venue,
      'image_url': instance.image_url,
      'timestamp': instance.timestamp,
      'allow_bitsians': instance.allow_bitsians,
      'allow_participants': instance.allow_participants,
      'tickets_available': instance.tickets_available,
      'is_merch': instance.is_merch,
      'available': instance.available,
    };

CombosData _$CombosDataFromJson(Map<String, dynamic> json) => CombosData(
      id: json['id'] as int?,
      price: json['price'] as int?,
      name: json['name'] as String?,
      allow_participants: json['allow_participants'] as bool?,
      allow_bitsians: json['allow_bitsians'] as bool?,
      shows: (json['shows'] as List<dynamic>?)
          ?.map((e) => Shows.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$CombosDataToJson(CombosData instance) =>
    <String, dynamic>{
      'id': instance.id,
      'price': instance.price,
      'name': instance.name,
      'allow_bitsians': instance.allow_bitsians,
      'allow_participants': instance.allow_participants,
      'shows': instance.shows,
    };

Shows _$ShowsFromJson(Map<String, dynamic> json) => Shows(
      id: json['id'] as int?,
      name: json['name'] as String?,
    );

Map<String, dynamic> _$ShowsToJson(Shows instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
    };
