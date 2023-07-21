// import '../config.dart';
// import '../screens/matches/view/scoresScreenUI/scoresScreen.dart';
// import '../utils/ui_utils.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
//
// class TestScreen extends StatefulWidget {
//   const TestScreen({Key? key}) : super(key: key);
//
//   @override
//   State<TestScreen> createState() => _TestScreenState();
// }
//
// class _TestScreenState extends State<TestScreen> {
//   final PersistentTabController _controller =
//       PersistentTabController(initialIndex: 0);
//   var testScreen = ScoresScreen(sportName: 'Badminton', sportId: 1);
//
//   //change here
//   List<Widget> _buildScreens() {
//     return [testScreen, testScreen];
//   }
//
//   List<PersistentBottomNavBarItem> _navBarsItems() {
//     return [
//       PersistentBottomNavBarItem(
//         icon: const Icon(Icons.fastfood),
//         activeColorPrimary: Colors.black,
//         iconSize: 43,
//       ),
//       PersistentBottomNavBarItem(
//         icon: const Icon(Icons.fastfood),
//         activeColorPrimary: Colors.black,
//         iconSize: 43,
//       ),
//     ];
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     UIUtills().updateScreenDimesion(
//         width: MediaQuery.of(context).size.width,
//         height: MediaQuery.of(context).size.height);
//     return VIEW_NAV_BAR
//         ? PersistentTabView(
//             context,
//             controller: _controller,
//             screens: _buildScreens(),
//             items: _navBarsItems(),
//             confineInSafeArea: true,
//             backgroundColor: Colors.white,
//             stateManagement: true,
//             handleAndroidBackButtonPress: true,
//             resizeToAvoidBottomInset: true,
//             hideNavigationBarWhenKeyboardShows: true,
//             // decoration: NavBarDecoration(
//             //   borderRadius: BorderRadius.circular(10.0),
//             //   colorBehindNavBar: navBarColor,
//             // ),
//             popAllScreensOnTapOfSelectedTab: true,
//             popActionScreens: PopActionScreensType.all,
//             itemAnimationProperties: const ItemAnimationProperties(
//               duration: Duration(milliseconds: 200),
//               curve: Curves.ease,
//             ),
//             screenTransitionAnimation: const ScreenTransitionAnimation(
//               animateTabTransition: true,
//               curve: Curves.ease,
//               duration: Duration(milliseconds: 500),
//             ),
//             navBarStyle: NavBarStyle.style6,
//           )
//         : testScreen;
//   }
// }
