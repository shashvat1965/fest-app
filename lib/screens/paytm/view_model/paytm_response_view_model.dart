import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:logger/logger.dart';

import '../repository/model/paytmResponse.dart';
import '../repository/model/paytmResponseMessage.dart';
import '../repository/retrofit/postPaytm.dart';

final logger = Logger();

FlutterSecureStorage storage = FlutterSecureStorage();

class PaytmResponseViewModel {
  Future<PaytmResponseMessage> postPaytmResponse(
      PaytmResponse paytmResponse) async {
    final dio = Dio(); // Provide a dio instance
    final client = PostPaytmRestClient(dio);
    String? jwt = await storage.read(key: 'jwt');
    PaytmResponseMessage result =
        await client.postPaytm("Bearer ${jwt}", paytmResponse).then((it) {
      logger.i(it);
      return it;
    }).catchError((Object obj) {
      // non-200 error goes here.
      switch (obj.runtimeType) {
        case DioError:
          // Here's the sample to get the failed response error code and message
          final res = (obj as DioError).response;
          logger.e("Got error : ${res?.statusCode} -> ${res?.statusMessage}");

          break;
        default:
          break;
      }
    });

    return result;
  }
}
