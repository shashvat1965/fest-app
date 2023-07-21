import 'package:json_annotation/json_annotation.dart';

part 'qr_to_id.g.dart';

@JsonSerializable()
class QrToIdModel {
  int? id;
  String message;

  QrToIdModel({required this.id, required this.message});

  factory QrToIdModel.fromJson(Map<String, dynamic> json) =>
      _$QrToIdModelFromJson(json);

  Map<String, dynamic> toJson() => _$QrToIdModelToJson(this);
}
