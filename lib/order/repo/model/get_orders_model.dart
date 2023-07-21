import 'package:json_annotation/json_annotation.dart';

part 'get_orders_model.g.dart';

@JsonSerializable()
class GetOrderResult {
  int? id;
  List<Order>? orders;
  String? timestamp;

  GetOrderResult({this.orders, this.timestamp});

  factory GetOrderResult.fromJson(Map<String, dynamic> json) =>
      _$GetOrderResultFromJson(json);

  Map<String, dynamic> toJson() => _$GetOrderResultToJson(this);
}

@JsonSerializable()
class Order {
  int? order_id, status, shell, otp, rating, transaction;
  double? price;
  bool? otp_seen;
  List<Items>? items;
  String? order_image_url;
  Vendor? vendor;

  Order(
      {this.status,
      this.price,
      this.shell,
      this.items,
      this.otp,
      this.order_image_url,
      this.vendor,
      this.rating,
      this.transaction,
      this.order_id,
      this.otp_seen});

  factory Order.fromJson(Map<String, dynamic> json) => _$OrderFromJson(json);

  Map<String, dynamic> toJson() => _$OrderToJson(this);
}

@JsonSerializable()
class Items {
  String? name;
  int? quantity;
  int? id;
  int? unit_price;

  Items({this.name, this.quantity, this.id, this.unit_price});

  factory Items.fromJson(Map<String, dynamic> json) => _$ItemsFromJson(json);

  Map<String, dynamic> toJson() => _$ItemsToJson(this);
}

@JsonSerializable()
class Vendor {
  String? name;
  int? id;

  Vendor({
    this.name,
    this.id,
  });

  factory Vendor.fromJson(Map<String, dynamic> json) => _$VendorFromJson(json);

  Map<String, dynamic> toJson() => _$VendorToJson(this);
}
