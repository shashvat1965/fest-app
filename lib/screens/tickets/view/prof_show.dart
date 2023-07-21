import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:oasis_2022/screens/tickets/repository/model/showsData.dart';
import 'package:oasis_2022/widgets/loader.dart';

import '../controller/store_controller.dart';
import 'banner_details.dart';

class ProfShow extends StatefulWidget {
  const ProfShow({Key? key}) : super(key: key);

  @override
  State<ProfShow> createState() => _ProfShowState();
}

class _ProfShowState extends State<ProfShow> {
  @override
  void initState() {
    StoreController.itemNumber.addListener(() {
      if (!mounted) {}
      setState(() {});
    });
    StoreController.itemBoughtOrRefreshed.addListener(() {
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
          padding: EdgeInsets.only(top: 43.h, left: 8.w),
          child: CachedNetworkImage(
            imageUrl:
                (StoreController.carouselItems[StoreController.itemNumber.value]
                        as StoreItemData)
                    .image_url[1],
            placeholder: (context, url) => const CircularProgressIndicator(
              color: Colors.black,
            ),
            height: 436.h,
            width: 1.sw,
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top: 350.h),
          child: Stack(
            children: [
              Container(
                height: 176.h,
                decoration: const BoxDecoration(
                    gradient: LinearGradient(colors: [
                  Colors.black,
                  Colors.black,
                  Colors.transparent
                ], begin: Alignment.bottomCenter, end: Alignment.topCenter)),
              ),
              Padding(
                padding: EdgeInsets.only(top: 88.h, left: 20.w),
                child: const BannerDetails(),
              )
            ],
          ),
        ),
      ],
    );
  }
}
