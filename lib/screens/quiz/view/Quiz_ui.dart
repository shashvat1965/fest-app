import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:oasis_2022/screens/quiz/view_model/questions_view_model.dart';
import 'package:oasis_2022/utils/ui_utils.dart';
import 'package:oasis_2022/widgets/OasisSnackbar.dart';
import 'package:oasis_2022/widgets/loader.dart';

import '../repo/model/get_questions_model.dart';
import '../view_model/poll_view_model.dart';

class quizUIScreen extends StatefulWidget {
  const quizUIScreen({Key? key}) : super(key: key);

  @override
  State<quizUIScreen> createState() => _quizUIScreenState();
}

class _quizUIScreenState extends State<quizUIScreen> {
  var optionArray = [0, 0, 0, 0];
  ValueNotifier<bool> isLoading = ValueNotifier(true);
  Questions questionList = Questions();
  String? questionText = "";
  List<String?> optionstexts = [];

  @override
  void initState() {
    getRules();
    super.initState();
  }

  Future<void> getRules() async {
    questionList = await Quizviewmodel().getQuestionslist();
    questionText = Quizviewmodel().getQuestionText(questionList);
    optionstexts = Quizviewmodel().getOptionText(questionList);
    isLoading.value = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ValueListenableBuilder(
        valueListenable: isLoading,
        builder: (context, bool value, child) {
          if (value) {
            return const Loader();
          } else {
            return questionList.active_questions!.isEmpty
                ? Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: 300.w, top: 100.h),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Container(
                            decoration: BoxDecoration(
                                color: Colors.transparent,
                                borderRadius: BorderRadius.circular(5)),
                            height: 36.h,
                            width: 36.w,
                            child: const Icon(
                              Icons.close,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            bottom: 30.h, top: 150.h, left: 20.w, right: 20.w),
                        child: SvgPicture.asset(
                          "assets/images/no_poll.svg",
                          width: 388.w,
                          height: 244.w,
                        ),
                      ),
                      Text(
                        "No Poll Active Right Now",
                        style: GoogleFonts.openSans(
                            color: Colors.white,
                            fontSize: 18.sp,
                            fontWeight: FontWeight.w400),
                      )
                    ],
                  )
                : Padding(
                    padding: const EdgeInsets.fromLTRB(20, 72, 15, 0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Stand Up Soapbox',
                              style: GoogleFonts.openSans(
                                  color: Colors.white,
                                  fontSize: 28.sp,
                                  fontWeight: FontWeight.w500),
                            ),
                            GestureDetector(
                                onTap: () {
                                  print('object');
                                  Navigator.pop(context);
                                },
                                child: SvgPicture.asset(
                                    'assets/images/exit_button.svg'))
                          ],
                        ),
                        SizedBox(
                          height: UIUtills().getProportionalHeight(height: 53),
                        ),
                        Text(
                          questionText ?? "",
                          style: GoogleFonts.openSans(
                              color: Colors.white, fontSize: 20),
                        ),
                        SizedBox(
                          height: UIUtills().getProportionalHeight(height: 53),
                        ),
                        Text(
                          'Select any one option',
                          style: GoogleFonts.openSans(
                              color: const Color.fromRGBO(255, 255, 255, 0.8),
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w300),
                        ),
                        SizedBox(
                          height: UIUtills().getProportionalHeight(height: 10),
                        ),
                        Column(
                          children: [
                            GestureDetector(
                                onTap: () {
                                  optionArray = [1, 0, 0, 0];

                                  setState(() {});
                                },
                                child: optionArray[0] == 0
                                    ? Container(
                                        decoration: BoxDecoration(
                                          color: const Color.fromRGBO(
                                              26, 28, 28, 1),
                                          border: Border.all(
                                            width: 1.0.w,
                                          ),
                                          borderRadius: BorderRadius.circular(
                                            UIUtills().getProportionalWidth(
                                                width: 8.00),
                                          ),
                                        ),
                                        width: UIUtills().getProportionalWidth(
                                            width: 384.00),
                                        height: UIUtills()
                                            .getProportionalHeight(
                                                height: 56.00),
                                        child: Center(
                                          child: Text(
                                            '${optionstexts[0]}',
                                            textAlign: TextAlign.start,
                                            style: GoogleFonts.openSans(
                                                color: Colors.white,
                                                fontSize: UIUtills()
                                                    .getProportionalWidth(
                                                        width: 18.00),
                                                fontWeight: FontWeight.w600,
                                                letterSpacing: UIUtills()
                                                    .getProportionalWidth(
                                                        width: -0.41)),
                                          ),
                                        ),
                                      )
                                    : Container(
                                        decoration: BoxDecoration(
                                          boxShadow: const [],
                                          gradient: const LinearGradient(
                                            colors: [
                                              Color.fromRGBO(209, 154, 8, 1),
                                              Color.fromRGBO(254, 212, 102, 1),
                                              Color.fromRGBO(227, 186, 79, 1),
                                              Color.fromRGBO(209, 154, 8, 1),
                                              Color.fromRGBO(209, 154, 8, 1),
                                            ],
                                          ),
                                          border: Border.all(
                                            width: 1.0,
                                          ),
                                          borderRadius: BorderRadius.circular(
                                            UIUtills().getProportionalWidth(
                                                width: 8.00),
                                          ),
                                        ),
                                        width: UIUtills().getProportionalWidth(
                                            width: 384.00),
                                        height: UIUtills()
                                            .getProportionalHeight(
                                                height: 56.00),
                                        child: Center(
                                          child: Text(
                                            '${optionstexts[0]}',
                                            textAlign: TextAlign.center,
                                            style: GoogleFonts.openSans(
                                                color: Colors.black,
                                                fontSize: UIUtills()
                                                    .getProportionalWidth(
                                                        width: 18.00),
                                                fontWeight: FontWeight.w600,
                                                letterSpacing: UIUtills()
                                                    .getProportionalWidth(
                                                        width: -0.41)),
                                          ),
                                        ),
                                      )),
                            SizedBox(
                                height: UIUtills()
                                    .getProportionalHeight(height: 20.00)),
                            GestureDetector(
                              onTap: () {
                                optionArray = [0, 1, 0, 0];
                                setState(() {});
                              },
                              child: optionArray[1] == 0
                                  ? Container(
                                      decoration: BoxDecoration(
                                        color:
                                            const Color.fromRGBO(26, 28, 28, 1),
                                        border: Border.all(
                                          width: 1.0,
                                        ),
                                        borderRadius: BorderRadius.circular(
                                          UIUtills().getProportionalWidth(
                                              width: 8.00),
                                        ),
                                      ),
                                      width: UIUtills()
                                          .getProportionalWidth(width: 384.00),
                                      height: UIUtills()
                                          .getProportionalHeight(height: 56.00),
                                      child: Center(
                                        child: Text(
                                          '${optionstexts[1]}',
                                          //   optionText[1],
                                          textAlign: TextAlign.start,
                                          style: GoogleFonts.openSans(
                                              color: Colors.white,
                                              fontSize: UIUtills()
                                                  .getProportionalWidth(
                                                      width: 18.00),
                                              fontWeight: FontWeight.w600,
                                              letterSpacing: UIUtills()
                                                  .getProportionalWidth(
                                                      width: -0.41)),
                                        ),
                                      ),
                                    )
                                  : Container(
                                      decoration: BoxDecoration(
                                        boxShadow: const [],
                                        color: const Color(0xFF747EF1),
                                        border: Border.all(
                                          width: 1.0,
                                        ),
                                        gradient: const LinearGradient(
                                          colors: [
                                            Color.fromRGBO(209, 154, 8, 1),
                                            Color.fromRGBO(254, 212, 102, 1),
                                            Color.fromRGBO(227, 186, 79, 1),
                                            Color.fromRGBO(209, 154, 8, 1),
                                            Color.fromRGBO(209, 154, 8, 1),
                                          ],
                                        ),
                                        borderRadius: BorderRadius.circular(
                                          UIUtills().getProportionalWidth(
                                              width: 8.00),
                                        ),
                                      ),
                                      width: UIUtills()
                                          .getProportionalWidth(width: 384.00),
                                      height: UIUtills()
                                          .getProportionalHeight(height: 56.00),
                                      child: Center(
                                        child: Text(
                                          '${optionstexts[1]}',
                                          // optionText[1],
                                          style: GoogleFonts.openSans(
                                              color: Colors.black,
                                              fontSize: UIUtills()
                                                  .getProportionalWidth(
                                                      width: 18.00),
                                              fontWeight: FontWeight.w600,
                                              letterSpacing: UIUtills()
                                                  .getProportionalWidth(
                                                      width: -0.41)),
                                        ),
                                      ),
                                    ),
                            ),
                            SizedBox(
                                height: UIUtills()
                                    .getProportionalHeight(height: 20.00)),
                            GestureDetector(
                              onTap: () {
                                optionArray = [0, 0, 1, 0];

                                setState(() {});
                              },
                              child: optionArray[2] == 0
                                  ? Container(
                                      decoration: BoxDecoration(
                                        color:
                                            const Color.fromRGBO(26, 28, 28, 1),
                                        border: Border.all(
                                          width: 1.0,
                                        ),
                                        borderRadius: BorderRadius.circular(
                                          UIUtills().getProportionalWidth(
                                              width: 8.00),
                                        ),
                                      ),
                                      width: UIUtills()
                                          .getProportionalWidth(width: 384.00),
                                      height: UIUtills()
                                          .getProportionalHeight(height: 56.00),
                                      child: Center(
                                        child: Text(
                                          '${optionstexts[2]}',
                                          // optionText[2],
                                          style: GoogleFonts.openSans(
                                              color: Colors.white,
                                              fontSize: UIUtills()
                                                  .getProportionalWidth(
                                                      width: 18.00),
                                              fontWeight: FontWeight.w600,
                                              letterSpacing: UIUtills()
                                                  .getProportionalWidth(
                                                      width: -0.41)),
                                        ),
                                      ),
                                    )
                                  : Container(
                                      decoration: BoxDecoration(
                                        boxShadow: const [],
                                        gradient: LinearGradient(
                                          colors: [
                                            Color.fromRGBO(209, 154, 8, 1),
                                            Color.fromRGBO(254, 212, 102, 1),
                                            Color.fromRGBO(227, 186, 79, 1),
                                            Color.fromRGBO(209, 154, 8, 1),
                                            Color.fromRGBO(209, 154, 8, 1),
                                          ],
                                        ),
                                        border: Border.all(
                                          width: 1.0,
                                        ),
                                        borderRadius: BorderRadius.circular(
                                          UIUtills().getProportionalWidth(
                                              width: 8.00),
                                        ),
                                      ),
                                      width: UIUtills()
                                          .getProportionalWidth(width: 384.00),
                                      height: UIUtills()
                                          .getProportionalHeight(height: 56.00),
                                      child: Center(
                                        child: Text(
                                          '${optionstexts[2]}',
                                          // optionText[2],
                                          style: GoogleFonts.openSans(
                                              color: Colors.black,
                                              fontSize: UIUtills()
                                                  .getProportionalWidth(
                                                      width: 18.00),
                                              fontWeight: FontWeight.w600,
                                              letterSpacing: UIUtills()
                                                  .getProportionalWidth(
                                                      width: -0.41)),
                                        ),
                                      ),
                                    ),
                            ),
                            SizedBox(
                                height: UIUtills()
                                    .getProportionalHeight(height: 20.00)),
                            GestureDetector(
                              onTap: () {
                                optionArray = [0, 0, 0, 1];

                                setState(() {});
                              },
                              child: optionArray[3] == 0
                                  ? Container(
                                      decoration: BoxDecoration(
                                        color:
                                            const Color.fromRGBO(26, 28, 28, 1),
                                        border: Border.all(
                                          width: 1.0,
                                        ),
                                        borderRadius: BorderRadius.circular(
                                          UIUtills().getProportionalWidth(
                                              width: 8.00),
                                        ),
                                      ),
                                      width: UIUtills()
                                          .getProportionalWidth(width: 384.00),
                                      height: UIUtills()
                                          .getProportionalHeight(height: 56.00),
                                      child: Center(
                                        child: Text(
                                          '${optionstexts[3]}',
                                          // optionText[3],
                                          style: GoogleFonts.openSans(
                                              color: Colors.white,
                                              fontSize: UIUtills()
                                                  .getProportionalWidth(
                                                      width: 18.00),
                                              fontWeight: FontWeight.w600,
                                              letterSpacing: UIUtills()
                                                  .getProportionalWidth(
                                                      width: -0.41)),
                                        ),
                                      ),
                                    )
                                  : Container(
                                      decoration: BoxDecoration(
                                        boxShadow: const [],
                                        gradient: const LinearGradient(
                                          colors: [
                                            Color.fromRGBO(209, 154, 8, 1),
                                            Color.fromRGBO(254, 212, 102, 1),
                                            Color.fromRGBO(227, 186, 79, 1),
                                            Color.fromRGBO(209, 154, 8, 1),
                                            Color.fromRGBO(209, 154, 8, 1),
                                          ],
                                        ),
                                        border: Border.all(
                                          width: 1.0,
                                        ),
                                        borderRadius: BorderRadius.circular(
                                          UIUtills().getProportionalWidth(
                                              width: 8.00),
                                        ),
                                      ),
                                      width: UIUtills()
                                          .getProportionalWidth(width: 384.00),
                                      height: UIUtills()
                                          .getProportionalHeight(height: 56.00),
                                      child: Center(
                                        child: Text(
                                          '${optionstexts[3]}',
                                          // optionText[3],
                                          style: GoogleFonts.openSans(
                                            color: Colors.black,
                                            fontSize: UIUtills()
                                                .getProportionalWidth(
                                                    width: 18.00),
                                            fontWeight: FontWeight.w600,
                                            letterSpacing: UIUtills()
                                                .getProportionalWidth(
                                                    width: -0.41),
                                          ),
                                        ),
                                      ),
                                    ),
                            ),
                          ],
                        ),
                        SizedBox(
                            height: UIUtills()
                                .getProportionalHeight(height: 45.00)),
                        Center(
                          child: GestureDetector(
                            onTap: () async {
                              try {
                                await QuizScreenViewModel()
                                    .postAnswers(1, optionSelected());
                                var snackbar = CustomSnackBar()
                                    .oasisSnackBar("Thanks For Answering");
                                if (!mounted) {}
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(snackbar);
                              } catch (e) {
                                try {
                                  var snackbar = CustomSnackBar()
                                      .oasisSnackBar(e.toString());
                                  if (!mounted) {}
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(snackbar);
                                } catch (e) {
                                  print(e);
                                  var snackbar = CustomSnackBar()
                                      .oasisSnackBar("Some Error Occurred");
                                  if (!mounted) {}
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(snackbar);
                                }
                              }
                            },
                            child: Container(
                              alignment: Alignment.center,
                              // alignment: Alignment.bottomCenter,
                              width: 171.w,
                              height: 52.h,
                              // margin: EdgeInsets.symmetric(
                              //     horizontal:
                              //     UIUtills().getProportionalWidth(width: 20.00)),
                              decoration: BoxDecoration(
                                gradient: const LinearGradient(
                                  colors: [
                                    Color.fromRGBO(209, 154, 8, 1),
                                    Color.fromRGBO(254, 212, 102, 1),
                                    Color.fromRGBO(227, 186, 79, 1),
                                    Color.fromRGBO(209, 154, 8, 1),
                                    Color.fromRGBO(209, 154, 8, 1),
                                  ],
                                ),
                                borderRadius: BorderRadius.circular(10.r),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'Submit',
                                    style: GoogleFonts.openSans(
                                        fontWeight: FontWeight.w600,
                                        color: Colors.black,
                                        fontSize: 14.sp),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        )
                      ],
                    ));
          }
        },
      ),
    );
  }

  int? optionSelected() {
    if (optionArray[0] == 1) {
      return 1;
    } else if (optionArray[1] == 1) {
      return 2;
    } else if (optionArray[2] == 1) {
      return 3;
    } else if (optionArray[3] == 1) {
      return 4;
    }
  }
}
