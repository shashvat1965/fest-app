import 'package:chucker_flutter/chucker_flutter.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:oasis_2022/screens/events/repository/model/miscEventResult.dart';
import 'package:oasis_2022/screens/events/view/miscellaneous_screen.dart';
import 'package:oasis_2022/screens/food_stalls/view/food_stall_screen.dart';
import 'package:oasis_2022/screens/onboarding/overboarding_page.dart';

import '../home.dart';
import '../provider/user_details_viewmodel.dart';
import '../screens/food_stalls/repo/model/hive_model/hive_menu_entry.dart';
import '../screens/login/view/login_screen.dart';
import '../screens/quiz/view/leaderboard/leaderboard.dart';
import '../screens/wallet_screen/view/wallet_screen.dart';
import 'firebase_options.dart';
import 'notificationservice/local_notification_service.dart';
import 'screens/food_stalls/repo/model/food_stall_model.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations(
    [DeviceOrientation.portraitUp],
  );
  ChuckerFlutter.showOnRelease = false;
  print('initialising hive');
  await Hive.initFlutter();

  Hive.registerAdapter(HiveMenuEntryAdapter());
  Hive.registerAdapter(MiscEventListAdapter());
  Hive.registerAdapter(MiscEventDataAdapter());
  Hive.registerAdapter(FoodStallAdapter());
  Hive.registerAdapter(MenuItemAdapter());
  Hive.registerAdapter(FoodStallListAdapter());
  await Hive.openBox<MiscEventList>('miscEventListBox');
  await Hive.openBox('subscribeBox');
  await Hive.openBox('firstRun');
  await Hive.openBox('cartBox');
  await Hive.openBox<FoodStallList>('foodStallBox');
  print('initialised hive');
  print('initialising firebase');
  await Firebase.initializeApp(
      name: 'oasis', options: DefaultFirebaseOptions.currentPlatform);
  await FirebaseMessaging.instance.subscribeToTopic('all');
  print('initialising firebase');
  print('crashylitics');
  FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterFatalError;
  print('notification');
  FirebaseMessaging.onMessage.listen(
    (message) {
      print(message.data.toString() + "             lol");
      if (message.data != null) {
        print(message.data['title']);
        print(message.data['body']);

        LocalNotificationService.createanddisplaynotification(message);
      }
      if (message.notification != null) {
        print(message.notification!.title);
        print(message.notification!.body);
        // print("message.data22 ${message.data['_id']}");
        LocalNotificationService.createanddisplaynotification(message);
      }
    },
  );
  LocalNotificationService.initialize();

  runApp(RestartWidget(child: OasisFestApp()));
}

class RestartWidget extends StatefulWidget {
  RestartWidget({required this.child});

  final Widget child;

  static void restartApp(BuildContext context) {
    context.findAncestorStateOfType<_RestartWidgetState>()?.restartApp();
  }

  @override
  _RestartWidgetState createState() => _RestartWidgetState();
}

class _RestartWidgetState extends State<RestartWidget> {
  Key key = UniqueKey();

  void restartApp() {
    setState(() {
      key = UniqueKey();
    });
  }

  @override
  Widget build(BuildContext context) {
    return KeyedSubtree(
      key: key,
      child: widget.child,
    );
  }
}

class OasisFestApp extends StatefulWidget {
  const OasisFestApp({Key? key}) : super(key: key);

  @override
  State<OasisFestApp> createState() => _OasisFestAppState();
}

class _OasisFestAppState extends State<OasisFestApp> {
  UserDetailsViewModel userDetailsViewModel = UserDetailsViewModel();

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(428, 926),
        //minTextAdapt: true,
        // splitScreenMode: true,
        builder: (context, child) {
          return MaterialApp(
            theme: ThemeData(scaffoldBackgroundColor: Colors.black),
            navigatorObservers: [ChuckerFlutter.navigatorObserver],
            routes: {
              'food_stalls': (context) => FoodStallScreen(),
              'login': (context) => LoginScreen(),
              'wallet': (context) => WalletScreen(),
              'home': (context) => HomeScreen(),
              'leaderboard': (context) => Leaderboard(),
            },
            home: FutureBuilder(
              future: userDetailsViewModel.userCheck(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  if (Hive.box('firstRun').isEmpty) {
                    Future.microtask(
                        () => Navigator.of(context).pushAndRemoveUntil(
                              MaterialPageRoute(
                                  builder: (builder) => (UserDetailsViewModel
                                              .userDetails.userID ==
                                          "7644")
                                      ? const LoginScreen()
                                      : const OnBoardingPage()),
                              (route) => false,
                            ));
                  } else {
                    Future.microtask(
                        () => Navigator.of(context).pushAndRemoveUntil(
                              MaterialPageRoute(
                                  builder: (builder) => (UserDetailsViewModel
                                              .userDetails.userID ==
                                          "7644")
                                      ? const EventsScreen()
                                      : const HomeScreen()),
                              (route) => false,
                            ));
                  }
                }
                return Container(
                  height: double.infinity,
                  width: double.infinity,
                  alignment: Alignment.center,
                  color: Colors.black,
                  child: Image.asset('assets/images/OASISLogoGoldPNG.png'),
                );
              },
            ),
          );
        });
  }
}
