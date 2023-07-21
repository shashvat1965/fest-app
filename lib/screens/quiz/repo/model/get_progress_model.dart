import 'package:json_annotation/json_annotation.dart';

part 'get_progress_model.g.dart';

@JsonSerializable()
class Progress {
  int? progress;

  Progress({this.progress});

  factory Progress.fromJson(Map<String, dynamic> json) =>
      _$ProgressFromJson(json);

  Map<String, dynamic> toJson() => _$ProgressToJson(this);
}
