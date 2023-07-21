import 'package:flutter/cupertino.dart';
import 'package:hive/hive.dart';
import 'package:oasis_2022/screens/food_stalls/repo/model/food_stall_model.dart';
import 'package:oasis_2022/screens/food_stalls/view_model/food_stalls_viewmodel.dart';

class CachedFoodStallsViewModel {
  static String? error;
  static List<FoodStall> listFoodStalls = <FoodStall>[];

  final _box = Hive.box<FoodStallList>('foodStallBox');
  static ChangeNotifier status =
      ChangeNotifier(); //0 is initial state, 1 is its in hive and read from hive, 2 is read from network call 4 is empty in network but may or maynot be empty in database
  static int statusInt = 0;

  getFoodStalls() {
    _readFromBox();
    retrieveFoodStallNetworkResult();
  }

  Future<void> retrieveFoodStallNetworkResult() async {
    print('goes in network call');
    error = null;
    List<FoodStall> listFoodStallNetwork =
        await FoodStallViewModel().getFoodStalls();

    if (listFoodStallNetwork.isNotEmpty) {
      listFoodStalls = listFoodStallNetwork;
      statusInt = 2;
      status.notifyListeners();
      print('storing');
      storeInBox();
    } else {
      statusInt = 4;
      status.notifyListeners();
    }
    print('goes out of network');
    error = FoodStallViewModel.error;
  }

  Future<void> storeInBox() async {
    await _box.put('a', FoodStallList(listFoodStalls));
    print('stored, length in food is');
    print(_box.values.toList().cast<FoodStallList>()[0]..foodStalls?.length);
  }

  Future<bool> _readFromBox() async {
    print('goes in local');
    listFoodStalls = _box.values.toList().cast<FoodStallList>().isNotEmpty
        ? _box.values.toList().cast<FoodStallList>()[0].foodStalls ?? []
        : [];
    if (listFoodStalls.isEmpty) {
      print('goes in empty database condition');
      return false;
    }

    statusInt = 1;
    status.notifyListeners();
    print('goes out of local');
    return true;
  }
}
