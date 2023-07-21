import 'package:dio/dio.dart';
import 'package:retrofit/http.dart';

import '../../../../utils/urls.dart';
import '../model/get_leaderboard_model.dart';
part 'get_leaderboard_retrofit.g.dart';

@RestApi(baseUrl: kBaseUrl)
abstract class UsersRestClient {
  factory UsersRestClient(Dio dio, {String baseUrl}) = _UsersRestClient;

  @GET('')
  Future<Users> getUsers(@Header("Authorization") String JWT);
}
