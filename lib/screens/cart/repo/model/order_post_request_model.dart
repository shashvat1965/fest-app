import 'package:json_annotation/json_annotation.dart';

part 'order_post_request_model.g.dart';

@JsonSerializable()
class MenuItemForPostRequest {
  int menuItemQuantity;
  String menuItemId;

  MenuItemForPostRequest(
      {required this.menuItemId, required this.menuItemQuantity});

  factory MenuItemForPostRequest.fromJson(Map<String, dynamic> json) =>
      _$MenuItemForPostRequestFromJson(json);

  Map<String, dynamic> toJson() => _$MenuItemForPostRequestToJson(this);
}
