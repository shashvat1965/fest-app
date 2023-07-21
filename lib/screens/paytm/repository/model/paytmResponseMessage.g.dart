// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'paytmResponseMessage.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PaytmResponseMessage _$PaytmResponseMessageFromJson(
        Map<String, dynamic> json) =>
    PaytmResponseMessage(
      message: json['message'] as String?,
      display_message: json['display_message'] as String?,
    );

Map<String, dynamic> _$PaytmResponseMessageToJson(
        PaytmResponseMessage instance) =>
    <String, dynamic>{
      'message': instance.message,
      'display_message': instance.display_message,
    };
