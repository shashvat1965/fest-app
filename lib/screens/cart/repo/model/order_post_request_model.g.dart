// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_post_request_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MenuItemForPostRequest _$MenuItemForPostRequestFromJson(
        Map<String, dynamic> json) =>
    MenuItemForPostRequest(
      menuItemId: json['menuItemId'] as String,
      menuItemQuantity: json['menuItemQuantity'] as int,
    );

Map<String, dynamic> _$MenuItemForPostRequestToJson(
        MenuItemForPostRequest instance) =>
    <String, dynamic>{
      'menuItemQuantity': instance.menuItemQuantity,
      'menuItemId': instance.menuItemId,
    };
