import 'package:json_annotation/json_annotation.dart';

part 'data.g.dart';

@JsonSerializable()
class LoginPostRequest {
  LoginPostRequest({
    this.username,
    this.password,
  });

  String? username;
  String? password;

  factory LoginPostRequest.fromJson(Map<String, dynamic> json) =>
      _$LoginPostRequestFromJson(json);

  Map<String, dynamic> toJson() => _$LoginPostRequestToJson(this);
}

@JsonSerializable()
class AuthResult {
  String? JWT;
  String? qr_code;
  int? user_id;
  String? name;
  String? email;
  String? phone;
  String? referral_code;
  String? bitsian_id;
  String? error;

  AuthResult({
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

  factory AuthResult.fromJson(Map<String, dynamic> json) =>
      _$AuthResultFromJson(json);

  Map<String, dynamic> toJson() => _$AuthResultToJson(this);
}

//flutter pub run build_runner build --delete-conflicting-outputs
