// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'balance_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BalanceModel _$BalanceModelFromJson(Map<String, dynamic> json) => BalanceModel(
      data: json['data'] == null
          ? null
          : BalanceData.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$BalanceModelToJson(BalanceModel instance) =>
    <String, dynamic>{
      'data': instance.data,
    };

BalanceData _$BalanceDataFromJson(Map<String, dynamic> json) => BalanceData(
      cash: json['cash'] as int?,
      pg: json['pg'] as int?,
      swd: json['swd'] as int?,
      kind_active: json['kind_active'] as bool?,
      kind_points: json['kind_points'] as int?,
      transfers: json['transfers'] as int?,
    );

Map<String, dynamic> _$BalanceDataToJson(BalanceData instance) =>
    <String, dynamic>{
      'cash': instance.cash,
      'pg': instance.pg,
      'swd': instance.swd,
      'transfers': instance.transfers,
      'kind_active': instance.kind_active,
      'kind_points': instance.kind_points,
    };
