import 'package:chucker_flutter/chucker_flutter.dart';
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:logger/logger.dart';

import '/provider/user_details_viewmodel.dart';
import '../repository/model/paytmAmountData.dart';
import '../repository/model/paytmResult.dart';
import '../repository/retrofit/getPaytm.dart';

final logger = Logger();
FlutterSecureStorage storage = FlutterSecureStorage();

class PaytmViewModel {
  Future<PaytmResult> getPaytmResponse(String amount) async {
    print('goes here');
    final dio = Dio(); // Provide a dio instance
    dio.interceptors.add(ChuckerDioInterceptor());
    final client = PaytmRestClient(dio);
    String? jwt = UserDetailsViewModel.userDetails.JWT;
    print(jwt);
    // print(amount);
    // print(jwt);
    PaytmAmountData paytmAmountData = PaytmAmountData(TXN_AMOUNT: amount);
    print('efigwehjfgbesihfgbhfibgf');
    print(paytmAmountData.TXN_AMOUNT.runtimeType);
    PaytmResult response =
        await client.getPaytm("JWT ${jwt}", paytmAmountData).then((it) {
      logger.i(it.order_id);
      print('jkbawdfkjabfkjfnf');
      return it;
    }).catchError((Object obj) {
      // non-200 error goes here.
      switch (obj.runtimeType) {
        case DioError:
          // Here's the sample to get the failed response error code and message
          final res = (obj as DioError).response;
          logger.e("Got error : ${res?.statusCode} -> ${res?.statusMessage}");
          print(res?.statusCode);
          if (res?.statusCode == 403) {
            throw Exception(res?.data["display_message"]);
          } else if (res?.statusCode == 500) {
            throw Exception(res?.data["error"].toString());
          }
          break;
        default:
          break;
      }
    });

    return response;
  }
}
