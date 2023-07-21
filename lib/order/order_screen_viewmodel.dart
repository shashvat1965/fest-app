import 'package:dio/dio.dart';
import 'package:hive/hive.dart';
import 'package:oasis_2022/utils/error_messages.dart';

import '../order/repo/model/get_orders_model.dart';
import '../order/repo/model/make_otp_seen_model.dart';
import '../order/repo/model/order_card_model.dart';
import '../order/repo/retrofit/get_orders_retrofit.dart';
import '../order/repo/retrofit/make_otp_seen_retrofit.dart';
import '../provider/user_details_viewmodel.dart';

class OrderScreenViewModel {
  static String? error;
  Future<void> makeOtpSeen(int orderid) async {
    MakeOtpSeenData makeOtpSeenData = MakeOtpSeenData(order_id: orderid);
    final dio = Dio();
    final client = OtpRestClient(dio);
    String jwt = "JWT ${UserDetailsViewModel.userDetails.JWT}";
    await client.makeOtpSeen(jwt, makeOtpSeenData);
    return;
  }

  Future<List<GetOrderResult>> getOrders() async {
    final dio = Dio();
    String auth = "JWT ${UserDetailsViewModel.userDetails.JWT}";
    final client = OrdersRestClient(dio);
    List<GetOrderResult> listOfOrderResult = [];
    try{
      listOfOrderResult = await client.getOrders(auth);
    } catch (e){
      if(e.runtimeType == DioErrorType){
        if((e as DioError).response?.statusCode.toString() == "401"){
          Hive.box('firstRun').clear();
          error = ErrorMessages.unauthError;
        } else {
          error = ErrorMessages.unknownError;
        }
      }
      error = ErrorMessages.unknownError;
    }

    return listOfOrderResult;
  }

  List<OrderCardModel> changeDataModel(List<GetOrderResult> listOfOrderResult) {
    List<OrderCardModel> orderCardModelList = [];

    for (GetOrderResult i in listOfOrderResult) {
      int id = i.id!;
      String timeStamp = i.timestamp!;
      List<Order> list = i.orders!;
      for (Order j in list) {
        int otp = j.otp!;
        String foodStallName = j.vendor!.name!;
        double subTotal = j.price!;
        int status = j.status!;
        int? orderId = j.order_id;
        String? order_image_url = j.order_image_url;
        print('order id: $orderId');

        List<MenuItemInOrdersScreen> tempItemList = [];
        List<Items> itemList = j.items!;
        for (Items k in itemList) {
          String name = k.name!;
          int price = k.unit_price!;
          int quantity = k.quantity!;
          tempItemList.add(MenuItemInOrdersScreen(
              quantity: quantity, price: price, name: name));
        }
        orderCardModelList.add(OrderCardModel(
            foodStallName: foodStallName,
            id: id,
            itemCount: itemList.length,
            menuItemInOrdersScreenList: tempItemList,
            orderId: orderId,
            otp: otp,
            status: status,
            subtotal: subTotal,
            timeStamp: timeStamp,
            order_image_url: order_image_url));
      }
    }
    return orderCardModelList;
  }
}
