import 'package:json_annotation/json_annotation.dart';

part 'paytmAmountData.g.dart';

@JsonSerializable()
class PaytmAmountData {
  PaytmAmountData({
    required this.TXN_AMOUNT,
  });

  String? TXN_AMOUNT;

  factory PaytmAmountData.fromJson(Map<String, dynamic> json) =>
      _$PaytmAmountDataFromJson(json);

  Map<String, dynamic> toJson() => _$PaytmAmountDataToJson(this);
}
