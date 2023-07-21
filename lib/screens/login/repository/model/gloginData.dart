import 'package:json_annotation/json_annotation.dart';

part 'gloginData.g.dart';

@JsonSerializable()
class GoogleLoginPostRequest {
  GoogleLoginPostRequest({
    this.id_token,
  });

  String? id_token;

  factory GoogleLoginPostRequest.fromJson(Map<String, dynamic> json) =>
      _$GoogleLoginPostRequestFromJson(json);

  Map<String, dynamic> toJson() => _$GoogleLoginPostRequestToJson(this);
}

@JsonSerializable()
class GoogleAuthResult {
  String? JWT;
  String? qr_code;
  int? user_id;
  String? name;
  String? email;
  String? phone;
  String? referral_code;
  String? bitsian_id;
  String? error;

  GoogleAuthResult({
    this.JWT,
    this.qr_code,
    this.user_id,
    this.name,
    this.email,
    this.phone,
    this.referral_code,
    this.bitsian_id,
    this.error,
  });

  factory GoogleAuthResult.fromJson(Map<String, dynamic> json) =>
      _$GoogleAuthResultFromJson(json);

  Map<String, dynamic> toJson() => _$GoogleAuthResultToJson(this);
}
