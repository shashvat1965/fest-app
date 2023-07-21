import 'package:json_annotation/json_annotation.dart';

part 'ticketPostBody.g.dart';

@JsonSerializable()
class TicketPostBody {
  Map<String, int>? individual;
  Map<String, int>? combos;

  TicketPostBody({this.individual, this.combos});

  factory TicketPostBody.fromJson(Map<String, dynamic> json) =>
      _$TicketPostBodyFromJson(json);

  Map<String, dynamic> toJson() => _$TicketPostBodyToJson(this);
}
