import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:local_auth/local_auth.dart';
import 'package:oasis_2022/resources/resources.dart';
import 'package:oasis_2022/screens/kindstore/view/kind_store_view.dart';
import 'package:oasis_2022/screens/paytm/view/payment_cart_screen.dart';
import 'package:oasis_2022/screens/wallet_screen/Repo/model/Transactions_model.dart';
import 'package:oasis_2022/utils/colors.dart';
import 'package:oasis_2022/widgets/loader.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

import '../../morescreen/screens/more_info.dart';
import '/provider/user_details_viewmodel.dart';
import '/screens/paytm/view/refresh_wallet_controller.dart';
import '/screens/wallet_screen/view/qr_code_popup.dart';
import '/screens/wallet_screen/view/scan_screen.dart';
import '/screens/wallet_screen/view/wallet_screen_controller.dart';
import '/screens/wallet_screen/view_model/wallet_viewmodel.dart';
import '/utils/scroll_remover.dart';
import '/utils/ui_utils.dart';
import '/widgets/error_dialogue.dart';
import 'add_money_screens/addMoney.dart';

enum _SupportState {
  unknown,
  supported,
  unsupported,
}

class WalletScreen extends StatefulWidget {
  const WalletScreen({Key? key}) : super(key: key);

  @override
  State<WalletScreen> createState() => _WalletScreenState();
}

class _WalletScreenState extends State<WalletScreen> {
  int? amountToAdd;
  int? userid;
  int? amountToSend;
  late ValueNotifier<bool> isLoading = ValueNotifier(true);
  late ValueNotifier<bool> isLoadingQrCode = ValueNotifier(true);
  List<TransactionsData> groupedTransactions = [];
  // ignore: non_constant_identifier_names
  String QRcode = '';
  final LocalAuthentication auth = LocalAuthentication();
  _SupportState _supportState = _SupportState.unknown;
  bool? _canCheckBiometrics;
  List<BiometricType>? _availableBiometrics;
  String _authorized = 'Not Authorized';
  bool _isAuthenticating = false;
  bool authenticated = true;

  String capitalizeAllWord(String value) {
    var result = value[0].toUpperCase();
    for (int i = 1; i < value.length; i++) {
      if (value[i - 1] == " ") {
        result = result + value[i].toUpperCase();
      } else {
        result = result + value[i];
      }
    }
    return result;
  }

  @override
  void initState() {
    RefreshWalletController.toRefresh.addListener(() {
      getBalance();
    });
    getBalance();
    super.initState();
    auth.isDeviceSupported().then(
          (bool isSupported) => setState(() => _supportState = isSupported
              ? _SupportState.supported
              : _SupportState.unsupported),
        );
    WalletScreenController.isSuccess.addListener(() async {
      await getBalance();
      WalletScreenController.isSuccess.value = false;
    });
  }

