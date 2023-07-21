import 'package:chucker_flutter/chucker_flutter.dart';
import 'package:dio/dio.dart';
import 'package:hive/hive.dart';
import 'package:oasis_2022/utils/error_messages.dart';

import '/screens/food_stalls/repo/model/food_stall_model.dart';
import '/screens/food_stalls/repo/retrofit/get_food_stalls.dart';

class FoodStallViewModel {
  static String? error;

  Future<List<FoodStall>> getFoodStalls() async {
    final dio = Dio();
    dio.interceptors.add(ChuckerDioInterceptor());
    final client = FoodStallRestClient(dio);
    List<FoodStall> foodStalls = [];
    error = null;
    //   foodStalls = await client.getStalls().catchError((Object obj) {
    //     try {
    //       final res = (obj as DioError).response;
    //       error = res?.statusCode.toString();
    //       if (res?.statusCode == null || res == null) {
    //         error = ErrorMessages.noInternet;
    //       } else {
    //         // error = MiscEventsViewModel.matchesErrorResponse(
    //         //     res.statusCode, res.statusMessage);
    //         error = ErrorMessages.unknownError;
    //       }
    //     } catch (e) {
    //       print(e);
    //       error = ErrorMessages.unknownError;
    //     }
    //
    //     return foodStalls;
    //   });
    //   return foodStalls;
    // }

    foodStalls = await client.getStalls().then((it) {
      return it;
    }).catchError((Object obj) {
      print('aefkjbesfkhbef');
      try {
        final res = (obj as DioError).response;
        error = res?.statusCode.toString();
        if (res?.statusCode == null || res != null || res!.data == null) {
          print('efbhefkef');
          error = ErrorMessages.noInternet;
        } if(res?.statusCode.toString() == "401"){
          Hive.box('firstRun').clear();
          error = ErrorMessages.unauthError;
        }
        else {
          print('akdjbakjdbnw');
          error = ErrorMessages.unknownError;
        }
      } catch (e) {
        print('akhefbefskb');
        error = ErrorMessages.unknownError;
      }
      return foodStalls ?? <FoodStall>[];
    });
    print(error);
    return foodStalls;
  }
}
