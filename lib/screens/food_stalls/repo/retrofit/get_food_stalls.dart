import '/screens/food_stalls/repo/model/food_stall_model.dart';
import '/utils/urls.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

part 'get_food_stalls.g.dart';

@RestApi(baseUrl: kBaseUrl)
abstract class FoodStallRestClient {
  factory FoodStallRestClient(Dio dio, {String baseUrl}) = _FoodStallRestClient;

  @GET("")
  Future<List<FoodStall>> getStalls();
}
