import 'package:fe_attendance_app/features/authenticiation/screens/login/login.dart';
import 'package:fe_attendance_app/utils/repository/authentication_repository.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'app.dart';
import 'firebase_options.dart';
import 'navigation_menu.dart';

Future<void> main()async{

  final WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  final prefs = await SharedPreferences.getInstance();
  final rememberMe = prefs.getBool('rememberMe') ?? false;

  await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform
  ).then(
          (FirebaseApp value) => Get.put(AuthenticationRepository())
  );

  if (!rememberMe) {
    await AuthenticationRepository.instance.logout();
  }

  runApp(const App());
}

