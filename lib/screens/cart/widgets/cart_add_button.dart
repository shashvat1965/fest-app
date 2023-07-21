import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
import '../../food_stalls/repo/model/hive_model/hive_menu_entry.dart';

class CartAddButton extends StatefulWidget {
  CartAddButton(
      {Key? key,
      required this.foodStallName,
      required this.isVeg,
      required this.foodStallId,
      required this.menuItemId,
      required this.price,
      required this.menuItemName,
      required this.amount})
      : super(key: key);
  int amount;
  String menuItemName;
  int price;
  bool isVeg;
  String foodStallName;
  int foodStallId;
  int menuItemId;

  @override
  State<CartAddButton> createState() => _CartAddButtonState();
}

class _CartAddButtonState extends State<CartAddButton> {
  @override
  Widget build(BuildContext context) {
    return Container(
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
          InkWell(
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
                var box = Hive.box('cartBox');
                widget.amount--;
                if (widget.amount == 0) {
                  box.delete(widget.menuItemId);
                } else {
                  box.put(
                      widget.menuItemId,
                      HiveMenuEntry(
                          menuItemName: widget.menuItemName,
                          price: widget.price,
                          FoodStall: widget.foodStallName,
                          quantity: widget.amount,
                          FoodStallId: widget.foodStallId,
                          isVeg: widget.isVeg));
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
                  "${widget.amount}",
                  style:
                      GoogleFonts.roboto(color: Colors.white, fontSize: 16.sp),
                ),
              ),
            ),
          ),
          InkWell(
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
                widget.amount++;
                var box = Hive.box('cartBox');
                box.put(
                    widget.menuItemId,
                    HiveMenuEntry(
                        menuItemName: widget.menuItemName,
                        price: widget.price,
                        FoodStall: widget.foodStallName,
                        quantity: widget.amount,
                        FoodStallId: widget.foodStallId,
                        isVeg: widget.isVeg));
              });
            },
          ),
        ],
      ),
    );
  }
}
