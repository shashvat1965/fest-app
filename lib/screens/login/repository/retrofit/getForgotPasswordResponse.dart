import 'package:dio/dio.dart';
import 'package:oasis_2022/screens/login/repository/model/forgotPasswordData.dart';
import 'package:retrofit/retrofit.dart';

import '../../../../utils/urls.dart';

part 'getForgotPasswordResponse.g.dart';

@RestApi(baseUrl: kBaseUrl)
abstract class ForgotPasswordRestClient {
  factory ForgotPasswordRestClient(Dio dio, {String baseUrl}) =
      _ForgotPasswordRestClient;

  @POST("/wallet/reset_password")
  Future<ForgotPasswordResponse> getForgotPasswordResponse(
      @Body() ForgotPasswordPostRequest postRequest);
}
