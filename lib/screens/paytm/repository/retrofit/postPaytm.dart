import '/utils/urls.dart';
import 'package:dio/dio.dart';
import 'package:dio/dio.dart' hide Headers;
import 'package:retrofit/retrofit.dart';

import '../model/paytmResponse.dart';
import '../model/paytmResponseMessage.dart';

part 'postPaytm.g.dart';

@RestApi(baseUrl: kBaseUrl)
abstract class PostPaytmRestClient {
  factory PostPaytmRestClient(Dio dio, {String baseUrl}) = _PostPaytmRestClient;

  @POST(kConfirmPaymentPath)
  Future<PaytmResponseMessage> postPaytm(
    @Header("Authorization") String JWT,
    @Body() PaytmResponse paytmResponse,
  );
}
