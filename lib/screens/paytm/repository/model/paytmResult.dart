import 'package:json_annotation/json_annotation.dart';

part 'paytmResult.g.dart';

@JsonSerializable()
class PaytmResult {
  PaymentDict payment_dict;
  String checksum;
  String order_id;
  String txntoken;
  String mid;
  String cb_url;

  PaytmResult(
      {required this.payment_dict,
      required this.checksum,
      required this.order_id,
      required this.txntoken,
      required this.mid,
      required this.cb_url});

  factory PaytmResult.fromJson(Map<String, dynamic> json) =>
      _$PaytmResultFromJson(json);

  Map<String, dynamic> toJson() => _$PaytmResultToJson(this);
}

@JsonSerializable()
class PaymentDict {
  String? MID;
  String? CUST_ID;
  String? ORDER_ID;
  String? EMAIL;
  String? CHANNEL_ID;
  String? TXN_AMOUNT;
  String? WEBSITE;
  String? CALLBACK_URL;
  String? INDUSTRY_TYPE_ID;

  PaymentDict(
      {this.MID,
      this.CUST_ID,
      this.ORDER_ID,
      this.EMAIL,
      this.CHANNEL_ID,
      this.TXN_AMOUNT,
      this.WEBSITE,
      this.CALLBACK_URL,
      this.INDUSTRY_TYPE_ID});

  factory PaymentDict.fromJson(Map<String, dynamic> json) =>
      _$PaymentDictFromJson(json);

  Map<String, dynamic> toJson() => _$PaymentDictToJson(this);
}
