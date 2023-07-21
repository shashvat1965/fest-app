import '/screens/wallet_screen/Repo/model/send_money_model.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '/../../../utils/urls.dart';

part 'send_money_retrofit.g.dart';

@RestApi(baseUrl: kBaseUrl)
abstract class SendMoneyRestClient {
  factory SendMoneyRestClient(Dio dio, {String baseUrl}) = _SendMoneyRestClient;

  @POST("")
  Future<void> postMoneyTransfer(
      @Body() SendMoneyThroughIdModel sendMoneyThroughIdModel,
      @Header("Authorization") String jwt);
}
