// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'paytmResult.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PaytmResult _$PaytmResultFromJson(Map<String, dynamic> json) => PaytmResult(
      payment_dict:
          PaymentDict.fromJson(json['payment_dict'] as Map<String, dynamic>),
      checksum: json['checksum'] as String,
      order_id: json['order_id'] as String,
      txntoken: json['txntoken'] as String,
      mid: json['mid'] as String,
      cb_url: json['cb_url'] as String,
    );

Map<String, dynamic> _$PaytmResultToJson(PaytmResult instance) =>
    <String, dynamic>{
      'payment_dict': instance.payment_dict,
      'checksum': instance.checksum,
      'order_id': instance.order_id,
      'txntoken': instance.txntoken,
      'mid': instance.mid,
      'cb_url': instance.cb_url,
    };

PaymentDict _$PaymentDictFromJson(Map<String, dynamic> json) => PaymentDict(
      MID: json['MID'] as String?,
      CUST_ID: json['CUST_ID'] as String?,
      ORDER_ID: json['ORDER_ID'] as String?,
      EMAIL: json['EMAIL'] as String?,
      CHANNEL_ID: json['CHANNEL_ID'] as String?,
      TXN_AMOUNT: json['TXN_AMOUNT'] as String?,
      WEBSITE: json['WEBSITE'] as String?,
      CALLBACK_URL: json['CALLBACK_URL'] as String?,
      INDUSTRY_TYPE_ID: json['INDUSTRY_TYPE_ID'] as String?,
    );

Map<String, dynamic> _$PaymentDictToJson(PaymentDict instance) =>
    <String, dynamic>{
      'MID': instance.MID,
      'CUST_ID': instance.CUST_ID,
      'ORDER_ID': instance.ORDER_ID,
      'EMAIL': instance.EMAIL,
      'CHANNEL_ID': instance.CHANNEL_ID,
      'TXN_AMOUNT': instance.TXN_AMOUNT,
      'WEBSITE': instance.WEBSITE,
      'CALLBACK_URL': instance.CALLBACK_URL,
      'INDUSTRY_TYPE_ID': instance.INDUSTRY_TYPE_ID,
    };
