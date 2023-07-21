import 'package:chucker_flutter/chucker_flutter.dart';
import 'package:dio/dio.dart';
import 'package:oasis_2022/screens/kindstore/repository/model/kind_store_catalog_model.dart';

import '../../../utils/error_messages.dart';
import '../repository/retrofit/kind_store_catalog_retrofit.dart';

class KindStoreViewModel {
  static String? error;
  static KindStoreResult kindItemsResult = KindStoreResult(items_details: []);
  Future<void> getKindStoreCatalogItems() async {
    error = null;
    final dio = Dio();
    dio.interceptors.add(ChuckerDioInterceptor());
    final client = KindStoreCatalogRestClient(dio);
    // KindStoreResult? kindstorecatalog;

    kindItemsResult = await client.getKindStoreItems().catchError(
      (Object obj) {
        try {
          final res = (obj as DioError).response;
          error = res?.statusCode.toString();
          if (res?.statusCode == null || res == null) {
            error = ErrorMessages.noInternet;
          } else {
            // error = MiscEventsViewModel.matchesErrorResponse(
            //     res.statusCode, res.statusMessage);
            error = ErrorMessages.unknownError;
          }
        } catch (e) {
          error = ErrorMessages.unknownError;
        }
        return kindItemsResult;
      },
    );
    // return kindstorecatalog;
  }
}
