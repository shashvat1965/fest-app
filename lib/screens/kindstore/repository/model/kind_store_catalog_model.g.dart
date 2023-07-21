// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'kind_store_catalog_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

KindStoreResult _$KindStoreResultFromJson(Map<String, dynamic> json) =>
    KindStoreResult(
      items_details: (json['items_details'] as List<dynamic>?)
          ?.map((e) => KindStoreItem.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$KindStoreResultToJson(KindStoreResult instance) =>
    <String, dynamic>{
      'items_details': instance.items_details,
    };

KindStoreItem _$KindStoreItemFromJson(Map<String, dynamic> json) =>
    KindStoreItem(
      name: json['name'] as String?,
      price: json['price'] as int?,
      is_available: json['is_available'] as bool?,
      image: json['image'] as String?,
    );

Map<String, dynamic> _$KindStoreItemToJson(KindStoreItem instance) =>
    <String, dynamic>{
      'name': instance.name,
      'price': instance.price,
      'is_available': instance.is_available,
      'image': instance.image,
    };
