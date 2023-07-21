import 'package:json_annotation/json_annotation.dart';

part 'signedTicketsData.g.dart';

@JsonSerializable()
class SignedTickets {
  SignedTickets({this.shows, this.combos});

  List<SignedShow>? shows;
  List<SignedCombo>? combos;

  factory SignedTickets.fromJson(Map<String, dynamic> json) =>
      _$SignedTicketsFromJson(json);
}

@JsonSerializable()
class SignedShow {
  SignedShow({
    this.id,
    this.used_count,
    this.unused_count,
    this.show_name,
  });

  int? id;
  int? used_count;
  int? unused_count;
  String? show_name;

  factory SignedShow.fromJson(Map<String, dynamic> json) =>
      _$SignedShowFromJson(json);
}

@JsonSerializable()
class SignedCombo {
  SignedCombo({
    this.id,
    this.used_count,
    this.unused_count,
    this.combo_name,
  });

  int? id;
  int? used_count;
  int? unused_count;
  String? combo_name;

  factory SignedCombo.fromJson(Map<String, dynamic> json) =>
      _$SignedComboFromJson(json);
}
