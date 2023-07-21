import 'package:json_annotation/json_annotation.dart';

part 'make_otp_seen_model.g.dart';

@JsonSerializable()
class MakeOtpSeenData {
  MakeOtpSeenData({this.order_id});

  int? order_id;

  factory MakeOtpSeenData.fromJson(Map<String, dynamic> json) =>
      _$MakeOtpSeenDataFromJson(json);

  Map<String, dynamic> toJson() => _$MakeOtpSeenDataToJson(this);
}
