import 'package:json_annotation/json_annotation.dart';

part 'refresh_qr.g.dart';

@JsonSerializable()
class RefreshQrPostModel {
  RefreshQrPostModel({
    required this.id,
  });

  int id;

  factory RefreshQrPostModel.fromJson(Map<String, dynamic> json) =>
      _$RefreshQrPostModelFromJson(json);

  Map<String, dynamic> toJson() => _$RefreshQrPostModelToJson(this);
}

@JsonSerializable()
class RefreshQrResponseModel {
  String? message;
  String qr_code;

  RefreshQrResponseModel({required this.message, required this.qr_code});

  factory RefreshQrResponseModel.fromJson(Map<String, dynamic> json) =>
      _$RefreshQrResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$RefreshQrResponseModelToJson(this);
}
