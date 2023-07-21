import '/utils/urls.dart';
import 'package:dio/dio.dart';
import 'package:dio/dio.dart' hide Headers;
import 'package:retrofit/retrofit.dart';

import '../model/ticketPostBody.dart';

part 'postTicket.g.dart';

@RestApi(baseUrl: kBaseUrl)
abstract class PostTicketRestClient {
  factory PostTicketRestClient(Dio dio, {String baseUrl}) =
      _PostTicketRestClient;

  @POST(kBuyTicketpath)
  Future<void> postTicket(
      @Header("Authorization") String JWT, @Body() TicketPostBody tictdict);
}
