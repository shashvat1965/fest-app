import '/utils/urls.dart';
import 'package:dio/dio.dart';
import 'package:dio/dio.dart' hide Headers;
import 'package:retrofit/retrofit.dart';

import '../model/get_orders_model.dart';

part 'get_orders_retrofit.g.dart';

@RestApi(baseUrl: kBaseUrl)
abstract class OrdersRestClient {
  factory OrdersRestClient(Dio dio, {String baseUrl}) = _OrdersRestClient;

  @GET("")
  Future<List<GetOrderResult>> getOrders(
    @Header("Authorization") String JWT,
  );
}
