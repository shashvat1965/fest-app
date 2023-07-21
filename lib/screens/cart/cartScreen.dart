import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:local_auth/local_auth.dart';
import 'package:oasis_2022/screens/paytm/view/refresh_wallet_controller.dart';
import 'package:oasis_2022/widgets/OasisSnackbar.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

import '/order/controller/cart_and_order_controller.dart';
import '/screens/cart/repo/model/cart_screen_model.dart';
import '/screens/cart/repo/model/post_order_response_model.dart';
import '/screens/cart/viewmodel/cart_viewmodel.dart';
import '/screens/cart/widgets/cartWidget.dart';
import '/screens/wallet_screen/view_model/wallet_viewmodel.dart';
import '/utils/error_messages.dart';
import '/utils/ui_utils.dart';
import '/widgets/error_dialogue.dart';
import '../food_stalls/view/food_stall_screen.dart';

class CartScreen extends StatefulWidget {
  CartScreen({super.key});

  @override
  State<CartScreen> createState() => CartScreenState();
}

enum _SupportState {
  unknown,
  supported,
  unsupported,
}

class CartScreenState extends State<CartScreen> {
  List<FoodStallInCartScreen> foodStallist = [];
  Map<int, FoodStallInCartScreen> foodStallWithDetailsMap = {};
  List<int> foodStallIdList = [];
  int total = 0;
  List<int> subTotallist = [];
  bool isPostingOrder = false;

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
    foodStallWithDetailsMap = CartScreenViewModel().getValuesForScreen();
    foodStallIdList = CartScreenViewModel().getIdList(foodStallWithDetailsMap);
    total = CartScreenViewModel().getTotalValue(foodStallWithDetailsMap);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(children: [
        Padding(
          padding: EdgeInsets.only(top: 60.h, left: 23.w, right: 30.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Cart",
                style: GoogleFonts.openSans(
                    fontSize: 28.sp,
                    color: Colors.white,
                    fontWeight: FontWeight.w600),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Container(
                  height: 32.h,
                  width: 32.w,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6.r),
                      color: const Color.fromRGBO(22, 25, 31, 1)),
                  child: Icon(
                    Icons.close,
                    size: 20.r,
                    color: const Color.fromRGBO(244, 244, 244, 1),
                  ),
                ),
              )
            ],
          ),
        ),
        ValueListenableBuilder(
          valueListenable: Hive.box('cartBox').listenable(),
          builder: (context, Box box, child) {
            foodStallWithDetailsMap =
                CartScreenViewModel().getValuesForScreen();
            foodStallIdList =
                CartScreenViewModel().getIdList(foodStallWithDetailsMap);
            total =
                CartScreenViewModel().getTotalValue(foodStallWithDetailsMap);
            if (foodStallWithDetailsMap.isEmpty ||
                box.values.isEmpty ||
                box.keys.isEmpty ||
                box.isEmpty) {
              return Center(
                child: Padding(
                  padding: EdgeInsets.only(top: 150.h),
                  child: SvgPicture.asset(
                    'assets/images/empty_cart.svg',
                    height: UIUtills().getProportionalHeight(height: 321),
                    width: UIUtills().getProportionalWidth(width: 325),
                  ),
                ),
              );
            } else {
              return SizedBox(
                height: 1.sh - 170.h,
                child: Stack(
                  children: [
                    CustomScrollView(
                      shrinkWrap: true,
                      slivers: <Widget>[
                        SliverPadding(
                          padding: const EdgeInsets.all(20.0),
                          sliver: SliverList(
                            delegate: SliverChildBuilderDelegate(
                                (BuildContext context, int index) {
                              return cartWidget(
                                foodStallId: foodStallIdList[index],
                                menuList: foodStallWithDetailsMap[
                                        foodStallIdList[index]]!
                                    .menuList,
                                foodStallName: foodStallWithDetailsMap[
                                        foodStallIdList[index]]!
                                    .foodStall,
                              );
                            }, childCount: foodStallWithDetailsMap.length),
                          ),
                        ),
                      ],
                    ),
                    Positioned(
                      bottom: 40.h,
                      left: 0,
                      right: 0,
                      child: isPostingOrder
                          ? const Center(
                              child: LinearProgressIndicator(
                                color: Colors.yellow,
                                backgroundColor: Colors.transparent,
                              ),
                            )
                          : InkWell(
                              onTap: () async {
                                if (await auth.isDeviceSupported()) {
                                  await _authenticate();
                                }
                                if (authenticated) {
                                  if (!isPostingOrder) {
                                    setState(() {
                                      isPostingOrder = true;
                                    });
                                    if (box.isNotEmpty) {
                                      var orderdict = CartScreenViewModel()
                                          .getPostRequestBody();
                                      try {
                                        await WalletViewModel().getBalance();
                                        if (WalletViewModel.error != null) {
                                          showDialog(
                                              barrierDismissible: false,
                                              context: context,
                                              builder: (context) {
                                                return Align(
                                                  alignment:
                                                      Alignment.bottomCenter,
                                                  child: ErrorDialog(
                                                      errorMessage:
                                                          WalletViewModel
                                                              .error!),
                                                );
                                              });
                                        } else {
                                          if (WalletViewModel.balance >=
                                              total) {
                                            OrderResult orderResult =
                                                await CartScreenViewModel()
                                                    .postOrder(orderdict);
                                            if (CartScreenViewModel.error ==
                                                null) {
                                              if (orderResult.id != null) {
                                                CartAndOrderController
                                                    .newOrder.value = false;
                                                CartAndOrderController.newOrder
                                                    .notifyListeners();
                                                var snackBar = CustomSnackBar()
                                                    .oasisSnackBar(
                                                        'Order placed successfully');
                                                if (!mounted) {}
                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(snackBar);
                                                PersistentNavBarNavigator
                                                    .pushNewScreenWithRouteSettings(
                                                  context,
                                                  settings: const RouteSettings(
                                                      name: 'order'),
                                                  screen:
                                                      const FoodStallScreen(),
                                                  withNavBar: true,
                                                );
                                                RefreshWalletController
                                                    .toRefresh
                                                    .notifyListeners();
                                                box.clear();
                                              } else {
                                                isPostingOrder = false;
                                                setState(() {});
                                                showDialog(
                                                    barrierDismissible: false,
                                                    context: context,
                                                    builder: (context) {
                                                      return Align(
                                                        alignment: Alignment
                                                            .bottomCenter,
                                                        child: ErrorDialog(
                                                            errorMessage:
                                                                'Order Invalid'),
                                                      );
                                                    });
                                              }
                                            } else {
                                              isPostingOrder = false;
                                              setState(() {});
                                              showDialog(
                                                  barrierDismissible: false,
                                                  context: context,
                                                  builder: (context) {
                                                    return Align(
                                                      alignment: Alignment
                                                          .bottomCenter,
                                                      child: ErrorDialog(
                                                          errorMessage:
                                                              CartScreenViewModel
                                                                  .error!),
                                                    );
                                                  });
                                            }
                                          } else {
                                            isPostingOrder = false;
                                            setState(() {});
                                            showDialog(
                                                barrierDismissible: false,
                                                context: context,
                                                builder: (context) {
                                                  return Align(
                                                    alignment:
                                                        Alignment.bottomCenter,
                                                    child: ErrorDialog(
                                                        errorMessage: ErrorMessages
                                                            .insufficientFunds),
                                                  );
                                                });
                                          }
                                        }
                                      } catch (e) {
                                        print('goes into this');
                                        isPostingOrder = false;
                                        setState(() {});
                                        showDialog(
                                            barrierDismissible: false,
                                            context: context,
                                            builder: (context) {
                                              return Align(
                                                alignment:
                                                    Alignment.bottomCenter,
                                                child: ErrorDialog(
                                                    errorMessage:
                                                        WalletViewModel.error ??
                                                            ErrorMessages
                                                                .unknownError),
                                              );
                                            });
                                      }
                                    } else {
                                      isPostingOrder = false;
                                      setState(() {});
                                      return showDialog(
                                          barrierDismissible: false,
                                          context: context,
                                          builder: (context) {
                                            return Align(
                                              alignment: Alignment.bottomCenter,
                                              child: ErrorDialog(
                                                  errorMessage: 'Cart empty'),
                                            );
                                          });
                                    }
                                  }
                                }
                              },
                              child: Padding(
                                padding: EdgeInsets.symmetric(horizontal: 22.w),
                                child: Container(
                                  width: 428.w,
                                  height: 72.h,
                                  decoration: BoxDecoration(
                                    gradient: const LinearGradient(colors: [
                                      Color.fromRGBO(209, 154, 8, 1),
                                      Color.fromRGBO(254, 212, 102, 1),
                                      Color.fromRGBO(227, 186, 79, 1),
                                      Color.fromRGBO(209, 154, 8, 1),
                                      Color.fromRGBO(209, 154, 8, 1),
                                    ]),
                                    borderRadius: BorderRadius.circular(
                                      15.r,
                                    ),
                                  ),
                                  child: Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 40.w),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          children: [
                                            Text(
                                              'Pay Now',
                                              style: TextStyle(
                                                fontWeight: FontWeight.w800,
                                                color: Colors.black,
                                                fontSize: 20.sp,
                                              ),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Text(
                                              '₹ $total',
                                              style: TextStyle(
                                                fontWeight: FontWeight.w700,
                                                color: Colors.black,
                                                fontSize: 19.sp,
                                              ),
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                    )
                  ],
                ),
              );
            }
          },
        ),
      ]),
    );
  }
}
