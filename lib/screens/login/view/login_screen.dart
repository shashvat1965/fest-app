import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:oasis_2022/screens/login/repository/model/gloginData.dart';
import 'package:oasis_2022/screens/login/view/forgot_password_dialog.dart';
import 'package:oasis_2022/widgets/OasisSnackbar.dart';

import '../../../provider/user_details_viewmodel.dart';
import '../../events/view/miscellaneous_screen.dart';
import '/widgets/error_dialogue.dart';
import '../../../main.dart';
import '../../../utils/colors.dart';
import '../../../utils/error_messages.dart';
import '../../../widgets/loader.dart';
import '../repository/model/data.dart';
import '../view_model/glogin_view_model.dart';
import '../view_model/login_view_model.dart';

GoogleSignIn _googleSignIn = GoogleSignIn(
  scopes: <String>[
    'email',
  ],
);

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen>
    with TickerProviderStateMixin {
  bool isHidden = true;
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  late AnimationController iconColorController;
  Animation? animation;

  late final AnimationController backgroundRotationController =
      AnimationController(
          vsync: this, duration: const Duration(milliseconds: 10000))
        ..repeat();
  late final Animation<double> _rotationAnimation =
      Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
          parent: backgroundRotationController, curve: Curves.linear));

  late final AnimationController passwordTextFieldShakeController =
      AnimationController(
    duration: const Duration(milliseconds: 150),
    vsync: this,
  );
  late final Animation<Offset> _passwordOffsetAnimation =
      TweenSequence<Offset>([
    TweenSequenceItem(
        tween: Tween<Offset>(begin: Offset.zero, end: const Offset(0.125, 0.0)),
        weight: 1),
    TweenSequenceItem(
        tween: Tween<Offset>(begin: const Offset(0.125, 0.0), end: Offset.zero),
        weight: 1),
    TweenSequenceItem(
        tween:
            Tween<Offset>(begin: Offset.zero, end: const Offset(-0.0625, 0.0)),
        weight: 1),
    TweenSequenceItem(
        tween:
            Tween<Offset>(begin: const Offset(-0.0625, 0.0), end: Offset.zero),
        weight: 1),
  ]).animate(CurvedAnimation(
    parent: passwordTextFieldShakeController,
    curve: Curves.linear,
  ));

  late final AnimationController usernameTextFieldShakeController =
      AnimationController(
    duration: const Duration(milliseconds: 150),
    vsync: this,
  );
  late final Animation<Offset> _usernameOffsetAnimation =
      TweenSequence<Offset>([
    TweenSequenceItem(
        tween: Tween<Offset>(begin: Offset.zero, end: const Offset(0.125, 0.0)),
        weight: 1),
    TweenSequenceItem(
        tween: Tween<Offset>(begin: const Offset(0.125, 0.0), end: Offset.zero),
        weight: 1),
    TweenSequenceItem(
        tween:
            Tween<Offset>(begin: Offset.zero, end: const Offset(-0.0625, 0.0)),
        weight: 1),
    TweenSequenceItem(
        tween:
            Tween<Offset>(begin: const Offset(-0.0625, 0.0), end: Offset.zero),
        weight: 1),
  ]).animate(CurvedAnimation(
    parent: usernameTextFieldShakeController,
    curve: Curves.linear,
  ));

  @override
  void dispose() {
    passwordController.dispose();
    usernameController.dispose();
    iconColorController.dispose();
    usernameTextFieldShakeController.dispose();
    passwordTextFieldShakeController.dispose();
    backgroundRotationController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    iconColorController = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    )..addListener(() {
        setState(() {});
      });
    animation = ColorTween(
      begin: const Color.fromRGBO(255, 255, 255, 0.7),
      end: const Color(0xFFF8D848),
    ).animate(iconColorController);
    super.initState();
  }

  LoginViewModel loginViewModel = LoginViewModel();
  GoogleLoginViewModel googleLoginViewModel = GoogleLoginViewModel();
  var authOrGoogleAuthResult;
  bool isLoaderVisible = false, statusTypeGoogle = false;
  ValueNotifier<bool> isPwdHidden = ValueNotifier(true);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
          backgroundColor: Colors.black,
          body: !isLoaderVisible
              ? SingleChildScrollView(
                  child: SizedBox(
                    height: 1.sh,
                    width: 1.sw,
                    child: Stack(
                      children: [
                        ImageFiltered(
                            imageFilter:
                                ImageFilter.blur(sigmaX: 30, sigmaY: 30),
                            child: RotationTransition(
                                turns: _rotationAnimation,
                                child: SvgPicture.asset(
                                  "assets/images/loginBackground.svg",
                                  height: 1.sh,
                                  width: 1.sw,
                                ))),
                        Positioned(
                          bottom: 39.h,
                          left: 0,
                          right: 0,
                          child: SizedBox(
                            width: double.infinity,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Made with 💛 by DVM",
                                  style: GoogleFonts.openSans(
                                      color: Colors.white, fontSize: 14.sp),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Center(
                          child: Column(
                            children: [
                              Padding(
                                padding: EdgeInsets.only(top: 151.h),
                                child: SvgPicture.asset(
                                  "assets/images/login_screen_logo.svg",
                                  height: 273.h,
                                  width: 175.w,
                                ),
                              ),
                              Form(
                                  child: Padding(
                                padding: EdgeInsets.only(top: 59.h),
                                child: SizedBox(
                                  width: 360.w,
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.only(bottom: 13.h),
                                        child: SlideTransition(
                                          position: _usernameOffsetAnimation,
                                          child: TextFormField(
                                            cursorColor: const Color.fromRGBO(
                                                255, 255, 255, 0.7),
                                            controller: usernameController,
                                            validator: (value) {
                                              return null;
                                            },
                                            style: GoogleFonts.openSans(
                                                fontSize: 16.sp,
                                                color: const Color.fromRGBO(
                                                    255, 255, 255, 0.7)),
                                            decoration: InputDecoration(
                                                contentPadding: EdgeInsets.only(
                                                    top: 19.h,
                                                    bottom: 19.h,
                                                    left: 24.w),
                                                focusedBorder: OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10.7936.r),
                                                    borderSide: const BorderSide(
                                                        color:
                                                            Color(0xFFF8D848))),
                                                filled: true,
                                                fillColor:
                                                    const Color(0xFF1A1C1C),
                                                border: OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10.7936.r)),
                                                hintText: "Enter your username",
                                                hintStyle: GoogleFonts.openSans(
                                                    fontSize: 16.sp,
                                                    color: const Color.fromRGBO(
                                                        255, 255, 255, 0.7))),
                                          ),
                                        ),
                                      ),
                                      SlideTransition(
                                        position: _passwordOffsetAnimation,
                                        child: TextFormField(
                                          cursorColor: const Color.fromRGBO(
                                              255, 255, 255, 0.7),
                                          controller: passwordController,
                                          obscureText: isHidden,
                                          style: GoogleFonts.openSans(
                                              fontSize: 16.sp,
                                              color: const Color.fromRGBO(
                                                  255, 255, 255, 0.7)),
                                          decoration: InputDecoration(
                                              contentPadding: EdgeInsets.only(
                                                  top: 19.h,
                                                  bottom: 19.h,
                                                  left: 24.w),
                                              suffixIcon: IconButton(
                                                  focusColor:
                                                      Colors.transparent,
                                                  highlightColor:
                                                      Colors.transparent,
                                                  splashColor:
                                                      Colors.transparent,
                                                  onPressed: () {
                                                    bool blockTap = true;
                                                    if (iconColorController
                                                                .value !=
                                                            1 ||
                                                        iconColorController
                                                                .value !=
                                                            0) {
                                                      blockTap = true;
                                                    }
                                                    if (iconColorController
                                                                .value ==
                                                            1 &&
                                                        blockTap) {
                                                      isHidden = !isHidden;
                                                      iconColorController
                                                          .reverse();
                                                    }
                                                    if (blockTap &&
                                                        iconColorController
                                                                .value ==
                                                            0) {
                                                      isHidden = !isHidden;
                                                      iconColorController
                                                          .forward();
                                                    }
                                                  },
                                                  icon: Icon(
                                                      Icons.visibility_outlined,
                                                      color: animation?.value ??
                                                          const Color.fromRGBO(
                                                              255, 255, 255, 0.7))),
                                              focusedBorder: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10.7936),
                                                  borderSide: const BorderSide(
                                                      color:
                                                          Color(0xFFF8D848))),
                                              filled: true,
                                              fillColor:
                                                  const Color(0xFF1A1C1C),
                                              border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(10.7936)),
                                              hintText: "Enter your password",
                                              hintStyle: GoogleFonts.openSans(fontSize: 16.sp, color: const Color.fromRGBO(255, 255, 255, 0.7))),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              )),
                              GestureDetector(
                                onTap: () {
                                  showDialog(
                                      barrierDismissible: true,
                                      context: context,
                                      builder: (context) {
                                        return Align(
                                          alignment: Alignment(0.5, 0.30),
                                          child: ForgotPasswordDialog(),
                                        );
                                      });
                                },
                                child: Padding(
                                  padding:
                                      EdgeInsets.only(left: 250.w, top: 5.h),
                                  child: Text('Forgot Password?',
                                      style: GoogleFonts.openSans(
                                          textStyle: TextStyle(
                                        color: Colors.white,
                                        fontSize: 10.sp,
                                        fontWeight: FontWeight.w600,
                                      ).copyWith(
                                              decoration:
                                                  TextDecoration.underline))),
                                ),
                              ),
                              Padding(
                                padding:
                                    EdgeInsets.only(top: 36.h, bottom: 22.h),
                                child: GestureDetector(
                                  onTap: () {
                                    bool tempBlock = true;
                                    if ((passwordController.text
                                                .trim()
                                                .isEmpty ||
                                            passwordController.text.trim() ==
                                                "") &&
                                        (usernameController.text
                                                .trim()
                                                .isEmpty ||
                                            usernameController.text.trim() ==
                                                "")) {
                                      passwordTextFieldShakeController.reset();
                                      usernameTextFieldShakeController.reset();
                                      passwordTextFieldShakeController
                                          .forward();
                                      usernameTextFieldShakeController
                                          .forward();
                                      tempBlock = false;
                                      ScaffoldMessenger.of(context).showSnackBar(
                                          CustomSnackBar().oasisSnackBar(
                                              'Enter the password and username'));
                                    } else if (tempBlock &&
                                        (passwordController.text
                                                .trim()
                                                .isEmpty ||
                                            passwordController.text.trim() ==
                                                "")) {
                                      if (passwordTextFieldShakeController
                                              .value ==
                                          1) {
                                        passwordTextFieldShakeController
                                            .reset();
                                      }
                                      passwordTextFieldShakeController
                                          .forward();
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(CustomSnackBar()
                                              .oasisSnackBar(
                                                  'Enter the password'));
                                    } else if (tempBlock &&
                                        (usernameController.text
                                                .trim()
                                                .isEmpty ||
                                            usernameController.text.trim() ==
                                                "")) {
                                      if (usernameTextFieldShakeController
                                              .value ==
                                          1) {
                                        usernameTextFieldShakeController
                                            .reset();
                                      }
                                      usernameTextFieldShakeController
                                          .forward();
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(SnackBar(
                                        duration:
                                            const Duration(milliseconds: 500),
                                        content: SizedBox(
                                            height: 25.h,
                                            child: const Center(
                                                child: Text(
                                                    "Enter the username"))),
                                      ));
                                    } else if (usernameController
                                            .text.isNotEmpty &&
                                        passwordController.text.isNotEmpty) {
                                      setState(() {
                                        isLoaderVisible = true;
                                        statusTypeGoogle = false;
                                      });
                                      authOrGoogleAuthResult =
                                          loginViewModel.authenticate(
                                              usernameController.text.trim(),
                                              passwordController.text.trim(),
                                              false);
                                      // usernameController.clear();
                                      // passwordController.clear();
                                    } else {
                                      showDialog(
                                          barrierDismissible: false,
                                          context: context,
                                          builder: (context) {
                                            return Align(
                                              alignment: Alignment.bottomCenter,
                                              child: ErrorDialog(
                                                  errorMessage: ErrorMessages
                                                      .emptyUsernamePassword),
                                            );
                                          });
                                    }
                                  },
                                  child: Container(
                                    height: 52.h,
                                    width: 287.w,
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                        gradient: OasisColors
                                            .oasisWebsiteGoldGradient,
                                        borderRadius:
                                            BorderRadius.circular(16)),
                                    child: Text(
                                      "Login",
                                      style: GoogleFonts.openSans(
                                          color: Colors.black,
                                          fontSize: 21.sp,
                                          fontWeight: FontWeight.w700),
                                    ),
                                  ),
                                ),
                              ),
                              GestureDetector(
                                onTap: () async {
                                  try {
                                    await _googleSignIn.signIn().then((result) {
                                      result?.authentication.then((googleKey) {
                                        setState(() {
                                          isLoaderVisible = true;
                                          statusTypeGoogle = true;
                                        });
                                        print(googleKey.idToken);
                                        authOrGoogleAuthResult =
                                            googleLoginViewModel.authenticate(
                                                googleKey.idToken, true);
                                      });
                                    });
                                  } catch (error) {
                                    Future.microtask(() => setState(() {
                                          isLoaderVisible = false;
                                        }));
                                    Future.microtask(() => showDialog(
                                        barrierDismissible: false,
                                        context: context,
                                        builder: (context) {
                                          return Align(
                                            alignment: Alignment.bottomCenter,
                                            child: ErrorDialog(
                                                errorMessage:
                                                    ErrorMessages.invalidLogin),
                                          );
                                        }));
                                  }
                                },
                                child: Container(
                                  height: 52.h,
                                  width: 287.w,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(16),
                                      border: const Border(
                                          top: BorderSide(color: Colors.white),
                                          left: BorderSide(color: Colors.white),
                                          right:
                                              BorderSide(color: Colors.white),
                                          bottom:
                                              BorderSide(color: Colors.white))),
                                  child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.only(right: 8.w),
                                          child: SvgPicture.asset(
                                              "assets/images/google_logo.svg"),
                                        ),
                                        Text(
                                          "Login with BITS Mail",
                                          style: GoogleFonts.openSans(
                                              fontSize: 16.sp,
                                              color: Colors.white),
                                        )
                                      ]),
                                ),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                )
              : statusTypeGoogle
                  ? FutureBuilder<GoogleAuthResult>(
                      future: authOrGoogleAuthResult,
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          if (snapshot.data?.error == null) {
                            Future.microtask(() {
                              RestartWidget.restartApp(context);
                              Navigator.of(context, rootNavigator: true)
                                  .pushNamedAndRemoveUntil(
                                      'home', (route) => true);
                            });
                          } else {
                            _googleSignIn.disconnect();
                            Future.microtask(() => setState(() {
                                  isLoaderVisible = false;
                                }));
                            Future.microtask(() => showDialog(
                                barrierDismissible: false,
                                context: context,
                                builder: (context) {
                                  return Align(
                                    alignment: Alignment.bottomCenter,
                                    child: ErrorDialog(
                                        errorMessage:
                                            ErrorMessages.invalidLogin),
                                  );
                                }));
                          }
                        } else {
                          return const Loader();
                        }
                        return Container();
                      },
                    )
                  : FutureBuilder<AuthResult>(
                      future: authOrGoogleAuthResult,
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          if (snapshot.data?.error == null) {
                            Future.microtask(() {
                              RestartWidget.restartApp(context);
                              if (UserDetailsViewModel.userDetails.userID ==
                                  "7644") {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                        const EventsScreen()));
                              } else {
                                Navigator.of(context, rootNavigator: true)
                                    .pushNamedAndRemoveUntil(
                                    'home', (route) => true);
                              }
                            });
                          } else {
                            Future.microtask(() => setState(() {
                                  isLoaderVisible = false;
                                }));
                            Future.microtask(() => showDialog(
                                barrierDismissible: false,
                                context: context,
                                builder: (context) {
                                  return Align(
                                    alignment: Alignment.bottomCenter,
                                    child: ErrorDialog(
                                        errorMessage:
                                            ErrorMessages.invalidLogin),
                                  );
                                }));
                          }
                        } else {
                          return const Loader();
                        }
                        return Container();
                      },
                    )),
    );
  }
}
