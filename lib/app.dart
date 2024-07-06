import 'package:fe_attendance_app/common/widgets/loaders/animation_loader.dart';
import 'package:fe_attendance_app/features/main_feature/screens/notification/notification_screen.dart';
import 'package:fe_attendance_app/main.dart';
import 'package:fe_attendance_app/utils/constants/colors.dart';
import 'package:fe_attendance_app/utils/constants/image_strings.dart';
import 'package:fe_attendance_app/utils/device/web_material_scroll.dart';
import 'package:fe_attendance_app/utils/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

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
      home: Container(
        color: AppColors.primaryBackground,
        child: TAnimationLoaderWidget(
          animation: AppImages.docerAnimation,
          text: '',
        ),
      ),
      navigatorKey: navigationKey,
      routes: {
        NotificationScreeen.route: (context) => const NotificationScreeen(),
      },
    );
  }
}
