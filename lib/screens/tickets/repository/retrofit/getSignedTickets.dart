import '/utils/urls.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../model/signedTicketsData.dart';

part 'getSignedTickets.g.dart';

@RestApi(baseUrl: kBaseUrl)
abstract class SignedTicketsRestClient {
  factory SignedTicketsRestClient(Dio dio, {String baseUrl}) =
      _SignedTicketsRestClient;

  @GET(kSignedTicketsPath)
  Future<SignedTickets> getCurrentTickets(@Header("Authorization") String JWT);
}
