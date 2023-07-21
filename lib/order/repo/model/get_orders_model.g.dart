// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_orders_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetOrderResult _$GetOrderResultFromJson(Map<String, dynamic> json) =>
    GetOrderResult(
      orders: (json['orders'] as List<dynamic>?)
          ?.map((e) => Order.fromJson(e as Map<String, dynamic>))
          .toList(),
      timestamp: json['timestamp'] as String?,
    )..id = json['id'] as int?;

Map<String, dynamic> _$GetOrderResultToJson(GetOrderResult instance) =>
    <String, dynamic>{
      'id': instance.id,
      'orders': instance.orders,
      'timestamp': instance.timestamp,
    };

Order _$OrderFromJson(Map<String, dynamic> json) => Order(
      status: json['status'] as int?,
      price: (json['price'] as num?)?.toDouble(),
      shell: json['shell'] as int?,
      items: (json['items'] as List<dynamic>?)
          ?.map((e) => Items.fromJson(e as Map<String, dynamic>))
          .toList(),
      otp: json['otp'] as int?,
      order_image_url: json['order_image_url'] as String?,
      vendor: json['vendor'] == null
          ? null
          : Vendor.fromJson(json['vendor'] as Map<String, dynamic>),
      rating: json['rating'] as int?,
      transaction: json['transaction'] as int?,
      order_id: json['order_id'] as int?,
      otp_seen: json['otp_seen'] as bool?,
    );

Map<String, dynamic> _$OrderToJson(Order instance) => <String, dynamic>{
      'order_id': instance.order_id,
      'status': instance.status,
      'shell': instance.shell,
      'otp': instance.otp,
      'rating': instance.rating,
      'transaction': instance.transaction,
      'price': instance.price,
      'otp_seen': instance.otp_seen,
      'items': instance.items,
      'order_image_url': instance.order_image_url,
      'vendor': instance.vendor,
    };

Items _$ItemsFromJson(Map<String, dynamic> json) => Items(
      name: json['name'] as String?,
      quantity: json['quantity'] as int?,
      id: json['id'] as int?,
      unit_price: json['unit_price'] as int?,
    );

Map<String, dynamic> _$ItemsToJson(Items instance) => <String, dynamic>{
      'name': instance.name,
      'quantity': instance.quantity,
      'id': instance.id,
      'unit_price': instance.unit_price,
    };

Vendor _$VendorFromJson(Map<String, dynamic> json) => Vendor(
      name: json['name'] as String?,
      id: json['id'] as int?,
    );

Map<String, dynamic> _$VendorToJson(Vendor instance) => <String, dynamic>{
      'name': instance.name,
      'id': instance.id,
    };
