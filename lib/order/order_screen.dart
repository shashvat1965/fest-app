import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:oasis_2022/order/order_widget.dart';
import 'package:oasis_2022/order/repo/model/get_orders_model.dart';
import 'package:oasis_2022/order/repo/model/order_card_model.dart';
import 'package:oasis_2022/utils/scroll_remover.dart';

import '../screens/morescreen/screens/more_info.dart';
import '../widgets/error_dialogue.dart';
import '../widgets/loader.dart';
import 'controller/cart_and_order_controller.dart';
import 'order_screen_viewmodel.dart';

class OrdersScreen extends StatefulWidget {
  const OrdersScreen({Key? key}) : super(key: key);

  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  List<GetOrderResult> orderResultList = [];
  List<OrderCardModel> orderCardList = [];
  ValueNotifier<bool> isLoading = ValueNotifier(true);

  @override
  void initState() {
    getOrderResult();
    CartAndOrderController.newOrder.addListener(() {
      isLoading.value = true;
    });
    super.initState();
  }

  Future<bool> checkConnection() async {
    bool gotError;
    try {
      await getOrderResult();
      gotError = false;
    } catch (_) {
      gotError = true;
    }
    return gotError;
  }

  Future<void> getOrderResult() async {
    orderResultList = await OrderScreenViewModel().getOrders();
    orderCardList = OrderScreenViewModel().changeDataModel(orderResultList);
    isLoading.value = false;
    if (OrderScreenViewModel.error != null) {
      showDialog(
          barrierDismissible: false,
          context: context,
          builder: (context) {
            return Align(
              alignment: Alignment.bottomCenter,
              child: ErrorDialog(errorMessage: OrderScreenViewModel.error,),
            );
          });
    }
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance!.addPostFrameCallback((_) async {
      bool gotError = await checkConnection();
      if (gotError) {
        showDialog(
            barrierDismissible: false,
            context: context,
            builder: (context) {
              return Align(
                alignment: Alignment.bottomCenter,
                child: ErrorDialog(),
              );
            });
      }
    });
    return Scaffold(
        body: ValueListenableBuilder(
            valueListenable: isLoading,
            builder: (context, bool value, child) {
              getOrderResult();
              if (isLoading.value) {
                return const Center(child: Loader());
              } else {
                return Container(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  color: Colors.black,
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(28.w, 84.h, 30.w, 0),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Orders',
                              style: GoogleFonts.openSans(
                                  fontSize: 28.sp,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),

                          ],
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 23.h),
                          child: Text(
                            'Keep track of your orders. Click on view details to know more',
                            style: GoogleFonts.openSans(
                                color: Color.fromRGBO(255, 255, 255, 0.75),
                                fontWeight: FontWeight.w500,
                                fontSize: 18.sp),
                          ),
                        ),
                        orderCardList.isEmpty
                            ? Padding(
                                padding: EdgeInsets.only(top: 80.h),
                                child: SvgPicture.asset(
                                    'assets/images/no_orders.svg'),
                              )
                            : Padding(
                                padding: EdgeInsets.only(top: 58.h),
                                child: SizedBox(
                                    height: 410.h,
                                    width: 1.sw,
                                    child: Container(
                                      height: 410.h,
                                      width: 1.sw,
                                      constraints: BoxConstraints(
                                          maxWidth: 1.sw, maxHeight: 410.h),
                                      child: ScrollConfiguration(
                                        behavior: CustomScrollBehavior(),
                                        child: ListView.builder(
                                            shrinkWrap: true,
                                            scrollDirection: Axis.horizontal,
                                            itemCount: orderCardList.length,
                                            itemBuilder: (context, index) {
                                              return Container(
                                                  constraints: BoxConstraints(
                                                      maxWidth: 1.sw,
                                                      maxHeight: 410.h),
                                                  child: OrderWidget(
                                                      orderCardModel:
                                                          orderCardList[
                                                              index]));
                                            }
                                            // scrollDirection: Axis.horizontal,
                                            // shrinkWrap: true,
                                            ),
                                      ),
                                    ))) //),
                        //     ),
                      ],
                    ),
                  ),
                );
              }
            }));
  }
}
