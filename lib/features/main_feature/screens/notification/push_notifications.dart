import 'dart:convert';
import 'package:fe_attendance_app/features/main_feature/screens/notification/notification_screen.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future _firebaseBackgroundMessage(RemoteMessage message) async {
    if (message.notification != null) {
      if (kDebugMode) {
        print("Some notification Received");
      }
    }
  }

class PushNotifications {
  static final _firebaseMessaging = FirebaseMessaging.instance;
  static List<Map<String, dynamic>> notifications = [];
  static final GlobalKey<NavigatorState> navigationKey = GlobalKey<NavigatorState>();

  PushNotifications() {
    _loadNotifications(); 
  }
  
  Future<void> _loadNotifications() async {
    final prefs = await SharedPreferences.getInstance();
    final List<String>? notificationStrings = prefs.getStringList('notifications');

    if (notificationStrings != null) {
      notifications = notificationStrings
          .map((notificationString) => jsonDecode(notificationString))
          .toList()
          .cast<Map<String, dynamic>>();
    }
  }

  static final FlutterLocalNotificationsPlugin
      _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
  static Future init() async {
    await _firebaseMessaging.requestPermission(
      alert: true,
      announcement: true,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    getFCMToken();
  }

  static Future<void> _saveNotification(
      String title, String body, DateTime time) async {
    final prefs = await SharedPreferences
        .getInstance(); 
    notifications.add({
      'title': title,
      'body': body,
      'time': time.toString()
    });
    await prefs.setStringList(
        'notifications',
        notifications
            .map((e) => jsonEncode(e))
            .toList()); 
  }

  void showNotification({required String title, required String body}) {
    showDialog(
      context: navigationKey.currentContext!,
      builder: (context) => AlertDialog(
        title: Text(title),
        content: Text(body),
        actions: [
          TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text("Ok"))
        ],
      ),
    );
  }

  static Future getFCMToken({int maxRetires = 3}) async {
    try {
      String? token;
      if (kIsWeb) {
        token = await _firebaseMessaging.getToken();
        if (kDebugMode) {
          print("for android device token: $token");
        }
      }
      return token;
    } catch (e) {
      if (kDebugMode) {
        print("failed to get device token");
      }
      if (maxRetires > 0) {
        if (kDebugMode) {
          print("try after 10 sec");
        }
        await Future.delayed(const Duration(seconds: 10));
        return getFCMToken(maxRetires: maxRetires - 1);
      } else {
        return null;
      }
    }
  }

  Future<void> initializePushNotifications() async {
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      if (message.notification != null) {
        if (kDebugMode) {
          print("Background Notification Tapped");
        }
        navigationKey.currentState!
            .pushNamed(NotificationScreen.route, arguments: message);
      }
    });

    PushNotifications.init();
    if (!kIsWeb) {
      PushNotifications.localNotiInit();
    }
    FirebaseMessaging.onBackgroundMessage(_firebaseBackgroundMessage);

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      String payloadData = jsonEncode(message.data);
      if (kDebugMode) {
        print("Got a message in foreground");
      }
      if (message.notification != null) {
        if (kIsWeb) {
          showNotification(
              title: message.notification!.title!,
              body: message.notification!.body!);
        } else {
          PushNotifications.showSimpleNotification(
              title: message.notification!.title!,
              body: message.notification!.body!,
              payload: payloadData);
        }
        if (message.notification != null) {
          _saveNotification(message.notification?.title ?? '',
              message.notification?.body ?? '', DateTime.now());
        }
      }
    });

    final RemoteMessage? message =
        await FirebaseMessaging.instance.getInitialMessage();

    if (message != null) {
      if (kDebugMode) {
        print("Launched from terminated state");
      }
      Future.delayed(const Duration(seconds: 10), () {
        navigationKey.currentState!
            .pushNamed(NotificationScreen.route, arguments: message);
      });
      await _saveNotification(
          message.notification?.title ?? '',
          message.notification?.body ?? '',
          DateTime.now());

      navigationKey.currentState!.pushNamed(
        NotificationScreen.route,
        arguments: null,
      ); 
    }
  }

  static Future localNotiInit() async {
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');
   
    const InitializationSettings initializationSettings =
        InitializationSettings(
            android: initializationSettingsAndroid,);
    _flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onDidReceiveNotificationResponse: onNotificationTap,
        onDidReceiveBackgroundNotificationResponse: onNotificationTap);
  }

  static void onNotificationTap(NotificationResponse notificationResponse) {
    Get.toNamed(NotificationScreen.route, arguments: notificationResponse);
  }

  static Future showSimpleNotification({
    required String title,
    required String body,
    required String payload,
  }) async {
    const AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails('your channel id', 'your channel name',
            channelDescription: 'your channel description',
            importance: Importance.max,
            priority: Priority.high,
            ticker: 'ticker');
    const NotificationDetails notificationDetails =
        NotificationDetails(android: androidNotificationDetails);
    await _flutterLocalNotificationsPlugin
        .show(0, title, body, notificationDetails, payload: payload);
  }
}
