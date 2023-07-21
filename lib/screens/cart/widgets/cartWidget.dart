import 'package:flutter_screenutil/flutter_screenutil.dart';
import '/screens/cart/viewmodel/cart_viewmodel.dart';
import '/screens/cart/widgets/cartItemWidget.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import '../repo/model/cart_screen_model.dart';

class cartWidget extends StatefulWidget {
  cartWidget(
      {super.key,
      required this.foodStallName,
      required this.menuList,
      required this.foodStallId});

  String foodStallName;
  int foodStallId;
  List<MenuItemInCartScreen> menuList;

  @override
  State<cartWidget> createState() => _cartWidgetState();
}

class _cartWidgetState extends State<cartWidget> {
  int subTotal = 0;

  @override
  void initState() {
    subTotal = CartScreenViewModel().getSubTotal(widget.foodStallId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: Hive.box('cartBox').listenable(),
        builder: (context, Box box, child) {
          subTotal = CartScreenViewModel().getSubTotal(widget.foodStallId);
          return Column(
            children: [
              Container(
                color: Colors.black,
                child: Column(
                  children: [
                    SizedBox(
                      height: 28.w,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: 28.w,
                        ),
                        Text(
                          widget.foodStallName,
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 24.00.sp,
                            color: const Color.fromRGBO(194, 194, 194, 1),
                          ),
                        ),
                        SizedBox(
                          width: 6.w,
                        ),
                        Text(
                          '(${widget.menuList.length} items)',
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 11.sp,
                            color: const Color.fromRGBO(194, 194, 194, 1),
                          ),
                        )
                      ],
                    ),
                    ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return CartItemWidget(
                          isVeg: widget.menuList[index].isVeg,
                          menuItemId: widget.menuList[index].menuItemId,
                          foodStallName: widget.foodStallName,
                          foodStallId: widget.foodStallId,
                          menuItemName: widget.menuList[index].menuItemName,
                          price: widget.menuList[index].menuItemPrice,
                          quantity: widget.menuList[index].menuItemQuantity,
                        );
                      },
                      itemCount: widget.menuList.length,
                    ),
                    Padding(
                      padding: EdgeInsets.only(bottom: 18.h),
                      child: Divider(
                        color: const Color.fromRGBO(255, 255, 255, 0.85),
                        endIndent: 30.w,
                        indent: 30.w,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            SizedBox(
                              width: 36.w,
                            ),
                            Text(
                              'SubTotal',
                              style: TextStyle(
                                fontSize: 20.sp,
                                fontWeight: FontWeight.w700,
                                color: const Color.fromRGBO(194, 194, 194, 1),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Text(
                              '₹ $subTotal',
                              style: TextStyle(
                                fontSize: 20.sp,
                                fontWeight: FontWeight.w800,
                                color: const Color.fromRGBO(194, 194, 194, 1),
                              ),
                            ),
                            SizedBox(
                              width: 36.w,
                            )
                          ],
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 31.h,
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 16.h,
              ),
            ],
          );
        });
  }
}
