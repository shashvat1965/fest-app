import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:oasis_2022/screens/login/repository/model/forgotPasswordData.dart';
import 'package:oasis_2022/screens/login/view_model/forgotpwd_view_model.dart';
import 'package:oasis_2022/utils/ui_utils.dart';
import 'package:oasis_2022/widgets/OkButton.dart';
import 'package:oasis_2022/widgets/error_dialogue.dart';

class ForgotPasswordDialog extends StatefulWidget {
  ForgotPasswordDialog({Key? key}) : super(key: key);

  @override
  State<ForgotPasswordDialog> createState() => _ErrorDialogState();
}

class _ErrorDialogState extends State<ForgotPasswordDialog> {
  TextEditingController emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    bool isPressed = false;
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Card(
        color: Colors.black,
        clipBehavior: Clip.hardEdge,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.black,
          ),
          width: UIUtills().getProportionalWidth(width: 408),
          height: UIUtills().getProportionalHeight(height: 250),
          child: Column(
            children: [
              SizedBox(
                height: 40.h,
              ),
              Padding(
                padding: EdgeInsets.only(left: 32.w, right: 32.w),
                child: TextFormField(
                  // cursorColor: const Color.fromRGBO(255, 255, 255, 0.7),
                  controller: emailController,
                  validator: (value) {},
                  style: GoogleFonts.openSans(
                      fontSize: 16.sp,
                      color: const Color.fromRGBO(255, 255, 255, 0.7)),

                  decoration: InputDecoration(
                      fillColor: const Color(0xFF1A1C1C),
                      contentPadding:
                          EdgeInsets.only(top: 19.h, bottom: 19.h, left: 24.w),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.7936.r),
                          borderSide:
                              const BorderSide(color: Color(0xFFF8D848))),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.7936.r),
                          borderSide:
                              const BorderSide(color: Color(0xFFF8D848))),
                      filled: true,
                      // fillColor: const Color(0xFF1A1C1C),
                      hintText: "Enter your email id used during registration",
                      hintStyle: GoogleFonts.openSans(
                          fontSize: 15.w,
                          color: const Color.fromRGBO(255, 255, 255, 0.7))),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                    bottom: UIUtills().getProportionalHeight(height: 35),
                    left: UIUtills().getProportionalWidth(width: 50),
                    right: UIUtills().getProportionalWidth(width: 50),
                    top: UIUtills().getProportionalHeight(height: 10)),
              ),
              TextButton(
                  onPressed: () async {
                    if (isPressed) {
                    } else {
                      isPressed = true;
                      if (emailController.text.isNotEmpty) {
                        ForgotPasswordResponse forgotPasswordResponse =
                            await ForgotPasswordViewModel()
                                .forgotPassword(emailController.text);
                        isPressed = false;
                        if (forgotPasswordResponse.display_message == null) {
                          Navigator.pop(context);
                          showDialog(
                              barrierDismissible: false,
                              context: context,
                              builder: (context) {
                                return Align(
                                  alignment: Alignment.bottomCenter,
                                  child: ErrorDialog(
                                      isSuccesspopup: true,
                                      errorMessage:
                                          'Login with the credentials sent on your email'),
                                );
                              });
                        } else {
                          isPressed = false;
                          showDialog(
                              barrierDismissible: false,
                              context: context,
                              builder: (context) {
                                return Align(
                                  alignment: Alignment.bottomCenter,
                                  child: ErrorDialog(
                                      errorMessage: forgotPasswordResponse
                                          .display_message),
                                );
                              });
                        }
                      } else {
                        isPressed = false;
                        showDialog(
                            barrierDismissible: false,
                            context: context,
                            builder: (context) {
                              return Align(
                                alignment: Alignment.bottomCenter,
                                child: ErrorDialog(
                                    errorMessage: 'Enter an email id'),
                              );
                            });
                      }
                    }
                  },
                  child: OkButton(
                    buttonText: 'Send email',
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
