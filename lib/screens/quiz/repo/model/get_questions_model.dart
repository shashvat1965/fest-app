import 'package:json_annotation/json_annotation.dart';

part 'get_questions_model.g.dart';

@JsonSerializable()
class Questions {
  List<Question>? active_questions;

  Questions({this.active_questions});

  factory Questions.fromJson(Map<String, dynamic> json) =>
      _$QuestionsFromJson(json);

  Map<String, dynamic> toJson() => _$QuestionsToJson(this);
}

@JsonSerializable()
class Question {
  int? question_no, question_id, total_options;
  List<int?> option_ids;
  List<String?> option_texts;

  // bool? quiz_closed;

  String? question_text = '';

  Question(
      { //required this.category,
      required this.question_id,
      required this.total_options,
      // required this.image_link,
      //required this.time_given,
      required this.question_no,
      //required this.quiz_closed,
      required this.question_text,
      required this.option_ids,
      required this.option_texts});

  factory Question.fromJson(Map<String, dynamic> json) =>
      _$QuestionFromJson(json);

  Map<String, dynamic> toJson() => _$QuestionToJson(this);
}
