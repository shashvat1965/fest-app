import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:oasis_2022/utils/oasis_text_styles.dart';

class SingleBlock extends StatelessWidget {
  const SingleBlock(
      {Key? key,
      required this.assetName,
      required this.name,
      required this.action})
      : super(key: key);
  final String assetName;
  final String name;
  final Function() action;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: action,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            children: [
              Padding(
                padding: EdgeInsets.only(left: 35.w),
                child: SvgPicture.asset(assetName, width: 23.w, height: 23.h),
              ),
              SizedBox(width: 24.41.w),
              Text(
                name,
                style: OasisTextStyles.openSans400,
              )
            ],
          ),
          SizedBox(
            height: 22.h,
          ),
          Center(
            child: SizedBox(
              width: 320.w,
              child: Divider(
                height: 1,
                thickness: 0.2.h,
                color: Color(0xFFB6B6B6).withOpacity(0.8),
              ),
            ),
          ),
          SizedBox(height: 21.69.h)
        ],
      ),
    );
  }
}
