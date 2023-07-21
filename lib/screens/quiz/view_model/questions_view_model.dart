import 'package:dio/dio.dart';

import '/screens/quiz/repo/model/get_questions_model.dart';
import '/screens/quiz/repo/model/get_rules_model.dart';
import '/screens/quiz/repo/model/post_answer_model.dart';
import '/screens/quiz/repo/retrofit/get_leaderboard_retrofit.dart';
import '/screens/quiz/repo/retrofit/get_progress_retrofit.dart';
import '/screens/quiz/repo/retrofit/get_rules_retrofit.dart';
import '../../../provider/user_details_viewmodel.dart';
import '../repo/model/get_leaderboard_model.dart';
import '../repo/model/get_progress_model.dart';
import '../repo/retrofit/get_questions_retrofit.dart';
import '../repo/retrofit/post_answer_retrofit.dart';

class QuizScreenViewModel {
  static String? error;

  Future<int> getProgress() async {
    final dio = Dio();
    final client = ProgressRestClient(dio);
    String? jwt = UserDetailsViewModel.userDetails.JWT;
    String auth = "JWT $jwt";
    Progress progress = await client.getProgress(auth);
    return progress.progress! + 1;
  }

  int getRoundNumber(int questionNumber) {
    if (questionNumber % 5 != 0) {
      return questionNumber ~/ 5 + 1;
    } else {
      return questionNumber ~/ 5;
    }
  }

  Future<void> postAnswers(int? question_id, int? answer_id) async {
    PostAnswers postAnswers =
        PostAnswers(question_id: question_id, answer_id: answer_id);
    final dio = Dio();
    final client = PostAnswersRestClient(dio);
    String jwt = "JWT ${UserDetailsViewModel.userDetails.JWT}";
    try {
      await client.postAnswer(jwt, postAnswers);
    } catch (e) {
      if (e.runtimeType == DioError) {
        var res = (e as DioError).response;
        if (res == null) {
          throw Exception("no net");
        } else {
          print(e.response!.data);
          throw Exception(e.response!.data["display_message"]);
        }
      }
      throw Exception("Unknown Error Occurred");
    }
    return;
  }

  int getQuestionNumber(int questionNumber) {
    if (questionNumber <= 5) {
      return questionNumber;
    } else if ((questionNumber % 5) == 0) {
      return 5;
    } else {
      return questionNumber % 5;
    }
  }

  List<int> getPostAnswerArray(List<int> optionArray, List<String?> optionText,
      Map<int, String> optionMap) {
    if (optionArray == [0, 0, 0, 0]) {
      throw Exception("Select an Option");
    }
    List<int> postArray = [];
    List<int> optionsClicked = [];
    for (int i = 0; i < 4; i++) {
      if (optionArray[i] == 1) {
        optionsClicked.add(i);
      }
    }
    List<String?> optionsClickedStringList = [];
    for (int i in optionsClicked) {
      optionsClickedStringList.add(optionText[i]);
    }
    for (String i in optionMap.values) {
      for (String? j in optionsClickedStringList) {
        if (i == j) {
          postArray.add(
              optionMap.keys.firstWhere((element) => optionMap[element] == i));
        }
      }
    }
    return postArray;
  }

  String? getQuestionText(int questionNumber, Questions questions) {
    String? questionText;
    for (Question i in questions.active_questions!) {
      if (i.question_no == questionNumber) {
        questionText = i.question_text;
      }
    }
    return questionText;
  }

  Map<int, String> getQuestionOption(int questionNumber, Questions questions) {
    Map<int, String> optionMap = {};
    for (Question i in questions.active_questions!) {
      if (i.question_no == questionNumber) {
        for (int j = 0; j < 4; j++) {
          optionMap[i.option_ids[j]!] = i.option_texts[j]!;
        }
      }
    }
    return optionMap;
  }

  // int? getQuestionTime(int questionNumber, Questions questions) {
  //   int? time;
  //   for (Question i in questions.active_questions!) {
  //     if (i.question_no == questionNumber) {
  //       time = i.time_given;
  //     }
  //   }
  //   return time;
  // }
  //
  // String? getQuestionImage(int questionNumber, Questions questions) {
  //   String? link;
  //   for (Question i in questions.active_questions!) {
  //     if (i.question_no == questionNumber) {
  //       link = i.image_link;
  //     }
  //   }
  //   return link;
  // }

  Future<Questions> getQuestionslist() async {
    final dio = Dio();
    String auth = "JWT ${UserDetailsViewModel.userDetails.JWT}";
    final questionsclient = QuestionsRestClient(dio);
    Questions listOfQuestion = await questionsclient.getAllQuestions(auth);
    return listOfQuestion;
  }

  Future<Users> getLeaderboard() async {
    final dio = Dio();
    String auth = "JWT ${UserDetailsViewModel.userDetails.JWT}";
    final usersclient = UsersRestClient(dio);
    Users leaderboard = await usersclient.getUsers(auth);
    return leaderboard;
  }

  //  Question getquestion(Questions listOfQuestionResult,int i)  {
  //   Question question = listOfQuestionResult.active_questions[i];
  //   return question;
  //   }
  Future<Rules> getRuleslist() async {
    final dio = Dio();
    String auth = "JWT ${UserDetailsViewModel.userDetails.JWT}";
    final rulesclient = RulesRestClient(dio);
    Rules listOfRule = await rulesclient.getAllRules(auth);
    return listOfRule;
  }
//  Rule getrule(Rules listOfRuleResult,int i)  {
//   Rule rule = listOfRuleResult.rounds[i];
//   return rule;
//   }

}
