import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:oasis_2022/screens/tickets/controller/store_controller.dart';
import 'package:oasis_2022/screens/tickets/repository/model/showsData.dart';
import 'package:oasis_2022/screens/tickets/view/buy_merch.dart';
import 'package:oasis_2022/screens/tickets/view_model/get_signedtickets_view_model.dart';
import 'package:oasis_2022/utils/scroll_remover.dart';

class Merch extends StatefulWidget {
  const Merch({Key? key}) : super(key: key);

  @override
  State<Merch> createState() => _MerchState();
}

class _MerchState extends State<Merch> {
  ScrollController scrollController = ScrollController();
  double position = 0;

  @override
  void initState() {
    StoreController.itemNumber.addListener(() {
      if (!mounted) {}
      setState(() {});
    });
    StoreController.itemBoughtOrRefreshed.addListener(() async {
      if (!mounted) {}
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Padding(
          padding: EdgeInsets.only(top: 61.h),
          child: SvgPicture.asset(
            "assets/images/merch_heading.svg",
            height: 85.h,
            width: 367.w,
          ),
        ),
        SizedBox(
          height: 561.h,
          child: ScrollConfiguration(
            behavior: CustomScrollBehavior(),
            child: CustomScrollView(
              controller: scrollController,
              scrollDirection: Axis.horizontal,
              shrinkWrap: true,
              slivers: [
                SliverToBoxAdapter(
                  child: Stack(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(top: 208.h),
                        child: Align(
                          alignment: Alignment.center,
                          child: SizedBox(
                            width: 520.w,
                            child: OverflowBox(
                              alignment: const Alignment(-1, -1),
                              maxHeight: double.infinity,
                              maxWidth: double.infinity,
                              child: SvgPicture.asset(
                                "assets/images/merch_bg.svg",
                                height: 276.18.h,
                              ),
                            ),
                          ),
                        ),
                      ),
                      ListView.builder(
                          physics: const BouncingScrollPhysics(),
                          scrollDirection: Axis.horizontal,
                          shrinkWrap: true,
                          itemBuilder: (BuildContext context, int index) {
                            return Row(children: [
                              Padding(
                                padding: (index % 2 == 0)
                                    ? EdgeInsets.only(
                                        top: 174.h, left: 20.w, bottom: 87.w)
                                    : EdgeInsets.only(
                                        top: 260.67.h, left: 21.h),
                                child: Container(
                                  height: 300.h,
                                  width: 200.w,
                                  decoration: BoxDecoration(
                                    gradient: const LinearGradient(colors: [
                                      Color.fromRGBO(254, 219, 126, 1),
                                      Color.fromRGBO(209, 154, 8, 1),
                                    ]),
                                    borderRadius:
                                        BorderRadius.circular(22.17.r),
                                  ),
                                  child: Padding(
                                    padding: EdgeInsets.all(0.4.w),
                                    child: Container(
                                      decoration: BoxDecoration(
                                          color: Colors.black,
                                          borderRadius:
                                              BorderRadius.circular(22.17.r)),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding: EdgeInsets.only(
                                                top: 14.h, left: 16.08.w),
                                            child: SizedBox(
                                                height: 203.h,
                                                width: 170.w,
                                                child: Stack(children: [
                                                  CachedNetworkImage(
                                                      imageUrl: (StoreController
                                                                      .carouselItems[
                                                                  StoreController
                                                                      .itemNumber
                                                                      .value]
                                                              as MerchCarouselItem)
                                                          .merch![index]
                                                          .image_url[0]),
                                                  Padding(
                                                    padding: EdgeInsets.only(
                                                        top: 160.h,
                                                        left: 27.73.w),
                                                    child: GestureDetector(
                                                      onTap: () {
                                                        print(StoreController
                                                                .carouselItems[
                                                            StoreController
                                                                .itemNumber
                                                                .value]);
                                                        showDialog(
                                                            context: context,
                                                            builder:
                                                                (context) =>
                                                                    BuyMerch(
                                                                      id: (StoreController.carouselItems[StoreController.itemNumber.value]
                                                                              as MerchCarouselItem)
                                                                          .merch![
                                                                              index]
                                                                          .id!,
                                                                      price: (StoreController.carouselItems[StoreController.itemNumber.value]
                                                                              as MerchCarouselItem)
                                                                          .merch![
                                                                              index]
                                                                          .price!,
                                                                      imageUrl: (StoreController.carouselItems[StoreController.itemNumber.value]
                                                                              as MerchCarouselItem)
                                                                          .merch![
                                                                              index]
                                                                          .image_url[1],
                                                                      amountPurchased:
                                                                          GetSignedTicketsViewModel()
                                                                              .getUnusedTickets(
                                                                        StoreController()
                                                                            .getId(index),
                                                                      ),
                                                                      name: (StoreController.carouselItems[StoreController.itemNumber.value]
                                                                              as MerchCarouselItem)
                                                                          .merch![
                                                                              index]
                                                                          .name!,
                                                                      available: (StoreController.carouselItems[StoreController.itemNumber.value]
                                                                              as MerchCarouselItem)
                                                                          .merch![
                                                                              index]
                                                                          .tickets_available!,
                                                                    ));
                                                      },
                                                      child: Container(
                                                        height: 35.56.h,
                                                        width: 114.54.w,
                                                        decoration: BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        8.r),
                                                            color:
                                                                Colors.black),
                                                        child: Center(
                                                          child: Text(
                                                            "BUY",
                                                            style: GoogleFonts.openSans(
                                                                color: const Color(
                                                                    0xFFE9E9E9),
                                                                fontSize:
                                                                    13.3.sp,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  )
                                                ])),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.only(
                                                top: 17.h, left: 16.w),
                                            child: Text(
                                              (StoreController.carouselItems[
                                                          StoreController
                                                              .itemNumber.value]
                                                      as MerchCarouselItem)
                                                  .merch![index]
                                                  .name!,
                                              style: GoogleFonts.openSans(
                                                  color:
                                                      const Color(0xFFEFEFEF),
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 18.sp),
                                            ),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.only(
                                                top: 5.h, left: 16.w),
                                            child: Text(
                                              "₹ ${(StoreController.carouselItems[StoreController.itemNumber.value] as MerchCarouselItem).merch![index].price}",
                                              style: GoogleFonts.openSans(
                                                  color:
                                                      const Color(0xFFEFEFEF),
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 16.sp),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(width: 20.w,)
                            ]);
                          },
                          itemCount: (StoreController.carouselItems[
                                      StoreController.itemNumber.value]
                                  as MerchCarouselItem)
                              .merch!
                              .length),
                    ],
                  ),
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}
