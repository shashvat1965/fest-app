import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gradient_borders/gradient_borders.dart';
import 'package:oasis_2022/screens/kindstore/view_model/kind_store_catalog_view_model.dart';

import '/utils/ui_utils.dart';
import '/widgets/loader.dart';
import '../../../widgets/error_dialogue.dart';

class KindStoreCatalog extends StatefulWidget {
  const KindStoreCatalog({super.key});

  @override
  State<KindStoreCatalog> createState() => _KindStoreCatalogState();
}

class _KindStoreCatalogState extends State<KindStoreCatalog> {
  late ValueNotifier<bool> isLoading = ValueNotifier(true);

  getList() async {
    await KindStoreViewModel().getKindStoreCatalogItems();
    if (KindStoreViewModel.error != null) {
      isLoading.value = false;
      showDialog(
          barrierDismissible: false,
          context: context,
          builder: (context) {
            return Align(
              alignment: Alignment.bottomCenter,
              child: ErrorDialog(errorMessage: KindStoreViewModel.error!),
            );
          });
    } else {
      isLoading.value = false;
    }
  }

  @override
  void initState() {
    super.initState();
    getList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () async {
          await getList();
          setState(() {});
        },
        child: ValueListenableBuilder(
          valueListenable: isLoading,
          builder: (BuildContext context, bool value, Widget? child) {
            if (isLoading.value) {
              return const Center(child: Loader());
            } else {
              return Stack(
                children: [
                  KindStoreViewModel.kindItemsResult.items_details!.isEmpty
                      ? Center(
                          child: ErrorDialog(
                            errorMessage:
                                'Kind Store Catalog will be updated soon',
                          ),
                        )
                      : Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(
                                  top: UIUtills()
                                      .getProportionalHeight(height: 80),
                                  left: UIUtills()
                                      .getProportionalWidth(width: 28),
                                  right: UIUtills()
                                      .getProportionalWidth(width: 27.7)),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Kind Store",
                                    textScaleFactor: 1.00,
                                    style: GoogleFonts.openSans(
                                        fontSize: 28,
                                        color: Colors.white,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  Row(
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          Navigator.pop(context);
                                        },
                                        child: SvgPicture.asset(
                                          'assets/icons/cross_icon.svg',
                                          color: Colors.white,
                                        ),
                                      )
                                    ],
                                  )
                                ],
                              ),
                            ),
                            Expanded(
                              child: GridView.builder(
                                padding: EdgeInsets.only(
                                    left: 23.00.w, right: 23.00.w, top: 41.h),
                                itemCount: KindStoreViewModel
                                    .kindItemsResult.items_details!.length,
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  childAspectRatio: 0.65,
                                  crossAxisSpacing: UIUtills()
                                      .getProportionalWidth(width: 20),
                                  mainAxisSpacing: UIUtills()
                                      .getProportionalHeight(height: 24),
                                ),
                                itemBuilder: (BuildContext context, int index) {
                                  return Container(
                                    alignment: Alignment.center,
                                    padding: EdgeInsets.only(
                                        left: 13.00.w,
                                        right: 13.00.w,
                                        top: 9.00.h),
                                    decoration: BoxDecoration(
                                        border: GradientBoxBorder(
                                          width: 0.15.w,
                                          gradient: const LinearGradient(
                                            colors: [
                                              Color.fromRGBO(209, 154, 8, 1),
                                              Color.fromRGBO(254, 212, 102, 1),
                                              Color.fromRGBO(227, 186, 79, 1),
                                              Color.fromRGBO(209, 154, 8, 1),
                                              Color.fromRGBO(209, 154, 8, 1),
                                            ],
                                          ),
                                        ),
                                        color: Colors.black,
                                        borderRadius:
                                            BorderRadius.circular(20.r)),
                                    // width: 179.w,
                                    // height: 270.h,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          height: 9.h,
                                        ),
                                        Stack(
                                          children: [
                                            ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(
                                                      10.74.r),
                                              child: Image.asset(
                                                  fit: BoxFit.fill,
                                                  height: 183.h,
                                                  width: 152.h,
                                                  'assets/images/OASISLogoGoldPNG.png'),
                                            ),
                                            ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(
                                                      10.74.r),
                                              child: Image(
                                                fit: BoxFit.fill,
                                                height: 183.h,
                                                width: 152.h,
                                                image: NetworkImage(
                                                    KindStoreViewModel
                                                        .kindItemsResult
                                                        .items_details![index]
                                                        .image!),
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: 15.h),
                                        Text(
                                          KindStoreViewModel.kindItemsResult
                                              .items_details![index].name!,
                                          textAlign: TextAlign.left,
                                          style: GoogleFonts.openSans(
                                              fontSize: 16.sp,
                                              color: const Color.fromRGBO(
                                                  239, 239, 239, 1),
                                              fontWeight: FontWeight.w700),
                                        ),
                                        SizedBox(height: 7.56.h),
                                        Row(
                                          children: [
                                            SvgPicture.asset(
                                                'assets/icons/KindStoreIcon.svg'),
                                            Text(
                                              '  ${KindStoreViewModel.kindItemsResult.items_details![index].price}',
                                              style: GoogleFonts.openSans(
                                                  fontSize: 12.91.sp,
                                                  color: const Color.fromRGBO(
                                                      250, 250, 250, 1),
                                                  fontWeight: FontWeight.w600),
                                            )
                                          ],
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              ),
                            )
                          ],
                        )
                ],
              );
            }
          },
        ),
      ),
    );
  }
}
