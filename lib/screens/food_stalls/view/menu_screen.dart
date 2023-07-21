import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:oasis_2022/widgets/loader.dart';

import '/screens/cart/cartScreen.dart';
import '/screens/food_stalls/repo/model/food_stall_model.dart' as menu;
import '/utils/ui_utils.dart';
import '../view_model/menu_screen_viewmodel.dart';
import 'menu_add_buttons.dart';

class MenuScreen extends StatefulWidget {
  MenuScreen(
      {Key? key,
      required this.menuItemList,
      required this.foodStallName,
      required this.image,
      required this.foodStallId})
      : super(key: key);
  List<menu.MenuItem> menuItemList;
  String foodStallName;
  String image;
  int foodStallId;

  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  List<menu.MenuItem> menuItemsFiltered = [];
  bool isNotEmpty = true;
  FocusNode searchFocusNode = FocusNode();
  final _formKey = GlobalKey<FormState>();
  Map<int, int> menuItemsAmount = {};
  TextEditingController searchController = TextEditingController();

  void createSearchFilteredList(String? query) {
    menuItemsFiltered =
        MenuScreenViewModel().searchList(query ?? "", widget.menuItemList);
  }

  void makeMenuList() {
    menuItemsFiltered = widget.menuItemList;
    menuItemsAmount =
        MenuScreenViewModel().populateListFromHive(menuItemsFiltered);
  }

