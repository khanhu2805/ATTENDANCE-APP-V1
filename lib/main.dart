import 'dart:convert';
import 'package:fe_attendance_app/features/main_feature/screens/notification/notification_screen.dart';
import 'package:fe_attendance_app/features/main_feature/screens/notification/push_notifications.dart';
import 'package:fe_attendance_app/utils/repository/authentication_repository.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'app.dart';
import 'firebase_options.dart';

final navigationKey = GlobalKey<NavigatorState>();

Future<void> _firebaseBackgroundMessage(RemoteMessage message) async {
  // Store the notification data temporarily (e.g., in SharedPreferences)
  await _saveNotificationForLater(message);
}

Future<void> _saveNotificationForLater(RemoteMessage message) async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setString('notificationData', jsonEncode(message.data));
}

Future<RemoteMessage?> _getNotificationForLater() async {
  final prefs = await SharedPreferences.getInstance();
  final notificationDataString = prefs.getString('notificationData');
  if (notificationDataString != null) {
    await prefs.remove('notificationData');
    return RemoteMessage.fromMap(jsonDecode(notificationDataString));
  }
  return null;
}

Future<void> main() async {
  final WidgetsBinding widgetsBinding =
      WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  final prefs = await SharedPreferences.getInstance();
  final rememberMe = prefs.getBool('rememberMe') ?? false;

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform)
      .then((FirebaseApp value) => Get.put(AuthenticationRepository()));

  if (!rememberMe) {
    await AuthenticationRepository.instance.logout();
  }

  //Notification
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await PushNotifications.init();
  await PushNotifications.localNotiInit();
  PushNotifications().initializePushNotifications();
  // Retrieve the stored notification data, if any
  RemoteMessage? initialMessage = await _getNotificationForLater();
  WidgetsBinding.instance.addObserver(AppStateObserver());
  runApp(
    App(initialMessage: initialMessage),
  );

  runApp(const App());
}

class AppStateObserver extends WidgetsBindingObserver {
  static List<Map<String, dynamic>> notifications = [];
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      // Kiểm tra xem ứng dụng có được mở từ thông báo hay không
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
  static Future<void> saveNotification(
      String title, String body, DateTime time) async {
    final prefs = await SharedPreferences.getInstance();
    notifications.add({'title': title, 'body': body, 'time': time.toString()});
    await prefs.setStringList(
        'notifications', notifications.map((e) => jsonEncode(e)).toList());
  }
}
