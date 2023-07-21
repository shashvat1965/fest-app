import 'package:flutter_screenutil/flutter_screenutil.dart';
import '/screens/cart/widgets/cart_add_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';

class CartItemWidget extends StatefulWidget {
  CartItemWidget(
      {required this.menuItemName,
      required this.isVeg,
      required this.menuItemId,
      required this.foodStallName,
      required this.foodStallId,
      required this.price,
      required this.quantity,
      super.key});

  String menuItemName;
  String foodStallName;
  bool isVeg;
  int foodStallId;
  int price;
  int menuItemId;
  int quantity;

  @override
  State<CartItemWidget> createState() => CartItemWidgetState();
}

class CartItemWidgetState extends State<CartItemWidget> {
  bool isVeg = false;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: Hive.box('cartBox').listenable(),
        builder: (context, Box box, child) {
          return Column(
            children: [
              SizedBox(
                width: 354.h,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        SvgPicture.asset(
                          'assets/images/Non-Veg.svg',
                          color: widget.isVeg ? Colors.green : Colors.red,
                        ),
                        SizedBox(
                          width: 20.w,
                        ),
                        Container(
                          width: 180.w,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                widget.menuItemName,
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 16.sp,
                                  color: const Color.fromRGBO(194, 194, 194, 1),
                                ),
                              ),
                              SizedBox(
                                height: 3.86.h,
                              ),
                              Text(
                                '₹ ${widget.price}',
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 14.sp,
                                  color: const Color.fromRGBO(194, 194, 194, 1),
                                ),
                                textAlign: TextAlign.left,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    CartAddButton(
                      isVeg: widget.isVeg,
                      foodStallId: widget.foodStallId,
                      foodStallName: widget.foodStallName,
                      menuItemId: widget.menuItemId,
                      menuItemName: widget.menuItemName,
                      price: widget.price,
                      amount: widget.quantity,
                    )
                  ],
                ),
              ),
              SizedBox(
                width: double.infinity,
                height: 24.h,
              ),
            ],
          );
        });
  }
}
