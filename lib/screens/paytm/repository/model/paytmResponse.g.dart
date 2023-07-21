// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'paytmResponse.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PaytmResponse _$PaytmResponseFromJson(Map<String, dynamic> json) =>
    PaytmResponse(
      CURRENCY: json['CURRENCY'] as String,
      GATEWAYNAME: json['GATEWAYNAME'] as String,
      RESPMSG: json['RESPMSG'] as String,
      BANKNAME: json['BANKNAME'] as String,
      PAYMENTMODE: json['PAYMENTMODE'] as String,
      MID: json['MID'] as String,
      RESPCODE: json['RESPCODE'] as String,
      TXNAMOUNT: json['TXNAMOUNT'] as String,
      TXNID: json['TXNID'] as String,
      ORDERID: json['ORDERID'] as String,
      BANKTXNID: json['BANKTXNID'] as String,
      STATUS: json['STATUS'] as String,
      TXNDATE: json['TXNDATE'] as String,
      CHECKSUMHASH: json['CHECKSUMHASH'] as String,
    );

Map<String, dynamic> _$PaytmResponseToJson(PaytmResponse instance) =>
    <String, dynamic>{
      'CURRENCY': instance.CURRENCY,
      'GATEWAYNAME': instance.GATEWAYNAME,
      'RESPMSG': instance.RESPMSG,
      'BANKNAME': instance.BANKNAME,
      'PAYMENTMODE': instance.PAYMENTMODE,
      'MID': instance.MID,
      'RESPCODE': instance.RESPCODE,
      'TXNAMOUNT': instance.TXNAMOUNT,
      'TXNID': instance.TXNID,
      'ORDERID': instance.ORDERID,
      'BANKTXNID': instance.BANKTXNID,
      'STATUS': instance.STATUS,
      'TXNDATE': instance.TXNDATE,
      'CHECKSUMHASH': instance.CHECKSUMHASH,
    };
