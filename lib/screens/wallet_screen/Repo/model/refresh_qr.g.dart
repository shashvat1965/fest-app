// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'refresh_qr.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RefreshQrPostModel _$RefreshQrPostModelFromJson(Map<String, dynamic> json) =>
    RefreshQrPostModel(
      id: json['id'] as int,
    );

Map<String, dynamic> _$RefreshQrPostModelToJson(RefreshQrPostModel instance) =>
    <String, dynamic>{
      'id': instance.id,
    };

RefreshQrResponseModel _$RefreshQrResponseModelFromJson(
        Map<String, dynamic> json) =>
    RefreshQrResponseModel(
      message: json['message'] as String?,
      qr_code: json['qr_code'] as String,
    );

Map<String, dynamic> _$RefreshQrResponseModelToJson(
        RefreshQrResponseModel instance) =>
    <String, dynamic>{
      'message': instance.message,
      'qr_code': instance.qr_code,
    };
