import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:oasis_2022/order/repo/model/order_card_model.dart';
import 'package:oasis_2022/widgets/loader.dart';

import '../resources/resources.dart';
import 'order_status.dart';

class OrderWidget extends StatefulWidget {
  OrderWidget({Key? key, required this.orderCardModel}) : super(key: key);
  OrderCardModel orderCardModel;

  @override
  State<OrderWidget> createState() => _OrderWidgetState();
}

class _OrderWidgetState extends State<OrderWidget> {
  String? OrderId;
  ValueNotifier<bool> isLoading = ValueNotifier(true);
  Stream<DocumentSnapshot>? collectionStream;

  @override
  void initState() {
    OrderId = widget.orderCardModel.orderId.toString();
    collectionStream = FirebaseFirestore.instance
        .collection('orders')
        .doc(OrderId)
        .snapshots();
    isLoading.value = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 262.w,
      child: ValueListenableBuilder(
        valueListenable: isLoading,
        builder: (context, bool value, child) {
          if (value) {
            return const Center(
              child: Loader(),
            );
          } else {
            return StreamBuilder<DocumentSnapshot>(
                stream: collectionStream,
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return Loader();
                  } else {
                    return Padding(
                      padding: EdgeInsets.only(right: 20.w),
                      child: Container(
                        height: 410.h,
                        width: 262.w,
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage(ImageAssets.gradient_order),
                              fit: BoxFit.fill),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.fromLTRB(16, 12, 11, 0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    '${DateFormat.yMMMMd().format(DateTime.parse(widget.orderCardModel.timeStamp)).toString()}',
                                    style: GoogleFonts.openSans(
                                      color: const Color.fromRGBO(
                                          148, 148, 148, 1),
                                      fontWeight: FontWeight.w400,
                                      fontSize: 11.sp,
                                    ),
                                  ),
                                  Text(
                                    '${DateFormat.jms().format(DateTime.parse(widget.orderCardModel.timeStamp)).toString()}',
                                    style: GoogleFonts.openSans(
                                      color: const Color.fromRGBO(
                                          148, 148, 148, 1),
                                      fontWeight: FontWeight.w400,
                                      fontSize: 11.sp,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                top: 15.h,
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(6.25.r),
                                child: Image.network(
                                  widget.orderCardModel.order_image_url ?? '',
                                  height: 139.h,
                                  width: 139.w,
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                top: 12.h,
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    'Status : ',
                                    style: GoogleFonts.openSans(
                                      color: const Color.fromRGBO(
                                          225, 225, 225, 1),
                                      fontWeight: FontWeight.w400,
                                      fontSize: 11.sp,
                                    ),
                                  ),
                                  Text(
                                    foodStatus(snapshot.data!
                                            .data()
                                            .toString()
                                            .contains('status')
                                        ? snapshot.data?.get('status')
                                        : 0),
                                    style: GoogleFonts.openSans(
                                      color: statusColor(snapshot.data!
                                              .data()
                                              .toString()
                                              .contains('status')
                                          ? snapshot.data?.get('status')
                                          : 0),
                                      fontWeight: FontWeight.w600,
                                      fontSize: 11.sp,
                                    ),
                                  )
                                ],
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: 9.h),
                              child: Text(
                                widget.orderCardModel.foodStallName,
                                overflow: TextOverflow.ellipsis,
                                style: GoogleFonts.openSans(
                                  color: const Color.fromRGBO(225, 225, 225, 1),
                                  fontWeight: FontWeight.w700,
                                  fontSize: 20.sp,
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: 10.h),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(right: 27.w),
                                    child: Column(
                                      children: [
                                        Text(
                                          widget.orderCardModel.orderId
                                              .toString(),
                                          style: GoogleFonts.openSans(
                                            color: const Color.fromRGBO(
                                                225, 225, 225, 1),
                                            fontWeight: FontWeight.w600,
                                            fontSize: 16.sp,
                                          ),
                                          textScaleFactor: 1,
                                        ),
                                        Text(
                                          'order no.',
                                          style: GoogleFonts.openSans(
                                            color: const Color.fromRGBO(
                                                225, 225, 225, 1),
                                            fontWeight: FontWeight.w600,
                                            fontSize: 10.sp,
                                          ),
                                          textScaleFactor: 1,
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(right: 27.w),
                                    child: Container(
                                      height: 33.h,
                                      width: 1.5,
                                      color: Colors.white,
                                    ),
                                  ),
                                  Column(
                                    children: [
                                      Text(
                                        widget.orderCardModel.itemCount
                                            .toString(),
                                        style: GoogleFonts.openSans(
                                          color: const Color.fromRGBO(
                                              225, 225, 225, 1),
                                          fontWeight: FontWeight.w600,
                                          fontSize: 16.sp,
                                        ),
                                        textScaleFactor: 1,
                                      ),
                                      Text(
                                        'items',
                                        style: GoogleFonts.openSans(
                                          color: const Color.fromRGBO(
                                              225, 225, 225, 1),
                                          fontWeight: FontWeight.w600,
                                          fontSize: 10.sp,
                                        ),
                                        textScaleFactor: 1,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                showDialog(
                                    context: context,
                                    builder: (context) {
                                      return Align(
                                          alignment: Alignment.bottomCenter,
                                          child: OrderStatus(
                                            orderCardModel:
                                                widget.orderCardModel,
                                          ));
                                    });
                              },
                              child: Padding(
                                padding: EdgeInsets.only(top: 22.h),
                                child: Container(
                                  alignment: Alignment.center,
                                  // alignment: Alignment.bottomCenter,
                                  width: 160.w,
                                  height: 39.h,
                                  // margin: EdgeInsets.symmetric(
                                  //     horizontal:
                                  //     UIUtills().getProportionalWidth(width: 20.00)),
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
                                    borderRadius: BorderRadius.circular(7.7.r),
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        'View Details',
                                        style: GoogleFonts.openSans(
                                            fontWeight: FontWeight.w600,
                                            color: Colors.black,
                                            fontSize: 14.sp),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }
                });
          }
        },
      ),
    );
  }

  String foodStatus(int status) {
    if (status == 4) {
      return "Cancelled";
    } else if (status == 1) {
      return "Accepted";
    } else if (status == 0) {
      return "Pending";
    } else if (status == 2) {
      return "Ready";
    } else if (status == 3) {
      return "Delivered";
    }
    return "Delivered";
  }

  Color statusColor(int status) {
    if (status == 4) {
      return Color(0xffE10000);
    } else if (status == 1) {
      return Color(0xff00CE78);
    } else if (status == 0) {
      return Color(0xffE1B000);
    } else if (status == 2) {
      return Color(0xff188E05);
    } else {
      return Color(0xffCDCDCD);
    }
  }
}
