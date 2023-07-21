import '/utils/urls.dart';
import 'package:dio/dio.dart';
import 'package:dio/dio.dart' hide Headers;
import 'package:retrofit/retrofit.dart';

import '../model/paytmAmountData.dart';
import '../model/paytmResult.dart';

part 'getPaytm.g.dart';

@RestApi(baseUrl: kBaseUrl)
abstract class PaytmRestClient {
  factory PaytmRestClient(Dio dio, {String baseUrl}) = _PaytmRestClient;

  @POST(kPaytmChecksumPath)
  Future<PaytmResult> getPaytm(
    @Header("Authorization") String JWT,
    @Body() PaytmAmountData paytmAmountData,
  );
}
