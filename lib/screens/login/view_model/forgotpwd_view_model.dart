import 'package:chucker_flutter/chucker_flutter.dart';
import 'package:dio/dio.dart';
import 'package:oasis_2022/screens/login/repository/model/forgotPasswordData.dart';
import 'package:oasis_2022/screens/login/repository/retrofit/getForgotPasswordResponse.dart';
import 'package:oasis_2022/utils/error_messages.dart';

class ForgotPasswordViewModel {
  // Create storage

  Future<ForgotPasswordResponse> forgotPassword(String? email) async {
    final dio = Dio();
    dio.interceptors.add(ChuckerDioInterceptor()); // Provide a dio instance

    final client = ForgotPasswordRestClient(dio);
    ForgotPasswordPostRequest postRequest =
        ForgotPasswordPostRequest.fromJson({"email": email});
    ForgotPasswordResponse forgotPasswordResponse =
        await client.getForgotPasswordResponse(postRequest).then((it) async {
      it.display_message = null;
      return it;
    }).catchError((Object obj) {
      // non-200 error goes here.
      final res = (obj as DioError).response;
      if (res?.statusCode == null || res == null) {
        return ForgotPasswordResponse(
            display_message: ErrorMessages.noInternet);
      } else {
        return ForgotPasswordResponse(
            display_message:
                res.data['display_message'] ?? ErrorMessages.unknownError);
      }
    });
    return forgotPasswordResponse;
  }
}
