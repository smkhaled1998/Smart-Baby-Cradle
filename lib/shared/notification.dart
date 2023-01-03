// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// import 'package:rxdart/rxdart.dart';
//
// class NotificationApi {
//   static final _notification = FlutterLocalNotificationsPlugin();
//   static final onNotifications = BehaviorSubject<String?>;
//
//   static Future _notificationDetails() async {
//     return NotificationDetails(
//       android: AndroidNotificationDetails(
//           'channel id',
//           'channel name',
//           channelDescription: 'channel descrption',
//           importance: Importance.max),
//       // iOS: IOSNotificationDetails()
//     );
//   }
//
//   static Future init({bool initScheduled = false}) async {
//     final android = AndroidInitializationSettings("@mipmap/ic_launcher");
//     final setting = InitializationSettings(android: android);
//     await _notification.initialize(
//       setting,
//       onDidReceiveBackgroundNotificationResponse: (payload) async {},
//     );
//   }
//
//   static Future showNotification({
//     int id = 0,
//     String? title,
//     String? body,
//     String? payload,
//   }) async {
//     return _notification.show(id, title, body, await _notificationDetails(),
//         payload: payload);
//   }
// }
// import 'package:flutter/material.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
//
// ///**********************************************
// class Firebase_Messaging extends StatefulWidget {
//   const Firebase_Messaging({Key? key}) : super(key: key);
//
//   @override
//   State<Firebase_Messaging> createState() => _Firebase_MessagingState();
// }
//
// class _Firebase_MessagingState extends State<Firebase_Messaging> {
//
//
//   final FirebaseMessaging _firebaseMessaging= FirebaseMessaging.instance;
//
//
//   @override
//   void initState(){
//
//   }
//   @override
//   Widget build(BuildContext context) {
//     return Container();
//
// }

import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class Noti{

  static Future initialize(FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin) async {

    var androidInitialize = const AndroidInitializationSettings('mipmap/ic_launcher');
    var initializationsSettings = InitializationSettings(android: androidInitialize);

    await flutterLocalNotificationsPlugin.initialize(initializationsSettings );
  }

  static Future showBigTextNotification({var id =0,required String title, required String body,
    var payload, required FlutterLocalNotificationsPlugin fln
  } ) async {
    AndroidNotificationDetails androidPlatformChannelSpecifics =
    const AndroidNotificationDetails(
      'you_can_name_it_whatever1',
      'channel_name',

      playSound: true,
     // sound: RawResourceAndroidNotificationSound('notification'),
      importance: Importance.max,
      priority: Priority.high,
    );

    var not= NotificationDetails(android: androidPlatformChannelSpecifics,
    );
    await fln.show(0, title, body,not );
  }

}
