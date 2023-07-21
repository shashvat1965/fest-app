import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:oasis_2022/screens/tickets/controller/store_controller.dart';
import 'package:oasis_2022/screens/tickets/repository/model/showsData.dart';
import 'package:oasis_2022/screens/tickets/view/buy_ticket.dart';
import 'package:oasis_2022/screens/tickets/view_model/get_signedtickets_view_model.dart';

class BannerDetails extends StatefulWidget {
  const BannerDetails({Key? key}) : super(key: key);

  @override
  State<BannerDetails> createState() => _BannerDetailsState();
}

class _BannerDetailsState extends State<BannerDetails> {
  ValueNotifier<bool> isLoading = ValueNotifier(true);

  String Time(String timestamp) {
    String time = "";
    for (int i = 0; i < timestamp.length; i++) {
      if (timestamp[i] == "T") {
        time = "$time ";
      } else {
        time = time + timestamp[i];
      }
      if (timestamp[i] == "Z") {}
    }
    int hour = DateTime.parse(time).hour;
    int minute = DateTime.parse(time).minute;
    String k = "AM";
    if (hour > 12) {
      hour = hour - 12;
      k = "PM";
    }
    String finalTime = "$hour:$minute $k";

    return finalTime;
  }

  String Date(String timestamp) {
    String date = "";
    for (int i = 0; i < timestamp.length; i++) {
      if (i > 4 && i < 7) {
        date = date + timestamp[i];
      }
    }
    return date;
  }

  @override
  void initState() {
    super.initState();
    StoreController.itemNumber.addListener(() {
      if (!mounted) {}
      setState(() {});
    });
    StoreController.itemBoughtOrRefreshed.addListener(() async {
      if (!mounted) {}
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListView(physics: const NeverScrollableScrollPhysics(), children: [
      SizedBox(
        width: 387.w,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ShaderMask(
              blendMode: BlendMode.srcIn,
              shaderCallback: (bounds) => const LinearGradient(colors: [
                Color.fromRGBO(207, 150, 0, 1),
                Color.fromRGBO(174, 186, 102, 1),
              ], transform: GradientRotation(161.5))
                  .createShader(
                      Rect.fromLTWH(0, 0, bounds.width.w, bounds.height.h)),
              child: Text(
                (StoreController.carouselItems[StoreController.itemNumber.value]
                        as StoreItemData)
                    .name!,
                style: GoogleFonts.openSans(
                    fontSize: 36.sp,
                    fontWeight: FontWeight.bold,
                    height: 1.1.h),
              ),
            ),
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(padding: EdgeInsets.only(top: 5.h)),
                    Text(
                      "${(StoreController.carouselItems[StoreController.itemNumber.value] as StoreItemData).venue}",
                      textScaleFactor: 1.0,
                      style: GoogleFonts.openSans(
                          fontWeight: FontWeight.bold,
                          fontSize: 18.sp,
                          color: Colors.white),
                    ),
                    Text(
                      "${Date((StoreController.carouselItems[StoreController.itemNumber.value] as StoreItemData).timestamp!)} Nov, ${Time((StoreController.carouselItems[StoreController.itemNumber.value] as StoreItemData).timestamp!)}",
                      textScaleFactor: 1.0,
                      style: GoogleFonts.openSans(
                          fontWeight: FontWeight.w500,
                          fontSize: 16.sp,
                          color: Color.fromRGBO(255, 255, 255, 0.5)),
                    ),

                    SizedBox(
                      height: 12.h,
                    ),
                    Row(
                      children: [
                        Text(
                          "Used: ${GetSignedTicketsViewModel().getUsedTickets(StoreController().getId(null))}",
                          textScaleFactor: 1.0,
                          textAlign: TextAlign.start,

                          style: GoogleFonts.openSans(
                              fontSize: 15.sp, color: Colors.grey ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 21.w),
                          child: Text(
                            "Unused: ${GetSignedTicketsViewModel().getUnusedTickets(StoreController().getId(null))}",
                            textScaleFactor: 1.0,
                            textAlign: TextAlign.start,
                            style: GoogleFonts.openSans(
                                fontSize: 15.sp,
                                color: Colors.amberAccent),
                          ),
                        )
                      ],
                    )
                  ],
                ),
                Padding(
                  padding: EdgeInsets.only(right: 21.w),
                  child: GestureDetector(
                    onTap: () async {
                      if ((StoreController.carouselItems[StoreController
                              .itemNumber.value] as StoreItemData)
                          .tickets_available!) {
                        showDialog(
                            context: context,
                            builder: (context) => const BuyTicket());
                      } else {}
                    },
                    child: Container(
                      height: 46.h,
                      width: 132.w,
                      decoration: BoxDecoration(
                          gradient: (StoreController.carouselItems[
                                          StoreController.itemNumber.value]
                                      as StoreItemData)
                                  .tickets_available!
                              ? const LinearGradient(colors: [
                                  Color.fromRGBO(209, 154, 8, 1),
                                  Color.fromRGBO(254, 212, 102, 1),
                                  Color.fromRGBO(227, 186, 79, 1),
                                  Color.fromRGBO(209, 154, 8, 1),
                                  Color.fromRGBO(209, 154, 8, 1),
                                ])
                              : const LinearGradient(colors: [
                                  Color.fromRGBO(148, 145, 137, 1),
                                  Color.fromRGBO(146, 143, 135, 1),
                                  Color.fromRGBO(152, 150, 143, 1),
                                  Color.fromRGBO(149, 146, 138, 1),
                                  Color.fromRGBO(131, 125, 110, 1),
                                  Color.fromRGBO(126, 126, 125, 1)
                                ]),
                          borderRadius: BorderRadius.circular(10.r)),
                      child: Center(
                        child: Text(
                          (StoreController.carouselItems[StoreController
                                      .itemNumber.value] as StoreItemData)
                                  .tickets_available!
                              ? "Buy Tickets"
                              : "Sold Out",
                          style: GoogleFonts.openSans(
                              color: Colors.black,
                              fontSize: 18.sp,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    ]);
  }
}
