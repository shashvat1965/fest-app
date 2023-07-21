import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class OasisTextStyles {
  static TextStyle openSans600 = GoogleFonts.openSans(
      textStyle: TextStyle(
          color: Colors.black,
          fontSize: 23.31.sp,
          fontWeight: FontWeight.w600));
  static TextStyle openSans400 = GoogleFonts.openSans(
      textStyle: TextStyle(
          color: const Color(0xFF9A9A9A),
          fontSize: 18.sp,
          fontWeight: FontWeight.w400));

  static TextStyle inter500 = GoogleFonts.openSans(
      textStyle: TextStyle(
          color: Colors.white, fontSize: 28.sp, fontWeight: FontWeight.w500));

  static TextStyle openSans300 = GoogleFonts.openSans(
    textStyle: TextStyle(
        color: Colors.black, fontSize: 17.47.sp, fontWeight: FontWeight.w300),
  );
  static TextStyle openSansSubHeading = GoogleFonts.openSans(
    textStyle: TextStyle(
        color: Colors.black, fontSize: 20.sp, fontWeight: FontWeight.w700),
  );
}
