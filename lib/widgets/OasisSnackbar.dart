import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomSnackBar {
  SnackBar oasisSnackBar(String? text) {
    return SnackBar(
      duration: const Duration(seconds: 2),
      content: Text(
        text ?? "Unknown Error",
        textAlign: TextAlign.center,
        style: GoogleFonts.openSans(
          color: Color.fromRGBO(204, 175, 45, 1),
          fontWeight: FontWeight.w300,
          fontSize: 15.sp,
        ),
      ),
      backgroundColor: Color.fromRGBO(14, 16, 20, 1),
      behavior: SnackBarBehavior.floating,
    );
  }
}
