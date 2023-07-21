import '/screens/quiz/repo/model/post_answer_model.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/http.dart';

import '../../../../utils/urls.dart';
part 'post_answer_retrofit.g.dart';

@RestApi(baseUrl: kBaseUrl)
abstract class PostAnswersRestClient {
  factory PostAnswersRestClient(Dio dio, {String baseUrl}) =
      _PostAnswersRestClient;

  @POST('')
  Future<void> postAnswer(
      @Header("Authorization") String JWT, @Body() PostAnswers postAnswers);
}
