import '/screens/quiz/repo/model/get_questions_model.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/http.dart';

import '../../../../utils/urls.dart';
part 'get_questions_retrofit.g.dart';

@RestApi(baseUrl: kBaseUrl)
abstract class QuestionsRestClient {
  factory QuestionsRestClient(Dio dio, {String baseUrl}) = _QuestionsRestClient;

  @GET('')
  Future<Questions> getAllQuestions(@Header("Authorization") String JWT);
}
