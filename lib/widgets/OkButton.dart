import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../utils/ui_utils.dart';

class OkButton extends StatelessWidget {
  OkButton({Key? key, this.buttonText}) : super(key: key);
  String? buttonText;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: buttonText == null ? 258.w : 200.w,
      height: buttonText == null ? 59.h : 50.h,
      //padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: const Color(0xFFFFFFFF),
        boxShadow: const [
          BoxShadow(
            color: Color.fromRGBO(0, 0, 0, 0.2),
            offset: Offset(0, 2),
            blurRadius: 3,
          )
        ],
        borderRadius: BorderRadius.circular(15),
        gradient: const LinearGradient(colors: [
          Color.fromRGBO(209, 154, 8, 1),
          Color.fromRGBO(254, 212, 102, 1),
          Color.fromRGBO(227, 186, 79, 1),
          Color.fromRGBO(209, 154, 8, 1),
          Color.fromRGBO(209, 154, 8, 1),
        ]),
      ),
      child: Center(
        child: Text(
          buttonText ?? 'Ok',
          style: GoogleFonts.openSans(
              color: Colors.black,
              fontSize: UIUtills().getProportionalWidth(width: 24.00),
              fontWeight:
                  buttonText == null ? FontWeight.w800 : FontWeight.w700),
        ),
      ),
    );
  }
}
