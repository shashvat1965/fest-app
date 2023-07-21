// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'gloginData.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GoogleLoginPostRequest _$GoogleLoginPostRequestFromJson(
        Map<String, dynamic> json) =>
    GoogleLoginPostRequest(
      id_token: json['id_token'] as String?,
    );

Map<String, dynamic> _$GoogleLoginPostRequestToJson(
        GoogleLoginPostRequest instance) =>
    <String, dynamic>{
      'id_token': instance.id_token,
    };

GoogleAuthResult _$GoogleAuthResultFromJson(Map<String, dynamic> json) =>
    GoogleAuthResult(
      JWT: json['JWT'] as String?,
      qr_code: json['qr_code'] as String?,
      user_id: json['user_id'] as int?,
      name: json['name'] as String?,
      email: json['email'] as String?,
      phone: json['phone'] as String?,
      referral_code: json['referral_code'] as String?,
      bitsian_id: json['bitsian_id'] as String?,
      error: json['error'] as String?,
    );

Map<String, dynamic> _$GoogleAuthResultToJson(GoogleAuthResult instance) =>
    <String, dynamic>{
      'JWT': instance.JWT,
      'qr_code': instance.qr_code,
      'user_id': instance.user_id,
      'name': instance.name,
      'email': instance.email,
      'phone': instance.phone,
      'referral_code': instance.referral_code,
      'bitsian_id': instance.bitsian_id,
      'error': instance.error,
    };
