// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Transactions_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TransactionsModel _$TransactionsModelFromJson(Map<String, dynamic> json) =>
    TransactionsModel(
      txns: (json['txns'] as List<dynamic>)
          .map((e) => TransactionsData.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$TransactionsModelToJson(TransactionsModel instance) =>
    <String, dynamic>{
      'txns': instance.txns,
    };

TransactionsData _$TransactionsDataFromJson(Map<String, dynamic> json) =>
    TransactionsData(
      txn_type: json['txn_type'] as String?,
      name: json['name'] as String?,
      price: json['price'] as int?,
      time: json['time'] as String?,
    )..transfers = json['transfers'] as String?;

Map<String, dynamic> _$TransactionsDataToJson(TransactionsData instance) =>
    <String, dynamic>{
      'txn_type': instance.txn_type,
      'name': instance.name,
      'price': instance.price,
      'transfers': instance.transfers,
      'time': instance.time,
    };
