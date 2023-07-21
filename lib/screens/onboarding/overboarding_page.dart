import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:oasis_2022/screens/login/view/login_screen.dart';
import 'package:oasis_2022/utils/colors.dart';
import 'package:oasis_2022/utils/ui_utils.dart';
import 'package:oasis_2022/widgets/loader.dart';

import 'onboarding.dart';

class OnBoardingPage extends StatefulWidget {
  const OnBoardingPage({Key? key}) : super(key: key);

  @override
  State<OnBoardingPage> createState() => _OnBoardingPageState();
}

class _OnBoardingPageState extends State<OnBoardingPage> {
  PageController _controller = PageController(initialPage: 0, keepPage: false);

  List<Widget> onBoardingPages = const [
    OnBoarding(
        imagePath: 'assets/images/food_overboarding.svg',
        text:
            'Forget about the hassle of standing in long queues to order from the available stalls. Place orders and get live updates about the status of your order on the app.'),
    OnBoarding(
        imagePath: 'assets/images/events_overboarding.svg',
        text:
            'Stay updated and get notified with all the events happening on campus sorted by timings and location. Search for your favourite events by name, description and organiser.'),
    OnBoarding(
        imagePath: 'assets/images/tickets-overboarding.svg',
        text:
            'Buy tickets using the app and scan the QR code available on the wallet screen to enter the prof shows'),
    OnBoarding(
        imagePath: 'assets/images/merch_overboarding.svg',
        text:
            'Browse and shop for official Oasis 2022 merchandise directly from the App. Orders can be collected from the merch stall using the QR code in wallet'),
  ];

  double currentIndexPage = 0.0;
  bool onLastPage = false, hasLoader = false;

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Scaffold(
        body: Container(
      height: screenSize.height,
      width: screenSize.width,
      child: Column(
        children: [
          Expanded(
            child: PageView.builder(
              itemBuilder: (context, index) {
                return onBoardingPages[index];
              },
              itemCount: onBoardingPages.length,
              controller: _controller,
              onPageChanged: (index) {
                setState(() {
                  currentIndexPage = index.toDouble();
                  if (currentIndexPage == 3) {
                    onLastPage = true;
                  } else {
                    onLastPage = false;
                  }
                });
              },
            ),
          ),
          DotsIndicator(
            dotsCount: onBoardingPages.length,
            position: currentIndexPage,
            decorator: DotsDecorator(
              size: Size(24.w, 10.h),
              activeSize: Size(50.w, 10.h),
              activeColor: OasisColors.primaryYellow,
              color: Color(0xFF323232),
              // Inactive color
              spacing: EdgeInsets.symmetric(horizontal: 4.0.w),
              activeShape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5.0)),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5.0)),
            ),
          ),
          SizedBox(height: 113.h),
          Padding(
            padding: EdgeInsets.only(left: 40.w, right: 40.w, bottom: 55.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () {
                    Future.microtask(() {
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                              builder: (builder) => const LoginScreen()),
                          (route) => false);
                    });
                  },
                  child: hasLoader
                      ? const Loader()
                      : Row(
                          children: const [
                            Text(
                              "Skip",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontFamily: "Gilroy",
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ],
                        ),
                ),
                GestureDetector(
                  onTap: () {
                    onLastPage
                        ? Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                                builder: (builder) => const LoginScreen()),
                            (route) => false)
                        : _controller.nextPage(
                            curve: Curves.ease,
                            duration: Duration(milliseconds: 600));
                  },
                  child: Container(
                    alignment: Alignment.center,
                    width: 128.w,
                    height: 63.h,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30.r),
                        gradient: OasisColors.oasisWebsiteGoldGradient),
                    child: Text(
                      !onLastPage ? 'Next' : 'Login',
                      style: GoogleFonts.openSans(
                          textStyle: TextStyle(
                              color: Colors.black,
                              fontSize: 19.sp,
                              fontWeight: FontWeight.w700)),
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    ));
  }
}
