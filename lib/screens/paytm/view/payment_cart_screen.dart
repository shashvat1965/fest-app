import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:local_auth/local_auth.dart';
import 'package:oasis_2022/utils/colors.dart';
import 'package:oasis_2022/widgets/OasisSnackbar.dart';
import 'package:paytm_allinonesdk/paytm_allinonesdk.dart';

import '/provider/user_details_viewmodel.dart';
import '/utils/ui_utils.dart';
import '../../../../resources/resources.dart';
import '../repository/model/paytmResponse.dart';
import '../repository/model/paytmResult.dart';
import '../view_model/paytm_response_view_model.dart';
import '../view_model/paytm_view_model.dart';

class PaymentCartScreen extends StatefulWidget {
  const PaymentCartScreen({super.key});

  @override
  State<PaymentCartScreen> createState() => _PaymentCartScreenState();
}

class _PaymentCartScreenState extends State<PaymentCartScreen> {
  PaytmViewModel paytmViewModel = PaytmViewModel();
  var amountController = TextEditingController();
  late PaytmResponse paytmResponse;

  late PaytmResult _paytmApiResponse;
  late String mid, orderId, txnToken;
  late String amount;
  String result = "";
  bool isStaging = false;
  bool isApiCallInprogress = false;
  String callbackUrl =
      "https://securegw.paytm.in/theia/api/v1/initiateTransaction?mid={mid}&orderId={order-id}";
  bool restrictAppInvoke = false;
  bool enableAssist = true;
  final LocalAuthentication auth = LocalAuthentication();

  String _authorized = 'Not Authorized';
  bool _isAuthenticating = false;
  bool authenticated = true;
  int amountToAdd = 0;
  late int balance = 0;
  bool isLoading = false;
  String letter = '';

  getFirstLetterOfName(String name) {
    name.trim();
    letter = name[0];
  }

  @override
  void initState() {
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
        localizedReason: 'Please authenticate to add money',
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

  Future<void> _paytmInitialResponse() async {
    // paytmViewModel.getPaytmResponse(amountController.text);
    isApiCallInprogress = true;
    print('eakfjbewfkhbsdfkhbfs');
    print(amountController.text);
    _paytmApiResponse = await PaytmViewModel()
        .getPaytmResponse(amountController.text.toString());

    mid = _paytmApiResponse.mid;
    orderId = _paytmApiResponse.order_id;
    txnToken = _paytmApiResponse.txntoken;
    amount = amountController.text;
  }

  Future<void> _startTransaction() async {
    if (txnToken == "") {
      return;
    }
    var sendMap = <String, dynamic>{
      "mid": mid,
      "orderId": orderId,
      "amount": amount,
      "txnToken": txnToken,
      "callbackUrl": callbackUrl,
      "isStaging": isStaging,
      "restrictAppInvoke": restrictAppInvoke,
      "enableAssist": enableAssist
    };
    print(sendMap);
    try {
      // String callbackUrl = "https://test.bits-apogee.org/wallet/payment_response";
      var response = AllInOneSdk.startTransaction(
        mid,
        orderId,
        amount,
        txnToken,
        callbackUrl,
        isStaging,
        restrictAppInvoke,
        enableAssist,
      );
      response.then((value) {
        print(value);
        print("The process begin");
        setState(() async {
          PaytmResponse paytmResponse =
              PaytmResponse.fromJson(Map<String, dynamic>.from(value as Map));
          var response =
              await PaytmResponseViewModel().postPaytmResponse(paytmResponse);
          print(response);
          print(value.toString());
          print(value.toString());
          print(paytmResponse.CURRENCY);
          result = value.toString();
        });
      }).catchError((onError) {
        if (onError is PlatformException) {
          setState(() {
            result = onError.message.toString() +
                " \n  " +
                onError.details.toString();
          });
        } else {
          setState(() {
            result = onError.toString();
          });
        }
      });
    } catch (err) {
      result = err.toString();
    }
  }

  @override
  void dispose() {
    amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
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
                        if (amountController.text == "") {
                          var snackBar =
                              CustomSnackBar().oasisSnackBar("Enter a value");
                          if (!mounted) {}
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        }
                        if (int.parse(amountController.text) == 0 ||
                            int.parse(amountController.text) < 0) {
                          var snackBar = CustomSnackBar()
                              .oasisSnackBar("Enter A Non Zero Positive Value");
                          if (!mounted) {}
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        } else {
                          amountToAdd =
                              int.parse(amountController.text.toString());
                          if (await auth.isDeviceSupported()) {
                            await _authenticate();
                          }
                          if (authenticated) {
                            print('goes here 1');
                            print(isApiCallInprogress);
                            if (!isApiCallInprogress) {
                              print('goes here');
                              await _paytmInitialResponse();
                              await _startTransaction();
                              //TODO: how to check when a paytm transaction is complete
                              // if (result.isEmpty) {
                              //   RefreshWalletController.toRefresh.notifyListeners();
                              //   Navigator.of(context).pop();
                              // }
                            }

                            // bool isSuccess =
                            // await WalletViewModel().addMoney(amountToAdd);
                            // if (kDebugMode) {
                            //   print(isSuccess);
                            // }
                            // if (isSuccess) {
                            //   WalletScreenController.isSuccess.value = true;
                            //   await getBalance();
                            //   if (!mounted) {}
                            //   showDialog(
                            //       context: context,
                            //       builder: (context) {
                            //         return Align(
                            //           alignment: Alignment.bottomCenter,
                            //           child: AddMoneyDialogBox(
                            //             isSuccessful: isSuccess,
                            //             amount: amountToAdd,
                            //           ),
                            //         );
                            //       });
                            // }
                          }
                        }
                      },
                      child: Container(
                        alignment: Alignment.center,
                        // alignment: Alignment.bottomCenter,
                        width: UIUtills().getProportionalWidth(width: 388),
                        height: UIUtills().getProportionalHeight(height: 72.00),
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
                              'Add Money',
                              style: GoogleFonts.openSans(
                                fontWeight: FontWeight.w700,
                                color: Colors.black,
                                fontSize: UIUtills()
                                    .getProportionalWidth(width: 18.00),
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
                  'Add Money',
                  style:
                      GoogleFonts.openSans(fontSize: 32, color: Colors.white),
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
                  height: UIUtills().getProportionalHeight(height: 300.00),
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
                      Text(
                        'User : ${UserDetailsViewModel.userDetails.userID}',
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
                        width: UIUtills().getProportionalWidth(width: 90),
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
                                controller: amountController,
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
                                    borderSide: BorderSide(color: Colors.white),
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
                      Text('DISCLAIMER',
                          style: GoogleFonts.openSans(
                              color: Colors.white,
                              fontSize:
                                  UIUtills().getProportionalWidth(width: 12),
                              fontWeight: FontWeight.w600,
                              letterSpacing: UIUtills()
                                  .getProportionalWidth(width: -0.41))),
                      SizedBox(
                          height: UIUtills().getProportionalHeight(height: 10)),
                      Text('Money added via PayTM is non-refundable',
                          style: GoogleFonts.openSans(
                              color: Colors.white,
                              fontSize:
                                  UIUtills().getProportionalWidth(width: 12),
                              fontWeight: FontWeight.w600,
                              letterSpacing: UIUtills()
                                  .getProportionalWidth(width: -0.41))),
                    ],
                  ),
                ),
              ),
            ),
            Positioned(
              top: UIUtills().getProportionalHeight(height: 162),
              left: UIUtills().getProportionalWidth(width: 179),
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
      ),
    );
  }
}
