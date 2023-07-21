import 'package:json_annotation/json_annotation.dart';

part 'paytmResponse.g.dart';

@JsonSerializable()
class PaytmResponse {
  String CURRENCY,
      GATEWAYNAME,
      RESPMSG,
      BANKNAME,
      PAYMENTMODE,
      MID,
      RESPCODE,
      TXNAMOUNT,
      TXNID,
      ORDERID,
      BANKTXNID,
      STATUS,
      TXNDATE,
      CHECKSUMHASH;

  PaytmResponse({
    required this.CURRENCY,
    required this.GATEWAYNAME,
    required this.RESPMSG,
    required this.BANKNAME,
    required this.PAYMENTMODE,
    required this.MID,
    required this.RESPCODE,
    required this.TXNAMOUNT,
    required this.TXNID,
    required this.ORDERID,
    required this.BANKTXNID,
    required this.STATUS,
    required this.TXNDATE,
    required this.CHECKSUMHASH,
  });

  //
  factory PaytmResponse.fromJson(Map<String, dynamic> json) =>
      _$PaytmResponseFromJson(json);

  Map<String, dynamic> toJson() => _$PaytmResponseToJson(this);
}
