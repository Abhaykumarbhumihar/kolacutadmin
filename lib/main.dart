import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:kolacur_admin/screen/graph.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'screen/homebottombar.dart';
import 'screen/login.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

 FirebaseMessaging _firebaseMessaging;

const AndroidNotificationChannel channel = AndroidNotificationChannel(
    'high_importance_channel', // id
    'High Importance Notifications', // title
    // 'This channel is used for important notifications.', // description
    importance: Importance.high,
    playSound: true);

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  // print('A bg message just showed up :  ${message.messageId}');
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();
  final String session = prefs.getString('session');
  await Firebase.initializeApp();
  String fcm_token = await FirebaseMessaging.instance.getToken();
  print(fcm_token);
  debugPrint(fcm_token);
  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
      .createNotificationChannel(channel);

  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );

  final FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;
  if (Platform.isIOS) {
    firebaseMessaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );
  }

  FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
      alert: true, badge: true, sound: true);

//   FirebaseMessaging.onMessage.listen((RemoteMessage message) {
//     RemoteNotification notification = message.notification;
//     AndroidNotification android = message.notification.android;
//     print("54566565565656565556 ----UNONPE UNONPE ");
//     print(  message.data["we"]);
//
//     if (notification != null && android != null) {
//       flutterLocalNotificationsPlugin.show(
//           notification.hashCode,
//           notification.title! + "789",
//           notification.body,
//           NotificationDetails(
//             android: AndroidNotificationDetails(
//               channel.id,
//               channel.name,
//               // channel.description,
//               color: Colors.transparent,
//               playSound: true,
//               icon: "mipmap/ic_launcher",
//             ),
//           ));
// /*TODO-- pass rote here*/
//       // _homepage = TwilioPhoneNumberInput();
//     }
//   });
//
//   FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
//     RemoteNotification notification = message.notification;
//     AndroidNotification android = message.notification.android;
//     print(
//         "UNONPE  UNONPE  UNONPE  UNONPE UNONPE UNONPE UNONPE ----UNONPE UNONPE ");
//     print(  message.data["we"]);
//     if (notification != null && android != null) {
//       flutterLocalNotificationsPlugin.show(
//           notification.hashCode,
//           notification.title! + "onMessageOpenedApp",
//           notification.body,
//           NotificationDetails(
//             android: AndroidNotificationDetails(
//               channel.id,
//               channel.name,
//               // channel.description,
//               color: Colors.transparent,
//               playSound: true,
//               icon: "mipmap/ic_launcher",
//             ),
//           ));
// /*TODO-- pass rote here*/
//       // _homepage = TwilioPhoneNumberInput();
//     } /*TODO-- pass rote here*/
//     //  _homepage = TwilioPhoneNumberInput();
//   });
  runApp(MyApp(session: session));
}

class MyApp extends StatelessWidget {
  const MyApp({Key key, this.session}) : super(key: key);
  final String session;

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: session == null ? const LoginPage() : const HomeBottomBar(),
    );
  }
}

