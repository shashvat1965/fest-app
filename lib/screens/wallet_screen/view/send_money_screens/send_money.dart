import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:oasis_2022/screens/wallet_screen/view/send_money_screens/updatedSendMoneyDialog.dart';
import 'package:oasis_2022/utils/colors.dart';
import 'package:oasis_2022/widgets/OasisSnackbar.dart';
import 'dart:ui';
import '../../../../resources/resources.dart';
import '../../view_model/wallet_viewmodel.dart';
import '../wallet_screen_controller.dart';
import '/provider/user_details_viewmodel.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:local_auth/local_auth.dart';

import '/../../../utils/ui_utils.dart';

class SendMoneyScreen1 extends StatefulWidget {
  SendMoneyScreen1({super.key, required this.userId});

  String userId;

  @override
  State<SendMoneyScreen1> createState() => _SendMoneyScreen1State();
}

class _SendMoneyScreen1State extends State<SendMoneyScreen1> {
  int amountToSend = 0;
  bool isLoading = false;
  late int balance = 0;
  final LocalAuthentication auth = LocalAuthentication();
  String _authorized = 'Not Authorized';
  bool _isAuthenticating = false;
  bool authenticated = true;
  String letter = '';
  TextEditingController textEditingController = TextEditingController();

  getFirstLetterOfName(String name) {
    name.trim();
    letter = name[0];
  }

  @override
  void initState() {
    WalletScreenController.returnToWalletScreen.addListener(() {
      Navigator.of(context).pop();
    });
    getFirstLetterOfName(UserDetailsViewModel.userDetails.username ?? "N/A");
    super.initState();
  }

