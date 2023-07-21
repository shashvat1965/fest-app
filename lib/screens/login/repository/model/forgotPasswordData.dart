import 'package:json_annotation/json_annotation.dart';

part 'forgotPasswordData.g.dart';

@JsonSerializable()
class ForgotPasswordPostRequest {
  ForgotPasswordPostRequest({
    this.email,
  });

  String? email;

  factory ForgotPasswordPostRequest.fromJson(Map<String, dynamic> json) =>
      _$ForgotPasswordPostRequestFromJson(json);

  Map<String, dynamic> toJson() => _$ForgotPasswordPostRequestToJson(this);
}

@JsonSerializable()
class ForgotPasswordResponse {
  String? display_message;

  ForgotPasswordResponse({
    this.display_message,
  });

  factory ForgotPasswordResponse.fromJson(Map<String, dynamic> json) =>
      _$ForgotPasswordResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ForgotPasswordResponseToJson(this);
}
