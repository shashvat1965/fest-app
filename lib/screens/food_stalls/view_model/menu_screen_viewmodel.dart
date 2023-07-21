import '/screens/food_stalls/repo/model/food_stall_model.dart' as menu;
import 'package:hive/hive.dart';

import '../../cart/repo/model/cart_screen_model.dart';
import '../repo/model/hive_model/hive_menu_entry.dart';

class MenuScreenViewModel {
  List<menu.MenuItem> searchList(
      String searchQuery, List<menu.MenuItem> menuList) {
    List<menu.MenuItem> filteredList = [];
    for (menu.MenuItem i in menuList) {
      if (i.name.toLowerCase().contains(searchQuery.toLowerCase())) {
        filteredList.add(i);
      }
    }
    return filteredList;
  }

  Map<int, int> populateListFromHive(List<menu.MenuItem> menuItems) {
    Map<int, int> menuItemsAmount = {};
    for (int i = 0; i < menuItems.length; i++) {
      menuItemsAmount[menuItems[i].id] = 0;
    }
    var cart = Hive.box('cartBox');
    var keys = cart.keys;
    for (int i in cart.keys) {
      int temp_amount;
      HiveMenuEntry x = cart.get(i);
      temp_amount = x.quantity;
      menuItemsAmount[i] = temp_amount;
    }
    return menuItemsAmount;
  }

  bool checkIfListNotEmpty(List<menu.MenuItem> menuItems) {
    Map<int, int> menuItemsAmount;
    menuItemsAmount = populateListFromHive(menuItems);
    for (int i in menuItemsAmount.values) {
      if (i != 0) {
        return true;
      }
    }
    return false;
  }

  getTotalValue() {
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
          isVeg: temp.isVeg,
        );
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
}
