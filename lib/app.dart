import 'package:fe_attendance_app/features/authenticiation/screens/onboarding/onboarding.dart';
import 'package:fe_attendance_app/navigation_menu.dart';
import 'package:fe_attendance_app/utils/device/web_material_scroll.dart';
import 'package:fe_attendance_app/utils/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'features/authenticiation/screens/login/login.dart';
import 'features/main_feature/screens/home/home_screen.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      themeMode: ThemeMode.system,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      debugShowCheckedModeBanner: false,
      scrollBehavior: MyCustomScrollBehavior(),
      home: FutureBuilder<bool>(
        future: SharedPreferences.getInstance().then((prefs) => prefs.getBool('rememberMe') ?? false),
        builder: (context, snapshot) {
          return snapshot.data == true ? NavigationMenu() : LoginScreen();
        },
      ),
    );
  }
}