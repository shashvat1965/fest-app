// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'forgotPasswordData.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ForgotPasswordPostRequest _$ForgotPasswordPostRequestFromJson(
        Map<String, dynamic> json) =>
    ForgotPasswordPostRequest(
      email: json['email'] as String?,
    );

Map<String, dynamic> _$ForgotPasswordPostRequestToJson(
        ForgotPasswordPostRequest instance) =>
    <String, dynamic>{
      'email': instance.email,
    };

ForgotPasswordResponse _$ForgotPasswordResponseFromJson(
        Map<String, dynamic> json) =>
    ForgotPasswordResponse(
      display_message: json['display_message'] as String?,
    );

Map<String, dynamic> _$ForgotPasswordResponseToJson(
        ForgotPasswordResponse instance) =>
    <String, dynamic>{
      'display_message': instance.display_message,
    };
