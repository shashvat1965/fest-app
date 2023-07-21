import 'dart:convert';

import '/provider/user_details_viewmodel.dart';
import '/screens/cart/repo/model/post_order_response_model.dart';
import '/screens/cart/repo/retrofit/post_order.dart';
import '/utils/error_messages.dart';
import 'package:chucker_flutter/chucker_flutter.dart';
import 'package:dio/dio.dart';
import 'package:hive/hive.dart';

import '../../food_stalls/repo/model/hive_model/hive_menu_entry.dart';
import '../repo/model/cart_screen_model.dart';

class CartScreenViewModel {
  static String? error;

  Future<OrderResult> postOrder(var orderdict) async {
    error = null;
    final dio = Dio();
    dio.interceptors.add(ChuckerDioInterceptor());
    final client = PostOrderRestClient(dio);
    OrderResult orderResult = OrderResult();
    String auth = "JWT ${UserDetailsViewModel.userDetails.JWT}";

    orderResult = await client.postOrder(auth, orderdict).then((it) {
      return it;
    }).catchError((Object obj) {
      print('error caught');
      try {
        print('hi');
        final res = (obj as DioError).response;
        error = res?.statusCode.toString();
        if (res?.statusCode == null || res == null) {
          print('goes to no internet');
          error = ErrorMessages.noInternet;
        } else {
          print('goes here error in cart result');
          error = cartErrorResponse(res.statusCode, res.statusMessage);
        }
      } catch (e) {
        print(e);
        error = ErrorMessages.unknownError;
      }
      print(error);
      return orderResult;
    });
    return orderResult;
  }

  static String cartErrorResponse(int? responseCode, String? statusMessage) {
    switch (responseCode) {
      case 400:
        return ErrorMessages.unknownError;
      case 401:
        return ErrorMessages.invalidUser;
      case 403:
        return ErrorMessages.disabledUser;
      case 404:
        return ErrorMessages.itemDoesNotExist;
      case 412:
        return ErrorMessages.itemDoesNotExist;
      default:
        return ErrorMessages.unknownError +
            ((statusMessage == null) ? '' : statusMessage);
    }
  }

  getPostRequestBody() {
    Map<String, Map<String, int>> orderdict = {};
    Map<String, Map<String, Map<String, int>>> finalOrderDict = {};
    Map<int, FoodStallInCartScreen> foodStallWithDetailsMaps =
        getValuesForScreen();
    for (int i in foodStallWithDetailsMaps.keys) {
      Map<String, int> menuItemsMap = {};
      FoodStallInCartScreen? temp = foodStallWithDetailsMaps[i];
      List<MenuItemInCartScreen> temp2 = temp!.menuList;
      for (MenuItemInCartScreen j in temp2) {
        menuItemsMap[j.menuItemId.toString()] = j.menuItemQuantity;
        orderdict[i.toString()] = menuItemsMap;
      }
      finalOrderDict['orderdict'] = orderdict;
    }
    var x = (json.encode(finalOrderDict));
    return x;
  }

  Map<int, FoodStallInCartScreen> getValuesForScreen() {
    Map<int, FoodStallInCartScreen> foodStallWithDetailsMap = {};
    Box cart = Hive.box('cartBox');
    try {
      var keys = cart.keys;
      int copyMenuId = keys.first;
      HiveMenuEntry copyHiveEntry = cart.get(copyMenuId);
      int copyFoodStallId = copyHiveEntry.FoodStallId;
      List<MenuItemInCartScreen> menuList = [];
      for (int i in keys) {
        HiveMenuEntry temp = cart.get(i);
        int tempFoodStallId = temp.FoodStallId;
        String tempFoodStallName = temp.FoodStall;
        MenuItemInCartScreen menuItemInCartScreen = MenuItemInCartScreen(
            menuItemId: i,
            menuItemName: temp.menuItemName,
            menuItemPrice: temp.price,
            foodStallName: temp.FoodStall,
            menuItemQuantity: temp.quantity,
            isVeg: temp.isVeg);
        if (copyFoodStallId == tempFoodStallId) {
          menuList.add(menuItemInCartScreen);
          foodStallWithDetailsMap[tempFoodStallId] = FoodStallInCartScreen(
              foodStall: tempFoodStallName, menuList: menuList);
        } else {
          copyFoodStallId = tempFoodStallId;
          menuList = [];
          menuList.add(menuItemInCartScreen);
          foodStallWithDetailsMap[tempFoodStallId] = FoodStallInCartScreen(
              foodStall: tempFoodStallName, menuList: menuList);
        }
      }
    } catch (e) {
      foodStallWithDetailsMap = {};
    }

    return foodStallWithDetailsMap;
  }

  List<int> getIdList(Map<int, FoodStallInCartScreen> foodStallWithDetailsMap) {
    List<int> foodStallIdList = [];
    try {
      for (int i in foodStallWithDetailsMap.keys) {
        foodStallIdList.add(i);
      }
    } catch (e) {
      foodStallIdList = [];
    }

    return foodStallIdList;
  }

  int getTotalValue(Map<int, FoodStallInCartScreen> foodStallWithDetailsMap) {
    int total = 0;
    try {
      for (int i in foodStallWithDetailsMap.keys) {
        for (MenuItemInCartScreen j in foodStallWithDetailsMap[i]!.menuList) {
          int tempTotal = (j.menuItemQuantity) * (j.menuItemPrice);
          total += tempTotal;
        }
      }
    } catch (e) {
      total = 0;
    }
    return total;
  }

  int getSubTotal(int foodStallId) {
    Map<int, FoodStallInCartScreen> foodStallWithDetailsMap =
        getValuesForScreen();
    List<int> foodStallIdList = getIdList(foodStallWithDetailsMap);
    int index = foodStallIdList.indexOf(foodStallId);
    List<int> subTotalList = [];
    for (int i in foodStallWithDetailsMap.keys) {
      int subtotal = 0;
      for (MenuItemInCartScreen j in foodStallWithDetailsMap[i]!.menuList) {
        int tempTotal = (j.menuItemQuantity) * (j.menuItemPrice);
        subtotal += tempTotal;
      }
      subTotalList.add(subtotal);
    }
    return subTotalList[index];
  }
}
