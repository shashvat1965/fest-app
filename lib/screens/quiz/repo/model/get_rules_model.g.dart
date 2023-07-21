// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_rules_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Rules _$RulesFromJson(Map<String, dynamic> json) => Rules(
      rounds: (json['rounds'] as List<dynamic>?)
          ?.map((e) => Rule.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$RulesToJson(Rules instance) => <String, dynamic>{
      'rounds': instance.rounds,
    };

Rule _$RuleFromJson(Map<String, dynamic> json) => Rule(
      round_name: json['round_name'] as String?,
      rules: (json['rules'] as List<dynamic>).map((e) => e as String?).toList(),
      round_no: json['round_no'] as String?,
      points: json['points'] as String?,
    );

Map<String, dynamic> _$RuleToJson(Rule instance) => <String, dynamic>{
      'round_name': instance.round_name,
      'points': instance.points,
      'round_no': instance.round_no,
      'rules': instance.rules,
    };
