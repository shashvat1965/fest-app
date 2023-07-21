class OrderCardModel {
  int id;
  int? orderId;
  String foodStallName;
  String? order_image_url;
  int itemCount;
  String timeStamp;
  int otp;
  double subtotal;
  List<MenuItemInOrdersScreen> menuItemInOrdersScreenList;
  int status;

  OrderCardModel(
      {required this.foodStallName,
      required this.id,
      required this.itemCount,
      required this.menuItemInOrdersScreenList,
      required this.orderId,
      required this.otp,
      required this.status,
      required this.subtotal,
      required this.timeStamp,
      required this.order_image_url});
}

class MenuItemInOrdersScreen {
  int quantity;
  int price;
  String name;

  MenuItemInOrdersScreen({
    required this.quantity,
    required this.price,
    required this.name,
  });
}
