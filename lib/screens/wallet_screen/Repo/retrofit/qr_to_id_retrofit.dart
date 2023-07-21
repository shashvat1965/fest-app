import '/screens/wallet_screen/Repo/model/qr_to_id.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '/../../../utils/urls.dart';

part 'qr_to_id_retrofit.g.dart';

@RestApi(baseUrl: kBaseUrl)
abstract class QrToIdModelRestClient {
  factory QrToIdModelRestClient(Dio dio, {String baseUrl}) =
      _QrToIdModelRestClient;

  @GET("")
  Future<QrToIdModel> getId(
      @Header("Authorization") String jwt, @Header("qr-code") String qr);
}
