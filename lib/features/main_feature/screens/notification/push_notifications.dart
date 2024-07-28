import 'dart:convert';
import 'package:fe_attendance_app/features/main_feature/screens/notification/notification_screen.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
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
  static final GlobalKey<NavigatorState> navigationKey =
      GlobalKey<NavigatorState>();
  static final FlutterLocalNotificationsPlugin
      _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  PushNotifications() {
    _loadNotifications();
  }

  Future<void> _loadNotifications() async {
    final prefs = await SharedPreferences.getInstance();
    final List<String>? notificationStrings =
        prefs.getStringList('notifications');

    if (notificationStrings != null) {
      notifications = notificationStrings
          .map((notificationString) => jsonDecode(notificationString))
          .toList()
          .cast<Map<String, dynamic>>();
    }
  }

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

  static Future<void> saveNotification(
      String title, String body, DateTime time) async {
    final prefs = await SharedPreferences.getInstance();
    final List<String>? notificationStrings =
        prefs.getStringList('notifications');
    if (notificationStrings != null) {
      notifications = notificationStrings
          .map((notificationString) => jsonDecode(notificationString))
          .toList()
          .cast<Map<String, dynamic>>();
    }
    notifications.add({
      'title': title,
      'body': body,
      'time': time.toString()
    }); //Thêm vào danh sách
    await prefs.setStringList(
        'notifications', notifications.map((e) => jsonEncode(e)).toList());
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
    FirebaseMessaging.onBackgroundMessage(_firebaseBackgroundMessage);

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      if (message.notification != null) {
        if (kIsWeb) {
          showNotification(
              title: message.notification!.title!,
              body: message.notification!.body!);
        } else {
          PushNotifications.showSimpleNotification(
            title: message.notification!.title!,
            body: message.notification!.body!,
          );
        }
        saveNotification(message.notification?.title ?? '',
            message.notification?.body ?? '', DateTime.now());
      }
    });

    final RemoteMessage? message =
        await FirebaseMessaging.instance.getInitialMessage();

    if (message != null) {
      navigationKey.currentState!
          .pushNamed(NotificationScreen.route, arguments: message);
      await saveNotification(message.notification?.title ?? '',
          message.notification?.body ?? '', DateTime.now());
    }

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      navigationKey.currentState!
          .pushNamed(NotificationScreen.route, arguments: message);
    });
  }

  static Future localNotiInit() async {
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    const InitializationSettings initializationSettings =
        InitializationSettings(
      android: initializationSettingsAndroid,
    );
    _flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onDidReceiveNotificationResponse: onNotificationTap,
        onDidReceiveBackgroundNotificationResponse: onNotificationTap);
  }

  static Future<void> onNotificationTap(
      NotificationResponse notificationResponse) async {
    RemoteMessage? message = await _getNotificationForLater();
    Get.toNamed(NotificationScreen.route, arguments: message);
  }

  static Future<RemoteMessage?> _getNotificationForLater() async {
    final prefs = await SharedPreferences.getInstance();
    final notificationDataString = prefs.getString('notificationData');
    if (notificationDataString != null) {
      await prefs.remove('notificationData');
      return RemoteMessage.fromMap(jsonDecode(notificationDataString));
    }
    return null;
  }

  static Future showSimpleNotification({
    required String title,
    required String body,
  }) async {
    const AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails('your channel id', 'your channel name',
            channelDescription: 'your channel description',
            importance: Importance.max,
            priority: Priority.high,
            ticker: 'ticker');
    const NotificationDetails notificationDetails =
        NotificationDetails(android: androidNotificationDetails);
    await _flutterLocalNotificationsPlugin.show(
        0, title, body, notificationDetails);
  }
}
