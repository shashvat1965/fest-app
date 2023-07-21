import 'package:json_annotation/json_annotation.dart';

part 'Transactions_model.g.dart';

@JsonSerializable()
class TransactionsModel {
  TransactionsModel({
    required this.txns,
  });

  List<TransactionsData> txns;

  factory TransactionsModel.fromJson(Map<String, dynamic> json) =>
      _$TransactionsModelFromJson(json);

  Map<String, dynamic> toJson() => _$TransactionsModelToJson(this);
}

@JsonSerializable()
class TransactionsData {
  TransactionsData({
    required this.txn_type,
    required this.name,
    required this.price,
    required this.time,
  });

  String? txn_type;
  String? name;
  int? price;
  String? transfers, time;

  factory TransactionsData.fromJson(Map<String, dynamic> json) =>
      _$TransactionsDataFromJson(json);
}
