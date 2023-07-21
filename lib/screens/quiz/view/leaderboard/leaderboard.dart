import '/screens/quiz/view_model/questions_view_model.dart';
import '/utils/ui_utils.dart';
import '/widgets/loader.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../widgets/app_bar.dart';
import '../../repo/model/get_leaderboard_model.dart';

class Leaderboard extends StatefulWidget {
  const Leaderboard({super.key});

  @override
  State<Leaderboard> createState() => _LeaderboardState();
}

class _LeaderboardState extends State<Leaderboard> {
  Users results = Users();
  ValueNotifier<bool> isLoading = ValueNotifier(true);

  @override
  void initState() {
    getUsers();
    super.initState();
  }

  Future<void> getUsers() async {
    results = await QuizScreenViewModel().getLeaderboard();
    isLoading.value = false;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(kToolbarHeight),
          child: CustomAppBar(
              title: "Leaderboard",
              isactionButtonRequired: false,
              isBackButtonRequired: true),
        ),
        backgroundColor: Color(0xFFFAFAFF),
        body: ValueListenableBuilder(
            valueListenable: isLoading,
            builder: (context, value, widge) {
              if (isLoading.value) {
                return const Center(child: Loader());
              } else {
                return Container(
                    // height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width,
                    child: Column(children: [
                      Container(
                        child: SizedBox(
                          width: UIUtills().getProportionalWidth(width: 357.00),
                          height:
                              UIUtills().getProportionalHeight(height: 305.00),
                          child: Stack(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Container(
                                    width: UIUtills()
                                        .getProportionalWidth(width: 102.00),
                                    child: Column(
                                      children: [
                                        SizedBox(
                                          height: UIUtills()
                                              .getProportionalHeight(
                                                  height: 58.00),
                                        ),
                                        SvgPicture.asset(
                                          'assets/images/leaderboardSilverTrophy.svg',
                                          width: UIUtills()
                                              .getProportionalWidth(
                                                  width: 70.00),
                                          height: UIUtills()
                                              .getProportionalHeight(
                                                  height: 70.00),
                                        ),
                                        SizedBox(
                                          height: UIUtills()
                                              .getProportionalHeight(
                                                  height: 5.00),
                                        ),
                                        Text(
                                          "${results.users![1].name.toString()}",
                                          style: GoogleFonts.poppins(
                                              color: Colors.black,
                                              fontWeight: FontWeight.w500,
                                              fontSize: UIUtills()
                                                  .getProportionalWidth(
                                                      width: 16.00),
                                              letterSpacing: UIUtills()
                                                  .getProportionalWidth(
                                                      width: -0.41)),
                                          textAlign: TextAlign.center,
                                        ),
                                        SizedBox(
                                          height: UIUtills()
                                              .getProportionalHeight(
                                                  height: 1.50),
                                        ),
                                        Text(
                                          "${results.users![1].points.toString()}",
                                          style: GoogleFonts.poppins(
                                              color: Color.fromRGBO(
                                                  117, 117, 117, 1),
                                              fontWeight: FontWeight.w600,
                                              fontSize: UIUtills()
                                                  .getProportionalWidth(
                                                      width: 11.00),
                                              letterSpacing: UIUtills()
                                                  .getProportionalWidth(
                                                      width: -0.41)),
                                        ),
                                        SizedBox(
                                          height: UIUtills()
                                              .getProportionalHeight(
                                                  height: 2.00),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    width: UIUtills()
                                        .getProportionalWidth(width: 20.00),
                                  ),
                                  Column(
                                    children: [
                                      SizedBox(
                                        height: UIUtills()
                                            .getProportionalHeight(
                                                height: 16.00),
                                      ),
                                      SvgPicture.asset(
                                        'assets/images/leaderboardGoldTrophy.svg',
                                        width: UIUtills()
                                            .getProportionalWidth(width: 82.00),
                                        height: UIUtills()
                                            .getProportionalHeight(
                                                height: 82.00),
                                      ),
                                      SizedBox(
                                        height: UIUtills()
                                            .getProportionalHeight(
                                                height: 3.00),
                                      ),
                                      Text(
                                        "${results.users![0].name.toString()}",
                                        style: GoogleFonts.poppins(
                                            color: Colors.black,
                                            fontWeight: FontWeight.w500,
                                            fontSize: UIUtills()
                                                .getProportionalWidth(
                                                    width: 16.00),
                                            letterSpacing: UIUtills()
                                                .getProportionalWidth(
                                                    width: -0.41)),
                                        textAlign: TextAlign.center,
                                      ),
                                      SizedBox(
                                        height: UIUtills()
                                            .getProportionalHeight(
                                                height: 0.00),
                                      ),
                                      Text(
                                        "${results.users![0].points.toString()}",
                                        style: GoogleFonts.poppins(
                                            color: Color.fromRGBO(
                                                117, 117, 117, 1),
                                            fontWeight: FontWeight.w600,
                                            fontSize: UIUtills()
                                                .getProportionalWidth(
                                                    width: 11.00),
                                            letterSpacing: UIUtills()
                                                .getProportionalWidth(
                                                    width: -0.41)),
                                      ),
                                      SizedBox(
                                        height: UIUtills()
                                            .getProportionalHeight(
                                                height: 3.00),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    width: UIUtills()
                                        .getProportionalWidth(width: 20.00),
                                  ),
                                  Container(
                                    width: UIUtills()
                                        .getProportionalWidth(width: 110.00),
                                    child: Column(
                                      children: [
                                        SizedBox(
                                          height: UIUtills()
                                              .getProportionalHeight(
                                                  height: 80.00),
                                        ),
                                        SvgPicture.asset(
                                          'assets/images/leaderboardBronzeTrophy.svg',
                                          width: UIUtills()
                                              .getProportionalWidth(
                                                  width: 58.00),
                                          height: UIUtills()
                                              .getProportionalHeight(
                                                  height: 58.00),
                                        ),
                                        SizedBox(
                                          height: UIUtills()
                                              .getProportionalHeight(
                                                  height: 5.00),
                                        ),
                                        Flexible(
                                          child: Text(
                                            "${results.users![2].name.toString()}",
                                            style: GoogleFonts.poppins(
                                                color: Colors.black,
                                                fontWeight: FontWeight.w500,
                                                fontSize: UIUtills()
                                                    .getProportionalWidth(
                                                        width: 16.00),
                                                letterSpacing: UIUtills()
                                                    .getProportionalWidth(
                                                        width: -0.41)),
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                        SizedBox(
                                          height: UIUtills()
                                              .getProportionalHeight(
                                                  height: 2.00),
                                        ),
                                        Text(
                                          "${results.users![2].points.toString()}",
                                          style: GoogleFonts.poppins(
                                              color: Color.fromRGBO(
                                                  117, 117, 117, 1),
                                              fontWeight: FontWeight.w600,
                                              fontSize: UIUtills()
                                                  .getProportionalWidth(
                                                      width: 11.00),
                                              letterSpacing: UIUtills()
                                                  .getProportionalWidth(
                                                      width: -0.41)),
                                        ),
                                        SizedBox(
                                          height: UIUtills()
                                              .getProportionalHeight(
                                                  height: 4.00),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              Positioned(
                                bottom: 0,
                                left: 0,
                                right: 0,
                                child: Image.asset(
                                  'assets/images/podium.png',
                                  // height: UIUtills().getProportionalHeight(height: 139),
                                  // width: UIUtills().getProportionalWidth(width: 357),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(
                              strokeAlign: StrokeAlign.inside,
                              width:
                                  UIUtills().getProportionalWidth(width: 0.8),
                              color: Color.fromRGBO(218, 218, 218, 0.5),
                            ),
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: const [
                              BoxShadow(
                                color: Color.fromRGBO(116, 126, 241, 0.2),
                                blurRadius: 6,
                                offset: Offset(0, 4),
                              ),
                            ],
                          ),
                          height:
                              UIUtills().getProportionalHeight(height: 400.00),
                          margin: EdgeInsets.only(
                              left:
                                  UIUtills().getProportionalWidth(width: 20.00),
                              right: UIUtills()
                                  .getProportionalWidth(width: 20.00)),
                          padding: EdgeInsets.only(
                              left:
                                  UIUtills().getProportionalWidth(width: 20.00),
                              right: UIUtills()
                                  .getProportionalWidth(width: 20.00)),
                          child: ListView.builder(
                              scrollDirection: Axis.vertical,
                              shrinkWrap: true,
                              itemCount: 1,
                              itemBuilder: (context, index) {
                                return Container(
                                  height: UIUtills()
                                      .getProportionalHeight(height: 60.00),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      CircleAvatar(
                                        radius: UIUtills()
                                            .getProportionalHeight(
                                                height: 13.00),
                                        backgroundColor: Color(0xFFF3F3F3),
                                        child: Text(
                                          " ${index + 4}",
                                          style: GoogleFonts.roboto(
                                              color: Colors.black,
                                              fontWeight: FontWeight.w500,
                                              fontSize: UIUtills()
                                                  .getProportionalWidth(
                                                      width: 13.08),
                                              letterSpacing: UIUtills()
                                                  .getProportionalWidth(
                                                      width: -0.41)),
                                        ),
                                      ),
                                      SizedBox(
                                        width: UIUtills()
                                            .getProportionalWidth(width: 20.00),
                                      ),
                                      Text(
                                        "${results.users![index + 3].name.toString().split(" ")[0]}",
                                        style: GoogleFonts.roboto(
                                            color: Colors.black,
                                            fontWeight: FontWeight.w600,
                                            fontSize: UIUtills()
                                                .getProportionalWidth(
                                                    width: 20.00),
                                            letterSpacing: UIUtills()
                                                .getProportionalWidth(
                                                    width: -0.41)),
                                      ),
                                      SizedBox(
                                        width: UIUtills().getProportionalWidth(
                                            width: 158.00),
                                      ),
                                      Text(
                                        "${results.users![index + 3].points.toString()}",
                                        style: GoogleFonts.roboto(
                                            color: Color(0xFF747EF1),
                                            fontWeight: FontWeight.w500,
                                            fontSize: UIUtills()
                                                .getProportionalWidth(
                                                    width: 14.00),
                                            letterSpacing: UIUtills()
                                                .getProportionalWidth(
                                                    width: -0.41)),
                                      ),
                                    ],
                                  ),
                                );
                              })),
                      Divider(
                        color: Color.fromRGBO(218, 218, 218, 0.5),
                        thickness:
                            UIUtills().getProportionalHeight(height: 1.00),
                      ),
                    ]));
              }
            }));
  }
}
