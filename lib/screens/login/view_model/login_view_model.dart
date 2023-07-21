import 'package:hive/hive.dart';

import '/provider/user_details_viewmodel.dart';
import 'package:chucker_flutter/chucker_flutter.dart';
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:logger/logger.dart';

import '../../../utils/error_messages.dart';
import '../repository/model/data.dart';
import '../repository/retrofit/getJwt.dart';

final logger = Logger();

class LoginViewModel {
  // Create storage
  final storage = const FlutterSecureStorage();

  Future<AuthResult> authenticate(
      String? username, String? password, bool? isBitsian) async {
    final dio = Dio(); // Provide a dio instance
    dio.interceptors.add(ChuckerDioInterceptor()); //to remove later
    // dio.options.headers["Demo-Header"] =
    //     "demo header"; // config your dio headers globally
    //late String? status;
    final client = LoginRestClient(dio);
    LoginPostRequest postRequest =
        LoginPostRequest.fromJson({"username": username, "password": password});
    AuthResult authResult = await client.getAuth(postRequest).then((it) async {
      await storage.write(key: 'jwt', value: it.JWT);
      await storage.write(key: 'username', value: it.name);
      await storage.write(key: 'userid', value: it.user_id.toString());
      await storage.write(key: 'referralcode', value: it.referral_code);
      await storage.write(key: 'isBitsian', value: isBitsian.toString());
      await storage.write(key: 'qrcode', value: it.qr_code);
      await storage.write(key: 'doesUserExist', value: 'true');
      Hive.box('firstRun').put(1, true);
      UserDetailsViewModel.userDetails.username = it.name;
      UserDetailsViewModel.userDetails.JWT = it.JWT;
      UserDetailsViewModel.userDetails.userID = it.user_id.toString();
      UserDetailsViewModel.userDetails.referralCode = it.referral_code;
      UserDetailsViewModel.userDetails.isBitsian = isBitsian;
      UserDetailsViewModel.userDetails.doesUserExist = true;
      UserDetailsViewModel.userDetails.qrCode = it.qr_code;
      return it;
    }).catchError((Object obj) {
      // non-200 error goes here.
      final res = (obj as DioError).response;
      logger.i(res);
      return AuthResult(
          error: loginErrorResponse(res?.statusCode, res?.statusMessage));
    });
    return authResult;
  }

  String loginErrorResponse(int? responseCode, String? statusMessage) {
    switch (responseCode) {
      case 400:
        return ErrorMessages.emptyUsernamePassword;
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