  Future<void> _authenticate() async {
    authenticated = false;
    try {
      setState(() {
        _isAuthenticating = true;
        _authorized = 'Authenticating';
      });
      authenticated = await auth.authenticate(
        localizedReason: 'Please authenticate to view QR',
        options: const AuthenticationOptions(
          stickyAuth: true,
        ),
      );
      setState(() {
        _isAuthenticating = false;
      });
    } on PlatformException catch (e) {
      if (kDebugMode) {
        print(e);
      }
      setState(() {
        _isAuthenticating = false;
        _authorized = 'Error - ${e.message}';
      });
      return;
    }
    if (!mounted) {
      return;
    }

    setState(
        () => _authorized = authenticated ? 'Authorized' : 'Not Authorized');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SizedBox(
        width: 1.sw,
        height: 1.sh,
        child: Stack(children: [
          Positioned(
            bottom: 20,
            left: 20,
            child: isLoading
                ? SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: const Center(
                      child: LinearProgressIndicator(
                        color: Colors.black,
                        backgroundColor: Colors.transparent,
                      ),
                    ),
                  )
                : InkWell(
                    onTap: () async {
                      if (textEditingController.text == "") {
                        var snackBar =
                            CustomSnackBar().oasisSnackBar("Enter A Value");
                        if (!mounted) {}
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      }
                      if (int.parse(textEditingController.text) == 0 ||
                          int.parse(textEditingController.text) < 0) {
                        var snackBar = CustomSnackBar()
                            .oasisSnackBar("Enter A Non Zero Positive Value");
                        if (!mounted) {}
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      } else {
                        amountToSend = int.parse(textEditingController.text);
                        if (await auth.isDeviceSupported()) {
                          await _authenticate();
                        }
                        if (authenticated) {
                          bool isSuccess;
                          int id = int.parse(widget.userId);
                          try {
                            await WalletViewModel().sendMoney(id, amountToSend);
                            isSuccess = true;
                          } catch (e) {
                            isSuccess = false;
                          }
                          if (isSuccess) {
                            WalletScreenController.isSuccess.value = true;
                          }
                          if (!mounted) {}
                          showDialog(
                              barrierDismissible: false,
                              context: context,
                              builder: (context) {
                                return Align(
                                  alignment: Alignment.bottomCenter,
                                  child: UpdatedSendMoneyDialogBox(
                                    isSuccessful: isSuccess,
                                  ),
                                );
                              });
                        }
                      }
                    },
                    child: Container(
                      alignment: Alignment.center,
                      // alignment: Alignment.bottomCenter,
                      width: UIUtills().getProportionalWidth(width: 388),
                      height: UIUtills().getProportionalHeight(height: 72.00),
                      // margin: EdgeInsets.symmetric(
                      //     horizontal:
                      //     UIUtills().getProportionalWidth(width: 20.00)),
                      decoration: BoxDecoration(
                        gradient: OasisColors.oasisWebsiteGoldGradient,
                        borderRadius: BorderRadius.circular(
                          UIUtills().getProportionalWidth(width: 15.00),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Send Money',
                            style: GoogleFonts.openSans(
                              fontWeight: FontWeight.w700,
                              color: Colors.black,
                              fontSize:
                                  UIUtills().getProportionalWidth(width: 18.00),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
          ),
          Positioned(
              left: UIUtills().getProportionalWidth(width: 24),
              top: UIUtills().getProportionalHeight(height: 72),
              child: Text(
                'Send Money',
                style:
                    GoogleFonts.openSans(fontSize: 32.sp, color: Colors.white),
              )),
          Positioned(
              top: UIUtills().getProportionalHeight(height: 75),
              right: UIUtills().getProportionalWidth(width: 30),
              child: GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: SvgPicture.asset('assets/images/exit_button.svg'),
              )),
          Positioned(
            top: UIUtills().getProportionalHeight(height: 190),
            child: Padding(
              padding: const EdgeInsets.only(top: 18, left: 22, right: 32),
              child: Container(
                width: UIUtills().getProportionalWidth(width: 388.00),
                height: UIUtills().getProportionalHeight(height: 220.00),
                decoration: BoxDecoration(
                  image: const DecorationImage(
                      image: AssetImage(ImageAssets.sendMoneyBack),
                      fit: BoxFit.fill),
                  //color: const Color(0xFFFFFFFF),
                  boxShadow: const [
                    BoxShadow(
                      color: Color.fromRGBO(0, 0, 0, 0.15),
                      offset: Offset(0, 4),
                      blurRadius: 4,
                    )
                  ],
                  borderRadius: BorderRadius.circular(10),
                  // gradient: const LinearGradient(
                  //   colors: [
                  //     Color.fromRGBO(0, 0, 0, 1),
                  //     Color.fromRGBO(45, 45, 45, 1)
                  //   ],
                  // ),
                ),
                // margin: EdgeInsets.only(
                //     // left: UIUtills().getProportionalWidth(width: 32.00),
                //     // right: UIUtills().getProportionalWidth(width: 32.00),
                //     top: UIUtills().getProportionalHeight(height: 18.00)),

                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                        height:
                            UIUtills().getProportionalHeight(height: 21.00)),
                    SizedBox(
                        height:
                            UIUtills().getProportionalHeight(height: 14.00)),
                    SizedBox(
                        height:
                            UIUtills().getProportionalHeight(height: 12.00)),
                    Text(
                      '${UserDetailsViewModel.userDetails.username}',
                      style: GoogleFonts.openSans(
                          color: Colors.white,
                          fontSize:
                              UIUtills().getProportionalWidth(width: 16.00),
                          fontWeight: FontWeight.w600,
                          letterSpacing:
                              UIUtills().getProportionalWidth(width: -0.41)),
                    ),
                    SizedBox(
                        height:
                            UIUtills().getProportionalHeight(height: 32.00)),
                    Container(
                      alignment: Alignment.center,
                      width: UIUtills().getProportionalWidth(width: 82),
                      height: UIUtills().getProportionalHeight(height: 40.00),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            '₹ ',
                            style: GoogleFonts.openSans(
                                color: Colors.white,
                                fontSize: UIUtills()
                                    .getProportionalWidth(width: 24.00),
                                fontWeight: FontWeight.w700,
                                letterSpacing: UIUtills()
                                    .getProportionalWidth(width: -0.41)),
                          ),
                          Flexible(
                            child: TextField(
                              controller: textEditingController,
                              cursorColor: Colors.white,
                              textAlign: TextAlign.right,
                              inputFormatters: [
                                LengthLimitingTextInputFormatter(4)
                              ],
                              keyboardType:
                                  const TextInputType.numberWithOptions(
                                      decimal: false, signed: false),
                              style: GoogleFonts.openSans(
                                  color: Colors.white,
                                  fontSize: UIUtills()
                                      .getProportionalWidth(width: 24.00),
                                  fontWeight: FontWeight.w700,
                                  letterSpacing: UIUtills()
                                      .getProportionalWidth(width: -0.41)),
                              decoration: const InputDecoration(
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.black),
                                ),
                                enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white),
                                ),
                                errorBorder: InputBorder.none,
                                disabledBorder: InputBorder.none,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                        height:
                            UIUtills().getProportionalHeight(height: 30.00)),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            top: UIUtills().getProportionalHeight(height: 162),
            left: UIUtills().getProportionalWidth(width: 183),
            child: Stack(
              alignment: Alignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/images/circle.png',
                      // width:
                      //     UIUtills().getProportionalWidth(width: 71.00),
                      // height: UIUtills()
                      //     .getProportionalHeight(height: 71.00),
                    ),
                  ],
                ),
                Text(
                  letter,
                  style: GoogleFonts.openSans(
                      color: Colors.black,
                      fontSize: UIUtills().getProportionalWidth(width: 32.00),
                      fontWeight: FontWeight.w600,
                      letterSpacing:
                          UIUtills().getProportionalWidth(width: -0.41)),
                ),
              ],
            ),
          ),
        ]),
      ),
    );
  }
}
