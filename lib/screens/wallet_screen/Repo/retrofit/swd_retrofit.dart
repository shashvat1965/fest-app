import '/screens/wallet_screen/Repo/model/add_swd_model.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import '/../../../utils/urls.dart';
part 'swd_retrofit.g.dart';

@RestApi(baseUrl: kBaseUrl)
abstract class AddMoneyRestClient {
  factory AddMoneyRestClient(Dio dio, {String baseUrl}) = _AddMoneyRestClient;

  @POST("")
  Future<void> addFromSwd(@Header("Authorization") String jwt,
      @Body() AddSwdPostRequestModel addSwdPostRequestModel);
}
