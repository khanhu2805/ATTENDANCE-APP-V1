import 'package:fe_attendance_app/features/authenticiation/screens/onboarding/onboarding.dart';
import 'package:fe_attendance_app/utils/device/web_material_scroll.dart';
import 'package:fe_attendance_app/utils/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'features/authenticiation/screens/login/login.dart';

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
      home: const LoginScreen(),    );
  }
}