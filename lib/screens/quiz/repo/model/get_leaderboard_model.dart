import 'package:json_annotation/json_annotation.dart';

part 'get_leaderboard_model.g.dart';

@JsonSerializable()
class Users {
  List<User>? users;

  Users({this.users});

  factory Users.fromJson(Map<String, dynamic> json) => _$UsersFromJson(json);

  Map<String, dynamic> toJson() => _$UsersToJson(this);
}

@JsonSerializable()
class User {
  String? name;
  int? points;

  User({
    required this.name,
    required this.points,
  });

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);
}