  Future<void> getBalance() async {
    await WalletViewModel().getBalance();
    TransactionsModel transactions = await WalletViewModel().getTransactions();
    groupedTransactions = WalletViewModel().getGroupTransactions(transactions);

    setState(() {
      isLoading.value = false;
    });
    if (WalletViewModel.error != null) {
      print('goes here');
      setState(() {
        isLoading.value = false;
      });
      showDialog(
          barrierDismissible: false,
          context: context,
          builder: (context) {
            return Align(
              alignment: Alignment.bottomCenter,
              child: ErrorDialog(errorMessage: WalletViewModel.error!),
            );
          });
    } else {
      setState(() {
        isLoading.value = false;
      });
    }
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
    return ValueListenableBuilder(
        valueListenable: isLoading,
        builder: (context, bool value, child) {
          if (isLoading.value) {
            return const Loader();
          } else {
            return Scaffold(
              body: RefreshIndicator(
                backgroundColor: Colors.black,
                color: Colors.amber,
                onRefresh: getBalance,
                child: ScrollConfiguration(
                  behavior: CustomScrollBehavior(),
                  child: ListView(
                    children: [
                      Container(
                        height: MediaQuery.of(context).size.height,
                        color: Colors.black,
                        child: Padding(
                          padding: EdgeInsets.fromLTRB(20.w, 34.h, 20.w, 0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,

                                children: [
                                  Text(
                                    'Wallet',
                                    style: GoogleFonts.openSans(
                                        color: const Color(0xFFFFFFFF),
                                        fontSize: UIUtills()
                                            .getProportionalHeight(height: 28),
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                              Padding(
                                padding: EdgeInsets.only(top: 28.h),
                                child: Container(
                                  decoration: const BoxDecoration(
                                      image: DecorationImage(
                                          image: AssetImage(ImageAssets.wallet),
                                          fit: BoxFit.fill)),
                                  width: 388.w,
                                  height: 238.h,
                                  child: Padding(
                                    padding: EdgeInsets.fromLTRB(
                                        20.w, 23.h, 20.w, 15.h),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        // SizedBox(height: 10 ,width: MediaQuery.of(context).size.width,),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  capitalizeAllWord(
                                                      UserDetailsViewModel
                                                              .userDetails
                                                              .username
                                                              ?.toLowerCase() ??
                                                          'NA'),
                                                  style: GoogleFonts.openSans(
                                                      color: Colors.white,
                                                      fontSize: 20.sp,
                                                      fontWeight:
                                                          FontWeight.w700),
                                                ),
                                                SizedBox(
                                                  width: 250.w,
                                                  child: Text(
                                                    '${IsBitsian(UserDetailsViewModel.userDetails.isBitsian)}',
                                                    style: GoogleFonts.openSans(
                                                        color: Color.fromRGBO(
                                                            250, 250, 250, 0.6),
                                                        fontSize: 12.sp,
                                                        fontWeight:
                                                            FontWeight.w600),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            InkWell(
                                              onTap: () async {
                                                if (await auth
                                                    .isDeviceSupported()) {
                                                  await _authenticate();
                                                }
                                                if (authenticated) {
                                                  if (UserDetailsViewModel
                                                              .userDetails
                                                              .userID ==
                                                          null ||
                                                      UserDetailsViewModel
                                                              .userDetails
                                                              .userID ==
                                                          '') {
                                                    showDialog(
                                                        barrierDismissible:
                                                            false,
                                                        context: context,
                                                        builder: (context) {
                                                          return Align(
                                                            alignment: Alignment
                                                                .bottomCenter,
                                                            child: ErrorDialog(
                                                                errorMessage:
                                                                    'User id not found'),
                                                          );
                                                        });
                                                  } else {
                                                    QRcode = await WalletViewModel()
                                                        .refreshQrCode(int.parse(
                                                            UserDetailsViewModel
                                                                .userDetails
                                                                .userID!));
                                                    showDialog(
                                                        context: context,
                                                        builder: (context) {
                                                          return Align(
                                                              alignment: Alignment
                                                                  .bottomCenter,
                                                              child: QRCodeDialogBox(
                                                                  qrCode:
                                                                      QRcode));
                                                        });
                                                  }
                                                }
                                              },
                                              child: Column(
                                                children: [
                                                  SvgPicture.asset(
                                                    'assets/images/qr.svg',
                                                    height: 43.h,
                                                    width: 43.w,
                                                  ),
                                                  Padding(
                                                    padding: EdgeInsets.only(
                                                        top: 6.h),
                                                    child: Text(
                                                      'ID: ${UserDetailsViewModel.userDetails.userID}',
                                                      style:
                                                          GoogleFonts.openSans(
                                                              color: Color
                                                                  .fromRGBO(
                                                                      250,
                                                                      250,
                                                                      250,
                                                                      0.6),
                                                          fontSize: 12.sp,
                                                          fontWeight: FontWeight.w600),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            )
                                          ],
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.end,
                                          children: [
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [ValueListenableBuilder(
                                                valueListenable: isLoading,
                                                builder: (context,
                                                    bool value, child) {
                                                  if (isLoading.value) {
                                                    return SizedBox(
                                                        width: 20.w,
                                                        height: 20.h,
                                                        child: Center(
                                                            child:
                                                            SpinKitWave(
                                                              color: Colors
                                                                  .white
                                                                  .withOpacity(
                                                                  0.5),
                                                              size: 15.r,
                                                            )));
                                                  } else {
                                                    return Text(
                                                      '₹ ${WalletViewModel.balance}',
                                                      style: GoogleFonts.openSans(
                                                          color: const Color(
                                                              0xFFFFFFFF),
                                                          fontSize: UIUtills()
                                                              .getProportionalHeight(
                                                              height:
                                                              24),
                                                          fontWeight:
                                                          FontWeight
                                                              .w700),
                                                    );
                                                  }
                                                },
                                              ),
                                                Text(
                                                  'Wallet Balance',
                                                  style: GoogleFonts.openSans(
                                                      color: Color.fromRGBO(250, 250, 250, 0.6),
                                                      fontSize: 12.sp,
                                                      fontWeight:
                                                          FontWeight.w600),
                                                ),
                                                Padding(
                                                  padding: EdgeInsets.only(
                                                      bottom: 20.h),

                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: 13.w, top: 20.h),
                                child: Row(
                                  children: [
                                    Container(
                                      width: 171.w,
                                      height: 52.h,
                                      padding:
                                          EdgeInsets.fromLTRB(0, 12.h, 0, 12.h),
                                      decoration: BoxDecoration(
                                        gradient: OasisColors
                                            .oasisWebsiteGoldGradient,
                                        borderRadius:
                                            BorderRadius.circular(10.r),
                                      ),
                                      child: Column(
                                        children: [
                                          InkWell(
                                            onTap: () async {
                                              if (!mounted) {}
                                              PersistentNavBarNavigator
                                                  .pushNewScreen(context,
                                                      screen:
                                                          const ScanningView(),
                                                      withNavBar: false);
                                            },
                                            child: Row(children: [
                                              Padding(
                                                padding: EdgeInsets.only(
                                                    left: UIUtills()
                                                        .getProportionalWidth(
                                                            width: 22)),
                                                child: SvgPicture.asset(
                                                  'assets/images/send_money.svg',
                                                  width: UIUtills()
                                                      .getProportionalWidth(
                                                          width: 22),
                                                  height: UIUtills()
                                                      .getProportionalHeight(
                                                          height: 24),
                                                ),
                                              ),
                                              SizedBox(
                                                width: UIUtills()
                                                    .getProportionalHeight(
                                                        height: 13),
                                              ),
                                              Text(
                                                'Send Money',
                                                style: GoogleFonts.openSans(
                                                    color:
                                                        const Color(0xFF1A1A1A),
                                                    fontSize: 16.sp,
                                                    fontWeight:
                                                        FontWeight.w600),
                                              ),
                                            ]),
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      width: UIUtills()
                                          .getProportionalWidth(width: 20),
                                    ),
                                    Container(
                                      width: 171.w,
                                      padding:
                                          EdgeInsets.fromLTRB(0, 12.h, 0, 12.h),
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
                                        borderRadius:
                                            BorderRadius.circular(10.r),
                                      ),
                                      child: InkWell(
                                        onTap: () {
                                          if (UserDetailsViewModel
                                              .userDetails.isBitsian!) {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        const AddMoneyScreen()));
                                          } else {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (builder) =>
                                                        const PaymentCartScreen()));
                                          }
                                        },
                                        child: Row(children: [
                                          Padding(
                                              padding: EdgeInsets.only(
                                                  left: UIUtills()
                                                      .getProportionalWidth(
                                                          width: 20)),
                                              child: SvgPicture.asset(
                                                'assets/images/addMoney.svg',
                                                height: 22.h,
                                                width: 25.w,
                                              )),
                                          SizedBox(
                                            width: UIUtills()
                                                .getProportionalWidth(
                                                    width: 14.00),
                                          ),
                                          Text(
                                            'Add Money',
                                            style: GoogleFonts.openSans(
                                                color: Colors.black,
                                                fontSize: 16.sp,
                                                fontWeight: FontWeight.w600),
                                          ),
                                        ]),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              WalletViewModel.isKindActive
                                  ? Padding(
                                      padding: EdgeInsets.only(top: 20.h),
                                      child: Container(
                                        width: UIUtills()
                                            .getProportionalWidth(width: 388),
                                        decoration: BoxDecoration(
                                            color: const Color.fromRGBO(
                                                26, 28, 28, 1),
                                            borderRadius:
                                                BorderRadius.circular(10.79.r)),
                                        child: Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              16, 14, 16, 14),
                                          child: Row(
                                            children: [
                                              Container(
                                                  height: UIUtills()
                                                      .getProportionalHeight(
                                                          height: 46),
                                                  width: UIUtills()
                                                      .getProportionalWidth(
                                                          width: 46),
                                                  decoration: BoxDecoration(
                                                      color: Colors.white,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10)),
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            top: 3),
                                                    child: Center(
                                                        child: SvgPicture.asset(
                                                      'assets/images/Kind_points.svg',
                                                      height: UIUtills()
                                                          .getProportionalHeight(
                                                              height: 23),
                                                      width: UIUtills()
                                                          .getProportionalWidth(
                                                              width: 26),
                                                      color: Colors.black,
                                                    )),
                                                  )),
                                              SizedBox(
                                                width: UIUtills()
                                                    .getProportionalWidth(
                                                        width: 12),
                                              ),
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    'Kind Points',
                                                    style: GoogleFonts.openSans(
                                                        color: Colors.white,
                                                        fontSize: UIUtills()
                                                            .getProportionalHeight(
                                                                height: 16),
                                                        fontWeight:
                                                            FontWeight.w600),
                                                  ),
                                                  ValueListenableBuilder(
                                                      valueListenable:
                                                          isLoading,
                                                      builder: (context,
                                                          bool value, child) {
                                                        if (isLoading.value) {
                                                          return SizedBox(
                                                              width: 20.w,
                                                              height: 20.h,
                                                              child: Center(
                                                                  child:
                                                                      SpinKitWave(
                                                                color: Colors
                                                                    .white
                                                                    .withOpacity(
                                                                        0.5),
                                                                size: 15.r,
                                                              )));
                                                        } else {
                                                          return Text(
                                                            '${WalletViewModel.kindpoints}',
                                                            style: GoogleFonts
                                                                .openSans(
                                                                    color: Colors
                                                                        .white,
                                                                    fontSize:
                                                                        20.sp,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w700),
                                                          );
                                                        }
                                                      }),
                                                ],
                                              ),
                                              Padding(
                                                padding: EdgeInsets.only(
                                                    left: UIUtills()
                                                        .getProportionalWidth(
                                                            width: 80)),
                                                child: Container(
                                                  padding: EdgeInsets.fromLTRB(
                                                      0, 8.h, 0, 8.h),
                                                  decoration: BoxDecoration(
                                                    gradient: OasisColors
                                                        .oasisWebsiteGoldGradient,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10.r),
                                                  ),
                                                  child: Row(children: [
                                                    Padding(
                                                      padding: EdgeInsets.fromLTRB(
                                                          UIUtills()
                                                              .getProportionalWidth(
                                                                  width: 24),
                                                          0,
                                                          0,
                                                          0),
                                                    ),
                                                    GestureDetector(
                                                      onTap: () {
                                                        Navigator.of(context)
                                                            .push(
                                                          MaterialPageRoute(
                                                              builder: (builder) =>
                                                                  KindStoreCatalog()),
                                                        );
                                                      },
                                                      child: Text(
                                                        'Claim now',
                                                        style: GoogleFonts
                                                            .openSans(
                                                                color: Colors
                                                                    .black,
                                                                fontSize: 14.sp,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600),
                                                      ),
                                                    ),
                                                    SizedBox(width: 24.w)
                                                  ]),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    )
                                  : Container(),
                              Padding(
                                padding:
                                    EdgeInsets.only(top: 35.h, bottom: 22.h),
                                child: Text(
                                  'Transactions',
                                  style: GoogleFonts.openSans(
                                      color: Colors.white,
                                      fontSize: 24.sp,
                                      fontWeight: FontWeight.w600),
                                ),
                              ),
                              Container(
                                height: 240.h,
                                child: ListView.builder(
                                    padding: EdgeInsets.zero,
                                    scrollDirection: Axis.vertical,
                                    shrinkWrap: true,
                                    itemCount: groupedTransactions.length,
                                    itemBuilder: (context, index) {
                                      return Padding(
                                        padding: EdgeInsets.only(bottom: 15.h),
                                        child: Container(
                                          child: Padding(
                                            padding: EdgeInsets.only(
                                                left: 10.w, right: 10.w),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                if (groupedTransactions[index]
                                                        .txn_type ==
                                                    'prof_show')
                                                  SizedBox(
                                                      height: 73.h,
                                                      width: 73.w,
                                                      child: SvgPicture.asset(
                                                        'assets/images/ticket_image.svg',
                                                        height: 30.h,
                                                        width: 50.w,
                                                      ))
                                                else if (groupedTransactions[
                                                            index]
                                                        .txn_type ==
                                                    'merch')
                                                  SizedBox(
                                                      height: 73.h,
                                                      width: 73.w,
                                                      child: SvgPicture.asset(
                                                        'assets/images/hangar.svg',
                                                        height: 30.h,
                                                        width: 50.w,
                                                      ))
                                                else
                                                  SizedBox(
                                                      height: 73.h,
                                                      width: 73.w,
                                                      child: SvgPicture.asset(
                                                        'assets/images/money_transfer.svg',
                                                        height: 30.h,
                                                        width: 50.w,
                                                      )),
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Padding(
                                                      padding: EdgeInsets.only(
                                                          bottom: 9.h),
                                                      child: Container(
                                                        width: 171.w,
                                                        child: Text(
                                                          groupedTransactions[
                                                                      index]
                                                                  .name ??
                                                              'lol',
                                                          style: GoogleFonts
                                                              .openSans(
                                                                  color: Colors
                                                                      .white,
                                                                  fontSize:
                                                                      14.sp,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w700),
                                                        ),
                                                      ),
                                                    ),
                                                    Text(
                                                      DateFormat.MMMd()
                                                              .add_jm()
                                                              .format(DateTime.parse(
                                                                  dateAndTime(
                                                                      groupedTransactions[index]
                                                                              .time ??
                                                                          '')))
                                                              .toString() ??
                                                          'lol',
                                                      style:
                                                          GoogleFonts.openSans(
                                                              color: Color
                                                                  .fromRGBO(
                                                                      255,
                                                                      255,
                                                                      255,
                                                                      1),
                                                              fontSize: 12.sp,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400),
                                                    ),
                                                  ],
                                                ),
                                                if (groupedTransactions[index]
                                                        .txn_type ==
                                                    'Transfer')
                                                  Text(
                                                    '₹${groupedTransactions[index].price!.toString()}',
                                                    style: GoogleFonts.openSans(
                                                        color: Colors.white,
                                                        fontSize: 18.sp,
                                                        fontWeight:
                                                            FontWeight.w700),
                                                  )
                                                else if (groupedTransactions[
                                                            index]
                                                        .txn_type ==
                                                    'Add from SWD')
                                                  Text(
                                                    '+ ₹${groupedTransactions[index].price!.toString()}',
                                                    style: GoogleFonts.openSans(
                                                        color: Colors.green,
                                                        fontSize: 18.sp,
                                                        fontWeight:
                                                            FontWeight.w700),
                                                  )
                                                else if (groupedTransactions[
                                                  index]
                                                      .txn_type ==
                                                      'Add from payment gateway')
                                                    Text(
                                                      '+ ₹${groupedTransactions[index].price!.toString()}',
                                                      style: GoogleFonts.openSans(
                                                          color: Colors.green,
                                                          fontSize: 18.sp,
                                                          fontWeight:
                                                          FontWeight.w700),
                                                    )

                                                else
                                                  Text(
                                                    '- ₹${groupedTransactions[index].price!.toString()}',
                                                    style: GoogleFonts.openSans(
                                                        color: Colors.red,
                                                        fontSize: 18.sp,
                                                        fontWeight:
                                                            FontWeight.w700),
                                                  ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      );
                                    }),
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }
        });
  }

  String dateAndTime(String timestamp) {
    String date = timestamp.split("T")[0];
    String time = timestamp.split("T")[1];
    String formattedString = "$date $time";
    DateTime indianCorrectTime = DateTime.parse(formattedString).toLocal();
    return indianCorrectTime.toString().split(".")[0];
  }

  String IsBitsian(bool? bits) {
    if (bits ?? true)
      return 'BITSian';
    else
      return 'Outstation Participant';
  }
}
