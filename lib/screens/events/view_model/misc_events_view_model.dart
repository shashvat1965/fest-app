import 'package:chucker_flutter/chucker_flutter.dart';
import 'package:dio/dio.dart';

import '../../../utils/error_messages.dart';
import '../repository/model/miscEventResult.dart';
import '../repository/retrofit/getMiscEvents.dart';

class MiscEventsViewModel {
  static String? error;
  static List<MiscEventData> miscEventList = <MiscEventData>[];

  Future<List<MiscEventCategory>> retrieveMiscEventResult() async {
    miscEventList = <MiscEventData>[];
    List<MiscEventCategory>? miscEventCategoryList;
    final dio = Dio();
    error = null;
    dio.interceptors.add(ChuckerDioInterceptor());
    final client = MiscEventRestClient(dio);

    miscEventCategoryList = await client.getAllMiscEvents().then((it) {
      return it;
    }).catchError((Object obj) {
      try {
        final res = (obj as DioError).response;
        error = res?.statusCode.toString();
        if (res?.statusCode == null || res == null) {
          error = ErrorMessages.noInternet;
        } else {
          error = matchesErrorResponse(res.statusCode, res.statusMessage);
        }
      } catch (e) {
        error = ErrorMessages.unknownError;
      }
      return miscEventCategoryList ?? <MiscEventCategory>[];
    });
    return miscEventCategoryList;
  }

  static String matchesErrorResponse(int? responseCode, String? statusMessage) {
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
