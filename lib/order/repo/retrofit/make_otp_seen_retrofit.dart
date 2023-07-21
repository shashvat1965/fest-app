import '/order/repo/model/make_otp_seen_model.dart';
import '/utils/urls.dart';
import 'package:dio/dio.dart';
import 'package:dio/dio.dart' hide Headers;
import 'package:retrofit/retrofit.dart';

part 'make_otp_seen_retrofit.g.dart';

@RestApi(baseUrl: kBaseUrl)
abstract class OtpRestClient {
  factory OtpRestClient(Dio dio, {String baseUrl}) = _OtpRestClient;

  @POST("")
  Future<void> makeOtpSeen(@Header("Authorization") String JWT,
      @Body() MakeOtpSeenData makeOtpSeenData);
}