  //TODO: add a foodstall banner image in backend
  @override
  void initState() {
    makeMenuList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        body: Stack(children: [
          Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Padding(
                padding: EdgeInsets.only(
                    top: UIUtills().getProportionalHeight(height: 50),
                    left: UIUtills().getProportionalWidth(width: 20),
                    right: UIUtills().getProportionalWidth(width: 20)),
                child: Center(
                  child: Stack(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: CachedNetworkImage(
                          placeholder: (context, url) => SizedBox(
                              height: 259.h,
                              width: 388.w,
                              child: const Loader()),
                          imageUrl: '${widget.image}',
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        child: Stack(
                          children: [
                            ClipRRect(
                              borderRadius: const BorderRadius.only(
                                  bottomLeft: Radius.circular(20),
                                  bottomRight: Radius.circular(20)),
                              child: BackdropFilter(
                                filter:
                                    ImageFilter.blur(sigmaY: 25, sigmaX: 25),
                                child: Container(
                                  decoration: const BoxDecoration(
                                    color: Colors.transparent,
                                    borderRadius: BorderRadius.only(
                                        bottomRight: Radius.circular(20),
                                        bottomLeft: Radius.circular(20)),
                                  ),
                                  width: 388.w,
                                  height: 97.h,
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: 16.h, left: 20.w),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  RichText(
                                      text: TextSpan(children: [
                                    TextSpan(

                                        text: widget.foodStallName,
                                        style: GoogleFonts.openSans(
                                            fontSize: 28.sp,
                                            color: Colors.white,
                                            fontWeight: FontWeight.w600)),
                                    TextSpan(
                                      text:
                                          "\nChoose from ${widget.menuItemList.length} different dishes",
                                      style: GoogleFonts.openSans(
                                          fontSize: 14.sp,
                                          color: Colors.white,
                                          fontWeight: FontWeight.w400),
                                    )
                                  ])),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Padding(
                          padding: EdgeInsets.only(left: 20.w, top: 20.h),
                          child: Container(
                            decoration: BoxDecoration(
                                color: const Color.fromRGBO(44, 47, 53, 1),
                                borderRadius: BorderRadius.circular(5)),
                            height: 36.h,
                            width: 36.w,
                            child: const Icon(
                              Icons.arrow_back,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 24.h, left: 20.w, right: 20.w),
                child: Container(
                  height: 47.h,
                  width: 388.w,
                  decoration: BoxDecoration(
                      border: Border.all(
                          color: const Color.fromRGBO(248, 216, 72, 0.45)),
                      boxShadow: const [
                        BoxShadow(
                            color: Color.fromRGBO(0, 0, 0, 0.25),
                            offset: Offset(0, 2.36364),
                            blurRadius: 4.72727)
                      ],
                      borderRadius: BorderRadius.circular(12),
                      gradient: const LinearGradient(
                          colors: <Color>[
                            Color.fromRGBO(164, 108, 0, 0.15),
                            Color.fromRGBO(209, 154, 8, 0.15)
                          ],
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight)),
                  child: Center(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.fromLTRB(17.22.w, 0, 16.41.w, 0),
                          child: const Center(
                              child: Icon(
                            Icons.search,
                            color: Colors.white,
                          )),
                        ),
                        Expanded(
                          child: Center(
                            child: Form(
                              key: _formKey,
                              child: TextField(
                                onChanged: (value) {
                                  setState(() {
                                    createSearchFilteredList(value);
                                  });
                                },
                                controller: searchController,
                                style: GoogleFonts.poppins(
                                    color: Colors.white, fontSize: 14.sp),
                                cursorColor: Colors.white,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  labelStyle:
                                      GoogleFonts.openSans(color: Colors.white),
                                  hintText: "Search",
                                  hintStyle: GoogleFonts.openSans(
                                      color: Colors.white, fontSize: 16.sp),
                                  suffixIcon: IconButton(
                                      splashColor: Colors.transparent,
                                      onPressed: () {
                                        searchController.clear();
                                        setState(() {
                                          createSearchFilteredList("");
                                          searchFocusNode.unfocus();
                                          FocusManager.instance.primaryFocus
                                              ?.unfocus();
                                        });
                                      },
                                      icon: const Icon(Icons.close,
                                          color: Colors.grey, size: 16)),
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              Expanded(
                child: ValueListenableBuilder(
                  valueListenable: Hive.box('cartBox').listenable(),
                  builder: (context, Box box, child) {
                    menuItemsAmount = MenuScreenViewModel()
                        .populateListFromHive(menuItemsFiltered);
                    return Padding(
                      padding: EdgeInsets.only(bottom: 60.h),
                      child: ListView.builder(
                        scrollDirection: Axis.vertical,
                        itemCount: menuItemsFiltered.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Padding(
                            padding: EdgeInsets.only(bottom: 16.h),
                            child: Column(
                              children: [
                                (index != 0)
                                    ? Divider(
                                        color: const Color.fromRGBO(
                                            255, 255, 255, 1),
                                        indent: 47.w,
                                        endIndent: 47.w,
                                      )
                                    : Container(),
                                Padding(
                                  padding: EdgeInsets.only(top: 8.h),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Expanded(
                                        child: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Padding(
                                              padding:
                                                  const EdgeInsets.fromLTRB(
                                                      37, 0, 20.1, 0),
                                              child: Center(
                                                  child: SvgPicture.asset(
                                                "assets/images/Non-Veg.svg",
                                                color: menuItemsFiltered[index]
                                                        .is_veg
                                                    ? Colors.green
                                                    : Colors.red,
                                              )),
                                            ),
                                            Expanded(
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Text(
                                                    menuItemsFiltered[index]
                                                        .name,
                                                    style: GoogleFonts.openSans(
                                                        color: Colors.white,
                                                        fontSize: 18.h,
                                                        fontWeight:
                                                            FontWeight.w500),
                                                  ),
                                                  Text(
                                                    "₹${menuItemsFiltered[index].price}",
                                                    style: GoogleFonts.openSans(
                                                        fontSize: 16.h,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        color: const Color
                                                                .fromRGBO(
                                                            100, 100, 100, 1)),
                                                  )
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(right: 37.w),
                                        child: AddButton(
                                          is_available: menuItemsFiltered[index]
                                              .is_available,
                                          isVeg:
                                              menuItemsFiltered[index].is_veg,
                                          menuItemName:
                                              menuItemsFiltered[index].name,
                                          amount: menuItemsAmount[
                                              menuItemsFiltered[index].id]!,
                                          foodStallId: widget.foodStallId,
                                          price: menuItemsFiltered[index].price,
                                          menuItemId:
                                              menuItemsFiltered[index].id,
                                          foodStallName: widget.foodStallName,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
          ValueListenableBuilder(
            valueListenable: Hive.box("cartBox").listenable(),
            builder: (context, Box box, child) {
              int total = MenuScreenViewModel().getTotalValue();
              if (total != 0) {
                return Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => CartScreen()));
                    },
                    child: Container(
                      // alignment: Alignment.bottomCenter,
                      width: MediaQuery.of(context).size.width,
                      height: 56.h,
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(colors: [
                          Color.fromRGBO(209, 154, 8, 1),
                          Color.fromRGBO(254, 212, 102, 1),
                          Color.fromRGBO(227, 186, 79, 1),
                          Color.fromRGBO(209, 154, 8, 1),
                          Color.fromRGBO(209, 154, 8, 1),
                        ]),
                        boxShadow: const [
                          BoxShadow(
                            color: Color.fromRGBO(0, 0, 0, 0.25),
                            blurRadius: 4.38,
                            offset: Offset(0, 4.38),
                          ),
                        ],
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(15.r),
                            topRight: Radius.circular(15.r)),
                      ),
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 40.w),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Text(
                                  'View Cart',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w800,
                                    color: Colors.black,
                                    fontSize: 20.w,
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Text(
                                  '₹ $total',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w700,
                                    color: Colors.black,
                                    fontSize: 19.w,
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              }
              if (!isNotEmpty) {
                return Container();
              } else {
                return Container();
              }
            },
          )
        ]),
      ),
    );
  }
}
