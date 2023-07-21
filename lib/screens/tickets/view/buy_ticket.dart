import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:local_auth/local_auth.dart';
import 'package:oasis_2022/screens/tickets/controller/store_controller.dart';
import 'package:oasis_2022/screens/tickets/repository/model/showsData.dart';
import 'package:oasis_2022/screens/tickets/repository/model/ticketPostBody.dart';
import 'package:oasis_2022/screens/tickets/view_model/tickets_post_view_model.dart';
import 'package:oasis_2022/utils/colors.dart';

import '../../../widgets/OasisSnackbar.dart';

class BuyTicket extends StatefulWidget {
  const BuyTicket({Key? key}) : super(key: key);

  @override
  State<BuyTicket> createState() => _BuyTicketState();
}

enum _SupportState {
  unknown,
  supported,
  unsupported,
}

class _BuyTicketState extends State<BuyTicket> {
  int selectedIndex = 0;

  // ignore: non_constant_identifier_names
  final LocalAuthentication auth = LocalAuthentication();
  _SupportState _supportState = _SupportState.unknown;
  bool? _canCheckBiometrics;
  List<BiometricType>? _availableBiometrics;
  String _authorized = 'Not Authorized';
  bool _isAuthenticating = false;
  bool authenticated = true;

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
  void initState() {
    auth.isDeviceSupported().then(
          (bool isSupported) => setState(() => _supportState = isSupported
              ? _SupportState.supported
              : _SupportState.unsupported),
        );
    StoreController.itemNumber.addListener(() {
      if (!mounted) {}
      setState(() {});
    });
    StoreController.itemBoughtOrRefreshed.addListener(() {
      if (!mounted) {}
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(20.r)),
        height: 560.h,
        width: 388.w,
        child: Stack(children: [
          Image.asset(
            "assets/images/buy_tickets_bg.png",
            fit: BoxFit.fill,
            height: 560.h,
            width: 388.w,
          ),
          Column(
            children: [
              Padding(
                padding: EdgeInsets.only(top: 27.h,left: 135.w,right: 30.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Buy Tickets",
                      style: GoogleFonts.openSans(
                          fontSize: 20.sp, color: Colors.white,fontWeight: FontWeight.bold),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Icon(
                        Icons.close,
                        color: Colors.white,
                        size: 28.r,
                      ),
                    )

                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 87.h),
                child: SvgPicture.asset(
                  "assets/images/ticket.svg",
                  width: 245.w,
                  height: 149.h,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 51.74.h),
                child: SizedBox(
                  height: 28.h,
                  child: Center(
                    child: ListView.builder(
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            selectedIndex = index;
                            setState(() {});
                          },
                          child: Padding(
                            padding:
                                EdgeInsets.only(left: (index == 0) ? 0 : 8.w),
                            child: Container(
                              width: 28.h,
                              decoration: BoxDecoration(
                                  color: (selectedIndex == index)
                                      ? Colors.yellow
                                      : Colors.transparent,
                                  shape: BoxShape.circle),
                              child: Center(
                                child: ShaderMask(
                                  blendMode: BlendMode.srcIn,
                                  shaderCallback: (bounds) {
                                    return (selectedIndex == index)
                                        ? const LinearGradient(colors: [
                                            Colors.black,
                                            Colors.black
                                          ]).createShader(Rect.fromLTWH(
                                            0, 0, bounds.width, bounds.height))
                                        : const LinearGradient(colors: [
                                            Color.fromRGBO(209, 154, 8, 1),
                                            Color.fromRGBO(254, 212, 102, 1),
                                            Color.fromRGBO(227, 186, 79, 1),
                                            Color.fromRGBO(209, 154, 8, 1),
                                            Color.fromRGBO(209, 154, 8, 1),
                                          ]).createShader(Rect.fromLTWH(
                                            0, 0, bounds.width, bounds.height));
                                  },
                                  child: Text(
                                    "${index + 1}",
                                    style:
                                        GoogleFonts.openSans(fontSize: 20.sp),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                      scrollDirection: Axis.horizontal,
                      shrinkWrap: true,
                      itemCount: 10,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 33.2.h),
                child: Text(
                  "₹ ${(selectedIndex + 1) * (StoreController.carouselItems[StoreController.itemNumber.value] as StoreItemData).price!}",
                  style: GoogleFonts.openSans(
                      color: const Color(0xFFE6E6E6),
                      fontSize: 20.sp,
                      fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 30.h, bottom: 40.h),
                child: GestureDetector(
                  onTap: () async {
                    if (await auth.isDeviceSupported()) {
                      await _authenticate();
                    }
                    if (authenticated) {
                      TicketPostBody ticketPostBody =
                          TicketPostBody(individual: {}, combos: {});
                      ticketPostBody.individual![
                              "${(StoreController.carouselItems[StoreController.itemNumber.value] as StoreItemData).id}"] =
                          (selectedIndex + 1);
                      try {
                        await TicketPostViewModel().postOrders(ticketPostBody);
                        await StoreController().initialCall();
                        StoreController.itemBoughtOrRefreshed.value =
                            !StoreController.itemBoughtOrRefreshed.value;
                        var snackbar =
                            CustomSnackBar().oasisSnackBar("Ticket bought!");
                        if (!mounted) {}
                        ScaffoldMessenger.of(context).showSnackBar(snackbar);
                        if (!mounted) {}
                        Navigator.pop(context);
                      } catch (e) {
                        var snackbar =
                            CustomSnackBar().oasisSnackBar(e.toString());
                        if (!mounted) {}
                        ScaffoldMessenger.of(context).showSnackBar(snackbar);
                      }
                    }
                  },
                  child: Container(
                    height: 52.h,
                    width: 171.w,
                    decoration: BoxDecoration(
                        gradient: OasisColors.oasisWebsiteGoldGradient,
                        borderRadius: BorderRadius.circular(10.r)),
                    child: Center(
                      child: Text(
                        "Confirm",
                        style: GoogleFonts.openSans(
                            color: Colors.black,
                            fontSize: 20.sp,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ]),
      ),
    );
  }
}
