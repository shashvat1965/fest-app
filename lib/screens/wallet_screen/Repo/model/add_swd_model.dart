import 'package:json_annotation/json_annotation.dart';

part 'add_swd_model.g.dart';

@JsonSerializable()
class AddSwdPostRequestModel {
  int? amount;

  AddSwdPostRequestModel({required this.amount});

  factory AddSwdPostRequestModel.fromJson(Map<String, dynamic> json) =>
      _$AddSwdPostRequestModelFromJson(json);

  Map<String, dynamic> toJson() => _$AddSwdPostRequestModelToJson(this);
}
