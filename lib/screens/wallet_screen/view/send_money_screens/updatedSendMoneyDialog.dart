import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:oasis_2022/home.dart';

class UpdatedSendMoneyDialogBox extends StatefulWidget {
  const UpdatedSendMoneyDialogBox({super.key, required this.isSuccessful});
  final bool isSuccessful;
  @override
  State<UpdatedSendMoneyDialogBox> createState() =>
      _UpdatedSendMoneyDialogBoxState();
}

class _UpdatedSendMoneyDialogBoxState extends State<UpdatedSendMoneyDialogBox> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(
          top: 32.h,
          left: 30.w,
          right: 30.w,
          bottom: 235.h,
        ),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                  onPressed: () {
                    Navigator.pushAndRemoveUntil<void>(
                      context,
                      MaterialPageRoute<void>(
                          builder: (BuildContext context) =>
                              const HomeScreen()),
                      (route) => false,
                    );
                  },
                  icon: SvgPicture.asset(
                    'assets/icons/cross_icon.svg',
                    color: Colors.white,
                  ),
                )
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 248.h),
                widget.isSuccessful
                    ? SvgPicture.asset(
                        'assets/images/moneyaddedsuccess.svg',
                        height: 177.h,
                        width: 222.w,
                      )
                    : SvgPicture.asset(
                        'assets/images/moneyaddedfailure.svg',
                        height: 177.h,
                        width: 222.w,
                      ),
                SizedBox(height: 44.h),
                widget.isSuccessful
                    ? Text(
                        'Money Sent Successfully.',
                        textScaleFactor: 1.0,
                        style: GoogleFonts.openSans(
                            fontWeight: FontWeight.w400,
                            fontSize: 18.sp,
                            color: Color.fromRGBO(255, 255, 255, 0.8)),
                      )
                    : Text(
                        'Something went wrong.',
                        textScaleFactor: 1.0,
                        style: GoogleFonts.openSans(
                            fontWeight: FontWeight.w400,
                            fontSize: 18.sp,
                            color: Color.fromRGBO(255, 255, 255, 0.8)),
                      )
              ],
            )
          ],
        ),
      ),
    );
  }
}
