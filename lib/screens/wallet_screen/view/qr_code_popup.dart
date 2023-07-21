import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:oasis_2022/utils/colors.dart';

import '../../../resources/resources.dart';
import '/utils/ui_utils.dart';
import '/widgets/loader.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:qr_flutter/qr_flutter.dart';

import '/../../provider/user_details_viewmodel.dart';
import '../view_model/wallet_viewmodel.dart';

class QRCodeDialogBox extends StatefulWidget {
  QRCodeDialogBox({super.key, required this.qrCode});

  String qrCode;

  @override
  State<QRCodeDialogBox> createState() => _QRCodeDialogBoxState();
}

class _QRCodeDialogBoxState extends State<QRCodeDialogBox> {
  String qrCode = '';
  late ValueNotifier<bool> isLoadingQrCode = ValueNotifier(false);

  @override
  void initState() {
    qrCode = widget.qrCode;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Container(
          decoration: BoxDecoration(
            image: const DecorationImage(
                image: AssetImage(ImageAssets.add_money_background),
                fit: BoxFit.fill),
            boxShadow: const [
              BoxShadow(
                color: Color.fromRGBO(0, 0, 0, 0.15),
                offset: Offset(0, 4),
                blurRadius: 4,
              )
            ],
            borderRadius: BorderRadius.circular(10),
          ),
          width: UIUtills().getProportionalWidth(width: 388.00),
          height: UIUtills().getProportionalHeight(height: 550.00),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: UIUtills().getProportionalHeight(height: 52.00)),
              ValueListenableBuilder(
                valueListenable: isLoadingQrCode,
                builder: (context, bool value, child) {
                  if (isLoadingQrCode.value) {
                    return Container(
                        color: Colors.transparent,
                        height: UIUtills().getProportionalWidth(width: 268),
                        width: UIUtills().getProportionalWidth(width: 268),
                        child: const SpinKitSpinningLines(
                          color: Colors.amber,
                        ));
                  } else {
                    return Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15)),
                      height: UIUtills().getProportionalHeight(height: 316),
                      width: UIUtills().getProportionalWidth(width: 316),
                      child: Center(
                        child: QrImage(
                            size: UIUtills().getProportionalWidth(width: 280),
                            foregroundColor: Colors.black,
                            data: qrCode),
                      ),
                    );
                  }
                },
              ),
              SizedBox(height: UIUtills().getProportionalHeight(height: 18.00)),
              SizedBox(
                width: UIUtills().getProportionalWidth(width: 322.00),
                child: Text(
                  'Scan this QR Code',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.openSans(
                      color: Colors.white,
                      fontSize: UIUtills().getProportionalWidth(width: 18.00),
                      fontWeight: FontWeight.w600,
                      letterSpacing:
                          UIUtills().getProportionalWidth(width: -0.41)),
                ),
              ),
              SizedBox(height: UIUtills().getProportionalHeight(height: 32.00)),
              GestureDetector(
                onTap: () async {
                  isLoadingQrCode.value = true;
                  String tempQrCode = await WalletViewModel().refreshQrCode(
                      int.parse(UserDetailsViewModel.userDetails.userID!));
                  setState(() {
                    qrCode = tempQrCode;
                    isLoadingQrCode.value = false;
                  });
                },
                child: Container(
                  width: UIUtills().getProportionalWidth(width: 171.00),
                  height: UIUtills().getProportionalHeight(height: 52.00),
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
                    borderRadius: BorderRadius.circular(10),
                    gradient: OasisColors.oasisWebsiteGoldGradient,
                  ),
                  child: Center(
                    child: Text(
                      'Refresh',
                      style: GoogleFonts.openSans(
                          color: Colors.black,
                          fontSize:
                              UIUtills().getProportionalWidth(width: 20.00),
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
