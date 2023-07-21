import 'package:json_annotation/json_annotation.dart';

part 'paytmResponseMessage.g.dart';

@JsonSerializable()
class PaytmResponseMessage {
  PaytmResponseMessage({required this.message, this.display_message});

  String? message;
  String? display_message;

  factory PaytmResponseMessage.fromJson(Map<String, dynamic> json) =>
      _$PaytmResponseMessageFromJson(json);

  Map<String, dynamic> toJson() => _$PaytmResponseMessageToJson(this);
}
