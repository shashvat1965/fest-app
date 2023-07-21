// ignore_for_file: avoid_print
import '../notificationservice/local_notification_service.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class Notifications extends StatefulWidget {
  const Notifications({Key? key}) : super(key: key);

  @override
  State<Notifications> createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {
  @override
  void initState() {
    super.initState();

    FirebaseMessaging.instance.getInitialMessage().then((message) {
      print("FirebaseMessaging.instance.getInitialMessage");

      if (message != null) {
        print("New Notification");
        //   if (message.data['_id'] != null) {
        //     Navigator.of(context).push(
        //       MaterialPageRoute(
        //         builder: (context) => LoginScreen(

        //         ),
        //       ),
        //     );
        //   }
        // }
      }
      ;
    });

    FirebaseMessaging.onMessage.listen(
      (message) {
        print(message.data.toString() + "             lol");
        if (message.data != null) {
          print(message.data['title']);
          print(message.data['body']);

          LocalNotificationService.createanddisplaynotification(message);
        }
      },
    );

    FirebaseMessaging.onMessageOpenedApp.listen(
      (message) {
        print("FirebaseMessaging.onMessageOpenedApp.listen");
        if (message.notification != null) {
          print(message.notification!.title);
          print(message.notification!.body);
          print("message.data22 ${message.data['_id']}");
          LocalNotificationService.createanddisplaynotification(message);
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: Column(
      children: [
        const Text(
          'loks fjJASLFJKl',
          style: TextStyle(color: Colors.black, fontSize: 34),
        ),
        ElevatedButton(
            onPressed: () async {
              await FirebaseMessaging.instance.subscribeToTopic('all');
              print('subscribed');
            },
            child: const Text('subscribe')),
        ElevatedButton(
            onPressed: () async {
              await FirebaseMessaging.instance.unsubscribeFromTopic('all');
            },
            child: const Text('unsubscribe'))
      ],
    )));
  }
}
