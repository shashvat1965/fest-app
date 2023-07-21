import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../../../../utils/urls.dart';
import '../model/gloginData.dart';

part 'gloginGetJwt.g.dart';

@RestApi(baseUrl: kBaseUrl)
abstract class GoogleLoginRestClient {
  factory GoogleLoginRestClient(Dio dio, {String baseUrl}) =
      _GoogleLoginRestClient;

  @POST("/wallet/auth")
  Future<GoogleAuthResult> getAuth(@Body() GoogleLoginPostRequest postRequest);
}
