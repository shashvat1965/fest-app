import '/screens/wallet_screen/Repo/model/balance_model.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import '/../../../utils/urls.dart';

part 'balance_retrofit.g.dart';

@RestApi(baseUrl: kBaseUrl)
abstract class BalanceRestClient {
  factory BalanceRestClient(Dio dio, {String baseUrl}) = _BalanceRestClient;

  @GET("")
  Future<BalanceModel> getBalance(@Header("Authorization") String jwt);
}
