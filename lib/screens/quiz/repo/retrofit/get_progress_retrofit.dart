import 'package:dio/dio.dart';
import 'package:retrofit/http.dart';

import '../../../../utils/urls.dart';
import '../model/get_progress_model.dart';

part 'get_progress_retrofit.g.dart';

@RestApi(baseUrl: kBaseUrl)
abstract class ProgressRestClient {
  factory ProgressRestClient(Dio dio, {String baseUrl}) = _ProgressRestClient;

  @GET('')
  Future<Progress> getProgress(@Header("Authorization") String JWT);
}
