import '/screens/wallet_screen/Repo/model/refresh_qr.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '/../../../utils/urls.dart';

part 'refresh_qr_retrofit.g.dart';

@RestApi(baseUrl: kBaseUrl)
abstract class RefreshQrRestClient {
  factory RefreshQrRestClient(Dio dio, {String baseUrl}) = _RefreshQrRestClient;

  @POST("")
  Future<RefreshQrResponseModel> refreshQr(@Header("Authorization") String jwt,
      @Body() RefreshQrPostModel refreshQrPostModel);
}
