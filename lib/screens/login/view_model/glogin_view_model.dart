import 'package:hive/hive.dart';

import '/provider/user_details_viewmodel.dart';
import '/utils/error_messages.dart';
import 'package:chucker_flutter/chucker_flutter.dart';
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../repository/model/gloginData.dart';
import '../repository/retrofit/gloginGetJwt.dart';

class GoogleLoginViewModel {
  // Create storage
  final storage = const FlutterSecureStorage();

  Future<GoogleAuthResult> authenticate(
      String? idToken, bool? isBitsian) async {
    final dio = Dio();
    dio.interceptors.add(ChuckerDioInterceptor()); // Provide a dio instance

    final client = GoogleLoginRestClient(dio);
    GoogleLoginPostRequest postRequest =
        GoogleLoginPostRequest(id_token: idToken);
    GoogleAuthResult authResult =
        await client.getAuth(postRequest).then((it) async {
      await storage.write(key: 'jwt', value: it.JWT);
      await storage.write(key: 'username', value: it.name);
      await storage.write(key: 'userid', value: it.user_id.toString());
      await storage.write(key: 'referralcode', value: it.referral_code);
      await storage.write(key: 'isBitsian', value: isBitsian.toString());
      await storage.write(key: 'qrcode', value: it.qr_code);
      await storage.write(key: 'doesUserExist', value: 'true');
      Hive.box('firstRun').put(1, false);
      UserDetailsViewModel.userDetails.username = it.name;
      UserDetailsViewModel.userDetails.JWT = it.JWT;
      UserDetailsViewModel.userDetails.userID = it.user_id.toString();
      UserDetailsViewModel.userDetails.referralCode = it.referral_code;
      UserDetailsViewModel.userDetails.isBitsian = isBitsian;
      UserDetailsViewModel.userDetails.doesUserExist = true;
      UserDetailsViewModel.userDetails.qrCode =
          await storage.read(key: 'qrcode');
      return it;
    }).catchError((Object obj) {
      // non-200 error goes here.
      final res = (obj as DioError).response;
      return GoogleAuthResult(
          error: gloginErrorResponse(res?.statusCode, res?.statusMessage));
    });
    return authResult;
  }

  String gloginErrorResponse(int? responseCode, String? statusMessage) {
    switch (responseCode) {
      case 400:
        return ErrorMessages.googleLoginFailed;
      case 401:
        return ErrorMessages.invalidUser;
      case 403:
        return ErrorMessages.disabledUser;
      case 404:
        return ErrorMessages.emptyProfile;
      default:
        return ErrorMessages.unknownError +
            ((statusMessage == null) ? '' : statusMessage);
    }
  }
}
