import '/screens/quiz/repo/model/get_rules_model.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/http.dart';

import '../../../../utils/urls.dart';
part 'get_rules_retrofit.g.dart';

@RestApi(baseUrl: kBaseUrl)
abstract class RulesRestClient {
  factory RulesRestClient(Dio dio, {String baseUrl}) = _RulesRestClient;

  @GET('')
  Future<Rules> getAllRules(@Header("Authorization") String JWT);
}
