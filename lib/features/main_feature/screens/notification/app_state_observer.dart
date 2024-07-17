import 'dart:convert';

import 'package:fe_attendance_app/features/main_feature/screens/notification/notification_screen.dart';
import 'package:fe_attendance_app/main.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppStateObserver extends WidgetsBindingObserver {
  static List<Map<String, dynamic>> notifications = [];
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      _loadNotifications(); 
      FirebaseMessaging.instance.getInitialMessage().then((message) async {
        if (message != null) {
          await saveNotification(message.notification?.title ?? '',
              message.notification?.body ?? '', DateTime.now());
          navigationKey.currentState
              ?.pushNamed(NotificationScreen.route, arguments: message);
        }
      });
    }
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

  static Future<void> saveNotification(String title, String body, DateTime time) async {
    final prefs = await SharedPreferences.getInstance();
    final List<String>? notificationStrings = prefs.getStringList('notifications');
    if (notificationStrings != null) {
      notifications = notificationStrings
          .map((notificationString) => jsonDecode(notificationString))
          .toList()
          .cast<Map<String, dynamic>>();
    }
    notifications.add({'title': title, 'body': body, 'time': time.toString()}); //Thêm vào danh sách
    await prefs.setStringList(
        'notifications', notifications.map((e) => jsonEncode(e)).toList());
  }

}