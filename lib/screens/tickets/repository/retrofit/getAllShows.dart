import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '/../../../utils/urls.dart';
import '../model/showsData.dart';

part 'getAllShows.g.dart';

@RestApi(baseUrl: kBaseUrl)
abstract class AllShowsRestClient {
  factory AllShowsRestClient(Dio dio, {String baseUrl}) = _AllShowsRestClient;

  @GET(kAllShowsPath)
  Future<AllShowsData> getAllShows(@Header("Authorization") String JWT);
}
