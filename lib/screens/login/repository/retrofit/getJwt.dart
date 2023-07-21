import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../../../../utils/urls.dart';
import '../model/data.dart';

part 'getJwt.g.dart';

@RestApi(baseUrl: kBaseUrl)
abstract class LoginRestClient {
  factory LoginRestClient(Dio dio, {String baseUrl}) = _LoginRestClient;

  @POST("")
  Future<AuthResult> getAuth(@Body() LoginPostRequest postRequest);
}
