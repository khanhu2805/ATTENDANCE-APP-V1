import 'dart:convert';
import 'package:fe_attendance_app/features/main_feature/screens/notification/app_state_observer.dart';
import 'package:fe_attendance_app/features/main_feature/screens/notification/push_notifications.dart';
import 'package:fe_attendance_app/utils/repository/authentication_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'app.dart';
import 'firebase_options.dart';

final navigationKey = GlobalKey<NavigatorState>();

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
  await Firebase.initializeApp();
  await PushNotifications.init();
  await PushNotifications.localNotiInit();

  final user = FirebaseAuth.instance.currentUser;
  if (user != null) {
    final uid = user.uid;
    print('User UID: $uid');
    await FirebaseMessaging.instance.subscribeToTopic(uid);
  } else {
    print('No user is currently signed in.');
  }
  
  PushNotifications().initializePushNotifications();
  RemoteMessage? initialMessage = await _getNotificationForLater();
  WidgetsBinding.instance.addObserver(AppStateObserver());
  runApp(
    App(initialMessage: initialMessage),
  );

  runApp(const App());
}


