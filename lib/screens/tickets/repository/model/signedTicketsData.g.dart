// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'signedTicketsData.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SignedTickets _$SignedTicketsFromJson(Map<String, dynamic> json) =>
    SignedTickets(
      shows: (json['shows'] as List<dynamic>?)
          ?.map((e) => SignedShow.fromJson(e as Map<String, dynamic>))
          .toList(),
      combos: (json['combos'] as List<dynamic>?)
          ?.map((e) => SignedCombo.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$SignedTicketsToJson(SignedTickets instance) =>
    <String, dynamic>{
      'shows': instance.shows,
      'combos': instance.combos,
    };

SignedShow _$SignedShowFromJson(Map<String, dynamic> json) => SignedShow(
      id: json['id'] as int?,
      used_count: json['used_count'] as int?,
      unused_count: json['unused_count'] as int?,
      show_name: json['show_name'] as String?,
    );

Map<String, dynamic> _$SignedShowToJson(SignedShow instance) =>
    <String, dynamic>{
      'id': instance.id,
      'used_count': instance.used_count,
      'unused_count': instance.unused_count,
      'show_name': instance.show_name,
    };

SignedCombo _$SignedComboFromJson(Map<String, dynamic> json) => SignedCombo(
      id: json['id'] as int?,
      used_count: json['used_count'] as int?,
      unused_count: json['unused_count'] as int?,
      combo_name: json['combo_name'] as String?,
    );

Map<String, dynamic> _$SignedComboToJson(SignedCombo instance) =>
    <String, dynamic>{
      'id': instance.id,
      'used_count': instance.used_count,
      'unused_count': instance.unused_count,
      'combo_name': instance.combo_name,
    };
