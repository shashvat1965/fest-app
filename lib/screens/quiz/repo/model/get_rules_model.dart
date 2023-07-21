import 'package:json_annotation/json_annotation.dart';

part 'get_rules_model.g.dart';

@JsonSerializable()
class Rules {
  List<Rule>? rounds;

  Rules({this.rounds});

  factory Rules.fromJson(Map<String, dynamic> json) => _$RulesFromJson(json);

  Map<String, dynamic> toJson() => _$RulesToJson(this);
}

@JsonSerializable()
class Rule {
  String? round_name, points, round_no;
  List<String?> rules;

  Rule({
    required this.round_name,
    required this.rules,
    required this.round_no,
    required this.points,
  });

  factory Rule.fromJson(Map<String, dynamic> json) => _$RuleFromJson(json);

  Map<String, dynamic> toJson() => _$RuleToJson(this);
}
