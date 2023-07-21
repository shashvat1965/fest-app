import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:local_auth/local_auth.dart';
import 'package:oasis_2022/screens/tickets/controller/store_controller.dart';

import '../../../widgets/OasisSnackbar.dart';
import '../repository/model/ticketPostBody.dart';
import '../view_model/tickets_post_view_model.dart';

class BuyMerch extends StatefulWidget {
  const BuyMerch(
      {Key? key,
      required this.id,
      required this.name,
      required this.price,
      required this.imageUrl,
      required this.amountPurchased,
      required this.available})
      : super(key: key);
  final int id;
  final String name;
  final int price;
  final String imageUrl;
  final int amountPurchased;
  final bool available;

  @override
  State<BuyMerch> createState() => _BuyMerchState();
}

enum _SupportState {
  unknown,
  supported,
  unsupported,
}

class _BuyMerchState extends State<BuyMerch> {
  int amount = 1;

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
        height: 545.h,
        width: 388.w,
        child: Stack(children: [
          Image.asset(
            "assets/images/buy_tickets_bg.png",
            height: 545.h,
            width: 388.w,
          ),
          Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: 27.h, left: 75.w),
                    child: Text(
                      "Buy ${widget.name}",
                      style: GoogleFonts.openSans(
                          fontSize: 24.sp, color: Colors.white),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 27.h, left: 35.w),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Icon(
                        Icons.close,
                        color: Colors.white,
                        size: 28.r,
                      ),
                    ),
                  )
                ],
              ),
              Padding(
                padding: EdgeInsets.only(top: 30.h),
                child: CachedNetworkImage(
                  imageUrl: widget.imageUrl,
                  height: 286.h,
                  width: 290.w,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 5.h, left: 50.w, right: 50.w),
                child: SizedBox(
                  height: 34.h,
                  child: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Amount",
                        style: GoogleFonts.openSans(
                            color: Colors.white, fontWeight: FontWeight.w700, fontSize: 16.sp),
                      ),
                    Container(
                      height: 34.h,
                      width: 100.w,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        gradient: const LinearGradient(colors: [
                          Color.fromRGBO(209, 154, 8, 1),
                          Color.fromRGBO(254, 212, 102, 1),
                          Color.fromRGBO(227, 186, 79, 1),
                          Color.fromRGBO(209, 154, 8, 1),
                          Color.fromRGBO(209, 154, 8, 1),
                        ]),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          GestureDetector(
                            child: Container(
                              width: 25.w,
                              height: 30.h,
                              color: Colors.transparent,
                              child: const Icon(
                                Icons.remove,
                                color: Colors.black,
                                size: 18,
                              ),
                            ),
                            onTap: () {
                              setState(() {
                                if(amount > 1){
                                  amount--;
                                }
                              });
                            },
                          ),
                          Container(
                            height: 32.h,
                            width: 38.w,
                            color: Colors.black,
                            child: Center(
                              child: ShaderMask(
                                blendMode: BlendMode.srcIn,
                                shaderCallback: (bounds) => const LinearGradient(colors: [
                                  Color.fromRGBO(209, 154, 8, 1),
                                  Color.fromRGBO(254, 212, 102, 1),
                                  Color.fromRGBO(227, 186, 79, 1),
                                  Color.fromRGBO(209, 154, 8, 1),
                                  Color.fromRGBO(209, 154, 8, 1),
                                ]).createShader(
                                    Rect.fromLTWH(0, 0, bounds.width, bounds.height)),
                                child: Text(
                                  "$amount",
                                  style:
                                  GoogleFonts.roboto(color: Colors.white, fontSize: 16.sp),
                                ),
                              ),
                            ),
                          ),
                          GestureDetector(
                            child: Container(
                              width: 25.w,
                              height: 30.h,
                              color: Colors.transparent,
                              child: const Icon(
                                Icons.add,
                                size: 16,
                                color: Colors.black,
                              ),
                            ),
                            onTap: () {
                              setState(() {
                                amount++;
                              });
                            },
                          ),
                        ],
                      ),
                    )
                    ],
                  )),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 32.h),
                child: GestureDetector(
                  onTap: () async {
                    if (widget.available) {
                      if (await auth.isDeviceSupported()) {
                        await _authenticate();
                      }
                      if (authenticated) {
                        TicketPostBody ticketPostBody =
                            TicketPostBody(individual: {}, combos: {});
                        ticketPostBody.individual![widget.id.toString()] =
                            amount;
                        try {
                          await TicketPostViewModel()
                              .postOrders(ticketPostBody);
                          await StoreController().initialCall();
                          StoreController.itemBoughtOrRefreshed.value =
                              !StoreController.itemBoughtOrRefreshed.value;
                          var snackbar =
                              CustomSnackBar().oasisSnackBar("Merch bought!");
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
                    } else {}
                  },
                  child: Container(
                    height: 52.h,
                    width: 171.w,
                    decoration: BoxDecoration(
                        gradient: widget.available
                            ? const LinearGradient(colors: [
                                Color.fromRGBO(209, 154, 8, 1),
                                Color.fromRGBO(254, 212, 102, 1),
                                Color.fromRGBO(227, 186, 79, 1),
                                Color.fromRGBO(209, 154, 8, 1),
                                Color.fromRGBO(209, 154, 8, 1),
                              ])
                            : const LinearGradient(colors: [
                                Color.fromRGBO(209, 154, 8, 0.5),
                                Color.fromRGBO(235, 187, 62, 0.5),
                                Color.fromRGBO(254, 212, 102, 0.5),
                                Color.fromRGBO(227, 186, 79, 0.5),
                                Color.fromRGBO(209, 154, 8, 0.5),
                                Color.fromRGBO(209, 154, 8, 0.5)
                              ]),
                        borderRadius: BorderRadius.circular(10.r)),
                    child: Center(
                      child: Text(
                        widget.available ? "Confirm" : "Sold Out",
                        style: GoogleFonts.openSans(
                            color: Colors.black,
                            fontSize: 20.sp,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 10.h),
                child: Text(
                  "Already Purchased - ${widget.amountPurchased}",
                  style: GoogleFonts.openSans(
                      color: const Color(0xFFACACAC), fontSize: 12.sp),
                ),
              )
            ],
          ),
        ]),
      ),
    );
  }
}
