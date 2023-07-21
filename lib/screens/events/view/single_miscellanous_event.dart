import 'dart:ui';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:oasis_2022/resources/resources.dart';
import 'package:oasis_2022/utils/colors.dart';
import 'package:oasis_2022/utils/oasis_text_styles.dart';

class SingleMiscellaneousEvent extends StatefulWidget {
  SingleMiscellaneousEvent(
      {Key? key,
      required this.time,
      required this.eventName,
      required this.eventDescription,
      required this.eventConductor,
      required this.eventLocation})
      : super(key: key);

  String? time;
  String? eventName;
  String? eventDescription;
  String? eventConductor;
  String? eventLocation;

  @override
  State<SingleMiscellaneousEvent> createState() =>
      _SingleMiscellaneousEventState();
}

class _SingleMiscellaneousEventState extends State<SingleMiscellaneousEvent> {
  late bool isLong;
  bool isExpanded = false;
  final ScrollController _controllerOne = ScrollController();

  @override
  void initState() {

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    isLong = (widget.eventDescription == null)
        ? false
        : (widget.eventDescription!.length > 172);

    return GestureDetector(
      onTap: () {
        if (isLong) {
          {
            setState(() {
              isExpanded = !isExpanded;
            });
          }
        }
      },
      child: Padding(
        padding: EdgeInsets.only(bottom: 20.h),
        child: Container(
          width: 388.w,
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(ImageAssets.eventCardBg), fit: BoxFit.fill),
              borderRadius: BorderRadius.circular(20.r)),
          child: Padding(
            padding: EdgeInsets.fromLTRB(21.w, 26.h, 25.w, 27.h),
            child: Container(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(widget.eventName ?? 'TBA',
                    style: OasisTextStyles.openSansSubHeading
                        .copyWith(color: Colors.white)),
                SizedBox(height: 12.h),
              (widget.eventConductor != '') ?
                Text(widget.eventConductor ?? 'DEPARTMENT',
                    style: OasisTextStyles.openSansSubHeading.copyWith(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w500,
                        color: OasisColors.primaryYellow))
                : Container(height: 30,color: Colors.red,)
                ,
                SizedBox(height: 13.h),
                !isLong
                    ? Padding(
                        padding: EdgeInsets.only(right: 10.w),
                        child: Text(
                          widget.eventDescription ??
                              'More details will be added later',
                          style: OasisTextStyles.openSans300
                              .copyWith(fontSize: 14.sp, color: Colors.white),
                        ),
                      )
                    : isExpanded
                        ? widget.eventDescription!.length < 756
                            ? Padding(
                                padding: EdgeInsets.only(right: 0.w),
                                child: Text(
                                  widget.eventDescription!,
                                  style: OasisTextStyles.openSans300.copyWith(
                                      fontSize: 14.sp, color: Colors.white),
                                ),
                              )
                            : Padding(
                                padding: EdgeInsets.only(right: 15.w),
                                child: RawScrollbar(
                                    controller: _controllerOne,
                                    thumbVisibility: true,
                                    thickness: 2.w,
                                    //minThumbLength: 45.h,
                                    thumbColor: Color(0xFFA78611),
                                    scrollbarOrientation:
                                        ScrollbarOrientation.right,
                                    child: Container(
                                      padding: EdgeInsets.only(right: 15.w),
                                      height: 240.h,
                                      child: ListView(
                                        physics: const BouncingScrollPhysics(),
                                        controller: _controllerOne,
                                        children: [
                                          Text(
                                            widget.eventDescription!,
                                            style: OasisTextStyles.openSans300
                                                .copyWith(
                                                    fontSize: 14.sp,
                                                    color: Colors.white),
                                          )
                                        ],
                                      ),
                                    )),
                              )
                        : Padding(
                            padding: EdgeInsets.only(right: 25.w),
                            child: RichText(
                              text: TextSpan(
                                text:
                                    widget.eventDescription!.substring(0, 160),
                                style: OasisTextStyles.openSans300.copyWith(
                                    fontSize: 14.sp, color: Colors.white),
                                children: <TextSpan>[
                                  TextSpan(
                                      text: ' ...see more',
                                      style: OasisTextStyles.openSans600
                                          .copyWith(
                                              fontSize: 12.sp,
                                              color: Colors.white),
                                      recognizer: TapGestureRecognizer()
                                        ..onTap = () {
                                          setState(() {
                                            isExpanded = true;
                                          });
                                        }),
                                ],
                              ),
                            ),
                          ),
                SizedBox(height: 10.h),
                const Divider(color: Color.fromRGBO(255, 255, 255, 0.2),),
                SizedBox(height: 10.h,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SvgPicture.asset(ImageAssets.locationIcon,
                            color: Colors.white),
                        SizedBox(width: 8.23.w),
                        Text(widget.eventLocation ?? 'TBA',
                            style: OasisTextStyles.openSans300
                                .copyWith(fontSize: 12.sp, color: Colors.white,fontWeight: FontWeight.w900)),
                      ],
                    ),


                    Row(
                      children: [
                        SvgPicture.asset(ImageAssets.timeicon, color: Colors.white),
                        SizedBox(width: 8.23.w),
                        Text(widget.time ?? 'TBA',
                            style: OasisTextStyles.openSans300
                                .copyWith(fontSize: 12.sp, color: Colors.white,fontWeight: FontWeight.w900)),
                      ],
                    ),

                  ],
                )
              ],
            )),
          ),
        ),
      ),
    );
  }
}
