import 'package:json_annotation/json_annotation.dart';

part 'post_answer_model.g.dart';

@JsonSerializable()
class PostAnswers {
  int? question_id;
  int? answer_id;

  PostAnswers({
    required this.question_id,
    required this.answer_id,
  });

  factory PostAnswers.fromJson(Map<String, dynamic> json) =>
      _$PostAnswersFromJson(json);

  Map<String, dynamic> toJson() => _$PostAnswersToJson(this);
}
