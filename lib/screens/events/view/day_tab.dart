import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '/utils/colors.dart';
import '/utils/oasis_text_styles.dart';
import 'misc_screen_controller.dart';

class DayTab extends StatefulWidget {
  DayTab({Key? key, required this.dayNumber}) : super(key: key);
  final int dayNumber;

  @override
  State<DayTab> createState() => _DayTabState();
}

class _DayTabState extends State<DayTab> {
  @override
  void initState() {
    MiscScreenController.selectedTab.addListener(() {
      if (mounted) setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    bool isSelected =
        MiscScreenController.selectedTab.value == widget.dayNumber;
    return GestureDetector(
      onTap: () {
        if (!isSelected) {
          MiscScreenController.selectedTab.value = widget.dayNumber;
        }
      },
      child: Container(
        width: 61.w,
        height: 96.h,
        decoration: isSelected
            ? BoxDecoration(
                boxShadow: [
                  BoxShadow(
                      color: Color.fromRGBO(213, 192, 0, 0.15000000596046448),
                      offset: Offset(0, 4),
                      blurRadius: 8)
                ],
                gradient: OasisColors.oasisWebsiteGoldGradient,
                borderRadius: BorderRadius.circular(20.r),
              )
            : BoxDecoration(
                color: Color.fromRGBO(0, 0, 0, 0.8),
                border: Border.all(color: Colors.white, width: 0.3.w),
                borderRadius: BorderRadius.circular(20.r)),
        child: Column(
          children: <Widget>[
            SizedBox(height: 20.52.h),
            Text(widget.dayNumber.toString(),
                style: OasisTextStyles.openSans600
                    .copyWith(color: isSelected ? Colors.black : Colors.white)),
            Text('NOV',
                style: OasisTextStyles.openSans300
                    .copyWith(color: isSelected ? Colors.black : Colors.white))
          ],
        ),
      ),
    );
  }
}
