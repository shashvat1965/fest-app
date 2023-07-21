import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:oasis_2022/screens/wallet_screen/view/send_money_screens/send_money.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

import '/screens/wallet_screen/view_model/wallet_viewmodel.dart';
import '/utils/ui_utils.dart';

class ScanningView extends StatefulWidget {
  const ScanningView({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _ScanningViewState();
  }
}

class _ScanningViewState extends State<ScanningView> {
  String userId = '';
  double position = -UIUtills().getProportionalHeight(height: 87);
  QRViewController? controller;
  bool flashOn = false;
  var focusNode = FocusNode();
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  int? amountToSend;
  TextEditingController textEditingController = TextEditingController();

  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller!.pauseCamera();
    } else if (Platform.isIOS) {
      controller!.resumeCamera();
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    controller?.resumeCamera();
    return Scaffold(
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Stack(
          children: [
            qrCodeScanner(),
            Positioned(
                top: UIUtills().getProportionalHeight(height: 54),
                right: UIUtills().getProportionalWidth(width: 24),
                child: InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: SvgPicture.asset(
                    'assets/images/cross1.svg',
                    height: 32.h,
                    width: 32.w,
                  ),
                )),
            Positioned(
              bottom:
                  UIUtills().getProportionalHeight(height: position.toDouble()),
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: UIUtills().getProportionalHeight(height: 210),
                decoration: const BoxDecoration(
                    color: Color.fromRGBO(5, 5, 5, 1),
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(15),
                        topRight: Radius.circular(15))),
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                          bottom: UIUtills().getProportionalHeight(height: 27),
                          top: UIUtills().getProportionalHeight(height: 29)),
                      child: Container(
                        height: UIUtills().getProportionalHeight(height: 67),
                        width: UIUtills().getProportionalWidth(width: 388),
                        decoration: BoxDecoration(
                            boxShadow: const [
                              BoxShadow(
                                color: Color.fromRGBO(0, 0, 0, 0.2),
                                offset: Offset(0, 2),
                                blurRadius: 3,
                              )
                            ],
                            borderRadius: BorderRadius.circular(14),
                            color: Color.fromRGBO(26, 28, 28, 1)),
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: TextField(
                              onTap: () {
                                setState(() {
                                  position = 0;
                                });
                              },
                              controller: textEditingController,
                              keyboardType: TextInputType.number,
                              style: GoogleFonts.poppins(
                                  textStyle: TextStyle(
                                      color: Colors.white,
                                      fontSize: UIUtills()
                                          .getProportionalWidth(width: 20),
                                      fontWeight: FontWeight.w500)),
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: "Enter User Id",
                                  filled: true,
                                  fillColor: Color.fromRGBO(26, 28, 28, 1),
                                  hintStyle: GoogleFonts.poppins(
                                      textStyle: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w400,
                                  )),
                                  suffixIcon: IconButton(
                                      onPressed: () {
                                        textEditingController.clear();
                                      },
                                      icon: const Icon(Icons.close,
                                          color: Colors.grey, size: 15))),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          bottom: UIUtills().getProportionalHeight(height: 28)),
                      child: InkWell(
                        onTap: () {
                          userId = textEditingController.text;
                          controller?.stopCamera();
                          controller?.dispose();
                          Navigator.pop(context);
                          PersistentNavBarNavigator.pushNewScreen(context,
                              screen: SendMoneyScreen1(
                                userId: userId,
                              ),
                              withNavBar: false);
                        },
                        child: Container(
                          // alignment: Alignment.bottomCenter,
                          width: 356.w,
                          height:
                              UIUtills().getProportionalHeight(height: 47.00),
                          margin: EdgeInsets.symmetric(
                              horizontal: UIUtills()
                                  .getProportionalWidth(width: 20.00)),
                          decoration: BoxDecoration(
                            gradient: const LinearGradient(
                              colors: [
                                Color.fromRGBO(209, 154, 8, 1),
                                Color.fromRGBO(254, 212, 102, 1),
                                Color.fromRGBO(227, 186, 79, 1),
                                Color.fromRGBO(209, 154, 8, 1),
                                Color.fromRGBO(209, 154, 8, 1),
                              ],
                            ),
                            boxShadow: const [
                              BoxShadow(
                                color: Color.fromRGBO(0, 0, 0, 0.20),
                                blurRadius: 3.00,
                                offset: Offset(0, 2.00),
                              ),
                            ],
                            borderRadius: BorderRadius.circular(
                              15.r,
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    'Proceed',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w800,
                                      color: Colors.black,
                                      fontSize: UIUtills()
                                          .getProportionalWidth(width: 20.00),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                  top: UIUtills().getProportionalHeight(height: 500 * 0.725),
                  left:
                      UIUtills().getProportionalWidth(width: (50 - 40) * 0.5)),
              child: InkResponse(
                onTap: () async {
                  try {
                    await controller?.toggleFlash();
                    setState(() {
                      flashOn = !flashOn;
                    });
                  } catch (e) {
                    var snackBar = const SnackBar(
                      duration: Duration(seconds: 2),
                      content: SizedBox(
                          height: 25,
                          child: Center(child: Text("Flash not supported"))),
                    );
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  }
                },
                child: FutureBuilder(
                    future: controller?.getFlashStatus(),
                    builder: (context, snapshot) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SizedBox(
                          height: 20,
                          width: 20,
                          child: Icon(
                            flashOn ? Icons.flash_on : Icons.flash_off,
                            color: flashOn ? Colors.yellow : Colors.white,
                          ),
                        ),
                      );
                    }),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget qrCodeScanner() {
    return QRView(
      key: qrKey,
      onQRViewCreated: _onQRViewCreated,
      // onPermissionSet: (ctrl, p) => _onPermissionSet(context, ctrl, p),
      overlay: QrScannerOverlayShape(
        borderColor: Colors.amber,
        borderLength: 30,
        borderWidth: 5,
        cutOutSize: UIUtills().getProportionalHeight(height: 246),
      ),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    setState(() {
      this.controller = controller;
    });
    controller.scannedDataStream.listen((scanData) async {
      controller.pauseCamera();
      var qrCode = scanData.code!;
      userId = (await WalletViewModel().getId(qrCode)).toString();
      if (!mounted) {}
      Navigator.pop(context);
      PersistentNavBarNavigator.pushNewScreen(context,
          screen: SendMoneyScreen1(userId: userId));
    });
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  void _onPermissionSet(BuildContext context, QRViewController ctrl, bool p) {
    if (!p) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('No Permission')),
      );
    }
  }
}
