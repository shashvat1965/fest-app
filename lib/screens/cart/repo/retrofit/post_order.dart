import '/screens/cart/repo/model/post_order_response_model.dart';
import '/utils/urls.dart';
import 'package:dio/dio.dart';
import 'package:dio/dio.dart' hide Headers;
import 'package:retrofit/retrofit.dart';

part 'post_order.g.dart';

@RestApi(baseUrl: kBaseUrl)
abstract class PostOrderRestClient {
  factory PostOrderRestClient(Dio dio, {String baseUrl}) = _PostOrderRestClient;

  @POST("")
  Future<OrderResult> postOrder(
      @Header("Authorization") String JWT, @Body() var orderdict);
}
