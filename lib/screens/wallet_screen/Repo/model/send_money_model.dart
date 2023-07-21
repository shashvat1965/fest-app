import 'package:json_annotation/json_annotation.dart';

part 'send_money_model.g.dart';

@JsonSerializable()
class SendMoneyThroughIdModel {
  int id;
  int amount;

  SendMoneyThroughIdModel({
    required this.id,
    required this.amount,
  });

  factory SendMoneyThroughIdModel.fromJson(Map<String, dynamic> json) =>
      _$SendMoneyThroughIdModelFromJson(json);

  Map<String, dynamic> toJson() => _$SendMoneyThroughIdModelToJson(this);
}
