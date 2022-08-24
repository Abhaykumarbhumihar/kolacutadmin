// import 'dart:async';
// import 'dart:io';
//
// import 'package:firebase_core/firebase_core.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// import 'package:get/get.dart';
// import 'package:get_storage/get_storage.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:untitled/controller/home_controller.dart';
// import 'package:untitled/model/ProfilePojo.dart';
// import 'package:untitled/screen/HomeScreen.dart';
// import 'package:untitled/screen/coin.dart';
// import 'package:untitled/screen/homebottombar.dart';
// import 'package:untitled/screen/homepage.dart';
// import 'package:untitled/screen/login.dart';
// import 'package:untitled/screen/orderdetail.dart';
// import 'package:untitled/screen/profile.dart';
// import 'package:untitled/screen/register.dart';
// import 'package:untitled/screen/saloondetail.dart';
// import 'package:untitled/screen/userprofile.dart';
// import 'package:untitled/screen/verifyOtp.dart';
// import 'package:untitled/screen/wishlish.dart';
// import 'package:untitled/screen/yourbooking.dart';
// import 'package:untitled/utils/CommomDialog.dart';
//
// late FirebaseMessaging _firebaseMessaging;
//
// const AndroidNotificationChannel channel = AndroidNotificationChannel(
//     'high_importance_channel', // id
//     'High Importance Notifications', // title
//     // 'This channel is used for important notifications.', // description
//     importance: Importance.high,
//     playSound: true);
//
// final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
// FlutterLocalNotificationsPlugin();
//
// Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
//   await Firebase.initializeApp();
//   // print('A bg message just showed up :  ${message.messageId}');
// }
//
// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//
//   await Firebase.initializeApp();
//   String? fcm_token = await FirebaseMessaging.instance.getToken();
//   print(fcm_token);
//   debugPrint(fcm_token);
//   await flutterLocalNotificationsPlugin
//       .resolvePlatformSpecificImplementation<
//       AndroidFlutterLocalNotificationsPlugin>()
//       ?.createNotificationChannel(channel);
//
//   await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
//     alert: true,
//     badge: true,
//     sound: true,
//   );
//
//   final FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;
//   if (Platform.isIOS) {
//     firebaseMessaging.requestPermission(
//       alert: true,
//       announcement: false,
//       badge: true,
//       carPlay: false,
//       criticalAlert: false,
//       provisional: false,
//       sound: true,
//     );
//   }
//
//   FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
//       alert: true, badge: true, sound: true);
//
//   FirebaseMessaging.onMessage.listen((RemoteMessage message) {
//     RemoteNotification? notification = message.notification;
//     AndroidNotification? android = message.notification?.android;
//     print("54566565565656565556 ----UNONPE UNONPE ");
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
//     RemoteNotification? notification = message.notification;
//     AndroidNotification? android = message.notification?.android;
//     print(
//         "UNONPE  UNONPE  UNONPE  UNONPE UNONPE UNONPE UNONPE ----UNONPE UNONPE ");
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
//   runApp(MyApp(""));
// }
//
// class MyApp extends StatefulWidget {
//   var session;
//
//   MyApp(String session) {
//     this.session = session;
//   }
//
//   @override
//   State<MyApp> createState() => _MyAppState(session);
// }
//
// class _MyAppState extends State<MyApp> {
//   var session;
//
//   // _MyAppState({Key? key, this.session}) : super(key: key);
//   _MyAppState(String session) {
//     //this.session = session;
//   }
//
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//
//     notification();
//   }
//
//   notification() async {
//     await FirebaseMessaging.instance
//         .setForegroundNotificationPresentationOptions(
//       alert: true,
//       badge: true,
//       sound: true,
//     );
//
//     final FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;
//     if (Platform.isIOS) {
//       firebaseMessaging.requestPermission(
//         alert: true,
//         announcement: false,
//         badge: true,
//         carPlay: false,
//         criticalAlert: false,
//         provisional: false,
//         sound: true,
//       );
//     }
//
//     FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
//         alert: true, badge: true, sound: true);
//
//     FirebaseMessaging.onMessage.listen((RemoteMessage message) {
//       RemoteNotification? notification = message.notification;
//       AndroidNotification? android = message.notification?.android;
//       print("54566565565656565556 ----UNONPE UNONPE ");
//       if (notification != null && android != null) {
//         flutterLocalNotificationsPlugin.show(
//             notification.hashCode,
//             notification.title! + "789",
//             notification.body,
//             NotificationDetails(
//               android: AndroidNotificationDetails(
//                 channel.id,
//                 channel.name,
//                 // channel.description,
//                 color: Colors.transparent,
//                 playSound: true,
//                 icon: "mipmap/ic_launcher",
//               ),
//             ));
// /*TODO-- pass rote here*/
//         // _homepage = TwilioPhoneNumberInput();
//       }
//     });
//
//     FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
//       RemoteNotification? notification = message.notification;
//       AndroidNotification? android = message.notification?.android;
//       print(
//           "UNONPE  UNONPE  UNONPE  UNONPE UNONPE UNONPE UNONPE ----UNONPE UNONPE ");
//       if (notification != null && android != null) {
//         flutterLocalNotificationsPlugin.show(
//             notification.hashCode,
//             notification.title! + "onMessageOpenedApp",
//             notification.body,
//             NotificationDetails(
//               android: AndroidNotificationDetails(
//                 channel.id,
//                 channel.name,
//                 // channel.description,
//                 color: Colors.transparent,
//                 playSound: true,
//                 icon: "mipmap/ic_launcher",
//               ),
//             ));
// /*TODO-- pass rote here*/
//         // _homepage = TwilioPhoneNumberInput();
//       } /*TODO-- pass rote here*/
//       //  _homepage = TwilioPhoneNumberInput();
//     });
//   }
//   Future<String?> get getStringValues async
//   {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     String? stringValue = prefs.getString('session');
//     return stringValue;
//   }
//
//
//
//   @override
//   Widget build(BuildContext context) {
//     print(getStringValues);
//     print("ON BUILD");
//     return GetMaterialApp(
//       debugShowCheckedModeBanner: false,
//       home:getStringValues== null ? const LoginPage() : const MainPage(),
//     );
//   }
// }
//
// // class MyApp extends StatelessWidget {
// //
// //   const MyApp({Key? key, this.session}) : super(key: key);
// //   final String? session;
// //
// //
// //   @override
// //
// //   Widget build(BuildContext context) {
// //     print(session);
// //     if(session!=null){
// //       Get.put<HomeController>(HomeController());
// //     }
// //     return GetMaterialApp(
// //       debugShowCheckedModeBanner: false,
// //       home: session == null ? const LoginPage() : const MainPage(),
// //     );
// //   }
// // }
// // void main() {
// //   runApp(MyApp());
// // }
// //
// // class MyApp extends StatelessWidget {
// //   var box = GetStorage();
// //
// //
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     // late var a;
// //     // if (box.read('session') == null) {
// //     //   print(box.read("session"));
// //     //   a = LoginPage();
// //     // } else {
// //     //   print(box.read("session"));
// //     //   a = MainPage();
// //     // }
// //     //
// //     // return GetMaterialApp(debugShowCheckedModeBanner: false, home: LoginPage());
// //     var box = GetStorage();
// //     String? session;
// //     Future.delayed(const Duration(seconds: 5), () {
// //       session = http://box.read('session');
// //     });
// //
// //     return GetMaterialApp(
// //       debugShowCheckedModeBanner: false,
// //       home: session == null ? const LoginPage() : const MainPage(),
// //     );
// //   }
// // }
