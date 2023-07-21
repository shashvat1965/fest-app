import 'package:dio/dio.dart';

import '../../../provider/user_details_viewmodel.dart';
import '../repo/model/get_questions_model.dart';
import '../repo/retrofit/get_questions_retrofit.dart';

class Quizviewmodel {
  Future<Questions> getQuestionslist() async {
    final dio = Dio();
    String auth = "JWT ${UserDetailsViewModel.userDetails.JWT}";
    final questionsclient = QuestionsRestClient(dio);
    Questions listOfQuestion = await questionsclient.getAllQuestions(auth);
    return listOfQuestion;
  }

  String? getQuestionText(Questions questions) {
    String? questionText;
    for (Question i in questions.active_questions!) {
      if (i.question_no == 1) {
        questionText = i.question_text;
      }
    }
    return questionText;
  }

  List<String?> getOptionText(Questions questions) {
    List<String?> optiontexts = [];
    for (Question i in questions.active_questions!) {
      if (i.question_no == 1) {
        optiontexts = i.option_texts;
      }
    }
    return optiontexts;
  }
}
