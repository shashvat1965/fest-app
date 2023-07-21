import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:oasis_2022/screens/events/view/miscellaneous_screen.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

import '../provider/user_details_viewmodel.dart';
import '../screens/food_stalls/view/food_stall_screen.dart';
import '../screens/tickets/view/store_screen.dart';
import '../screens/wallet_screen/view/wallet_screen.dart';
import '../utils/ui_utils.dart';
import 'order/order_screen.dart';
import 'widgets/loader.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isLoading = true;

  Future<void> loadUserDetails() async {
    await UserDetailsViewModel().loadDetails();
    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    if (UserDetailsViewModel.userDetails.JWT == null) {
      loadUserDetails();
    } else {
      setState(() {
        isLoading = false;
      });
    }
    super.initState();
  }

  final PersistentTabController _controller =
      PersistentTabController(initialIndex: 2);

  List<Widget> _buildScreens() {
    return [
      const FoodStallScreen(),
      const OrdersScreen(),
      const EventsScreen(),
      const StoreScreen(),
      const WalletScreen(),
    ];
  }

  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      PersistentBottomNavBarItem(
        icon: SvgPicture.asset("assets/images/navbar_icons/burger_active.svg"),
        inactiveIcon:
        SvgPicture.asset("assets/images/navbar_icons/burger_inactive.svg"),
        iconSize: 22.r,
      ),
      PersistentBottomNavBarItem(
        icon: SvgPicture.asset("assets/images/navbar_icons/order_active.svg"),
        inactiveIcon:
            SvgPicture.asset("assets/images/navbar_icons/order_inactive.svg"),
        iconSize: 22.r,
      ),
      PersistentBottomNavBarItem(
        icon: SvgPicture.asset("assets/images/navbar_icons/events_active.svg"),
        inactiveIcon:
            SvgPicture.asset("assets/images/navbar_icons/events_inactive.svg"),
        iconSize: 22.r,
      ),
      PersistentBottomNavBarItem(
        icon: Image.asset("assets/images/navbar_icons/stalls_active.png"),
        inactiveIcon:
            SvgPicture.asset("assets/images/navbar_icons/stall_inactive.svg"),
        iconSize: 22.r,
      ),
      PersistentBottomNavBarItem(
        icon: SvgPicture.asset("assets/images/navbar_icons/wallet_active.svg"),
        inactiveIcon:
            SvgPicture.asset("assets/images/navbar_icons/wallet_inactive.svg"),
        iconSize: 22.r,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    UIUtills().updateScreenDimesion(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height);
    return isLoading
        ? Loader()
        : PersistentTabView(
            context,
            controller: _controller,
            screens: _buildScreens(),
            items: _navBarsItems(),
            confineInSafeArea: true,
            backgroundColor: Colors.black,
            stateManagement: true,
            handleAndroidBackButtonPress: true,
            resizeToAvoidBottomInset: true,
            hideNavigationBarWhenKeyboardShows: true,
            popActionScreens: PopActionScreensType.all,
            itemAnimationProperties: const ItemAnimationProperties(
              duration: Duration(milliseconds: 200),
              curve: Curves.ease,
            ),
            screenTransitionAnimation: const ScreenTransitionAnimation(
              animateTabTransition: true,
              curve: Curves.ease,
              duration: Duration(milliseconds: 200),
            ),
            navBarStyle: NavBarStyle.style12,
          );
  }
}
