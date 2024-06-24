import 'package:fe_attendance_app/features/main_feature/screens/log/log_screen.dart';
import 'package:fe_attendance_app/features/main_feature/screens/notification/notification_screen.dart';
import 'package:fe_attendance_app/utils/constants/colors.dart';
import 'package:fe_attendance_app/utils/device/device_utility.dart';
import 'package:fe_attendance_app/utils/helpers/helper_functions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'features/main_feature/screens/checkin/checkin_screen.dart';
import 'features/main_feature/screens/home/home_screen.dart';
import 'features/main_feature/screens/profile/profile_screen.dart';

class NavigationMenu extends StatefulWidget {
  const NavigationMenu({super.key});
  @override
  State<NavigationMenu> createState() => _NavigationMenuState();
}

class _NavigationMenuState extends State<NavigationMenu> {
  late NavigationController controller;
  late bool isDark;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller = Get.put(NavigationController());
  }

  @override
  Widget build(BuildContext context) {
    isDark = THelperFunctions.isDarkMode(context);
    return SafeArea(
      child: Scaffold(
        body: Obx(
          () => controller.screens[controller.selectedIndex.value],
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
                color: AppColors.secondary,
                width: 3.0,
                strokeAlign: BorderSide.strokeAlignOutside),
            gradient: const LinearGradient(
              colors: [AppColors.accent, AppColors.primary],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: ElevatedButton(
            onPressed: () {
              controller.selectedIndex.value = 4;
            },
            style: ButtonStyle(
              elevation: MaterialStateProperty.all(0.0),
              overlayColor: MaterialStateProperty.all(Colors.transparent),
              backgroundColor: MaterialStateProperty.all(Colors.transparent),
              side: MaterialStateProperty.all(BorderSide.none),
            ),
            child: const Icon(Iconsax.scan),
          ),
        ),
        bottomNavigationBar: Obx(
          () => Container(
            margin:
                const EdgeInsets.only(left: 12.0, right: 12.0, bottom: 20.0),
            height: THelperFunctions.screenHeight() / 12,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100.0),
                color: AppColors.secondary),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                InkWell(
                  overlayColor: MaterialStateProperty.all(Colors.transparent),
                  onTap: () => {controller.selectedIndex.value = 0},
                  child: SizedBox(
                    // width: DeviceUtils.getScreenWidth() / 6,
                    // decoration: BoxDecoration(
                    //   // color: controller.selectedIndex.value == 0
                    //   //     ? Colors.black.withOpacity(0.1)
                    //   //     : Colors.transparent,
                    //   gradient: LinearGradient(
                    //     colors: controller.selectedIndex.value == 0
                    //         ? isDark
                    //             ? [Colors.blue, Colors.grey]
                    //             : [Colors.blue, Colors.white]
                    //         : [Colors.transparent, Colors.transparent],
                    //     begin: Alignment.topLeft,
                    //     end: Alignment.bottomRight,
                    //   ),
                    //   borderRadius: BorderRadius.circular(10),
                    // ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Icon(
                          Iconsax.home,
                          color: controller.selectedIndex.value == 0
                              ? AppColors.primary
                              : AppColors.primaryBackground,
                        ),
                        Text(
                          'Trang chủ',
                          style: TextStyle(
                              color: controller.selectedIndex.value == 0
                                  ? AppColors.primary
                                  : AppColors.primaryBackground,
                              fontSize: DeviceUtils.getScreenWidth() / 40),
                        ),
                      ],
                    ),
                  ),
                ),
                InkWell(
                  overlayColor: MaterialStateProperty.all(Colors.transparent),
                  onTap: () => {controller.selectedIndex.value = 1},
                  child: SizedBox(
                      // width: DeviceUtils.getScreenWidth() / 6,
                      // decoration: BoxDecoration(
                      //   // color: controller.selectedIndex.value == 0
                      //   //     ? Colors.black.withOpacity(0.1)
                      //   //     : Colors.transparent,
                      //   gradient: LinearGradient(
                      //     colors: controller.selectedIndex.value == 1
                      //         ? isDark
                      //             ? [Colors.blue, Colors.grey]
                      //             : [Colors.blue, Colors.white]
                      //         : [Colors.transparent, Colors.transparent],
                      //     begin: Alignment.topLeft,
                      //     end: Alignment.bottomRight,
                      //   ),
                      //   borderRadius: BorderRadius.circular(10),
                      // ),
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                        Icon(
                          Iconsax.calendar,
                          color: controller.selectedIndex.value == 1
                              ? AppColors.primary
                              : AppColors.primaryBackground,
                        ),
                        Text(
                          'Lịch sử',
                          style: TextStyle(
                              color: controller.selectedIndex.value == 1
                                  ? AppColors.primary
                                  : AppColors.primaryBackground,
                              fontSize: DeviceUtils.getScreenWidth() / 40),
                        )
                      ])),
                ),
                SizedBox(width: THelperFunctions.screenWidth() / 20),
                // Container(
                //   width: DeviceUtils.getScreenWidth() / 4,
                //   alignment: Alignment.bottomCenter,
                //   margin: EdgeInsets.only(),
                //   child: Text(
                //     'Điểm danh',
                //     style: TextStyle(
                //         fontSize: DeviceUtils.getScreenWidth() / 40),
                //   ),
                // ),
                InkWell(
                  overlayColor: MaterialStateProperty.all(Colors.transparent),
                  onTap: () => {controller.selectedIndex.value = 2},
                  child: SizedBox(
                      // width: DeviceUtils.getScreenWidth() / 6,
                      // decoration: BoxDecoration(
                      //   // color: controller.selectedIndex.value == 0
                      //   //     ? Colors.black.withOpacity(0.1)
                      //   //     : Colors.transparent,
                      //   gradient: LinearGradient(
                      //     colors: controller.selectedIndex.value == 2
                      //         ? isDark
                      //             ? [Colors.blue, Colors.grey]
                      //             : [Colors.blue, Colors.yellow]
                      //         : [Colors.transparent, Colors.transparent],
                      //     begin: Alignment.topLeft,
                      //     end: Alignment.bottomRight,
                      //   ),
                      //   borderRadius: BorderRadius.circular(10),
                      // ),
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                        Icon(
                          Iconsax.notification,
                          color: controller.selectedIndex.value == 2
                              ? AppColors.primary
                              : AppColors.primaryBackground,
                        ),
                        Text(
                          'Thông báo',
                          style: TextStyle(
                              color: controller.selectedIndex.value == 2
                                  ? AppColors.primary
                                  : AppColors.primaryBackground,
                              fontSize: DeviceUtils.getScreenWidth() / 40),
                        )
                      ])),
                ),
                InkWell(
                  overlayColor: MaterialStateProperty.all(Colors.transparent),
                  onTap: () => {controller.selectedIndex.value = 3},
                  child: SizedBox(
                      // width: DeviceUtils.getScreenWidth() / 6,
                      // decoration: BoxDecoration(
                      //   // color: controller.selectedIndex.value == 0
                      //   //     ? Colors.black.withOpacity(0.1)
                      //   //     : Colors.transparent,
                      //   gradient: LinearGradient(
                      //     colors: controller.selectedIndex.value == 3
                      //         ? isDark
                      //             ? [Colors.blue, Colors.grey]
                      //             : [Colors.blue, Colors.yellow]
                      //         : [Colors.transparent, Colors.transparent],
                      //     begin: Alignment.topLeft,
                      //     end: Alignment.bottomRight,
                      //   ),
                      //   borderRadius: BorderRadius.circular(10),
                      // ),
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                        Icon(
                          Iconsax.user,
                          color: controller.selectedIndex.value == 3
                              ? AppColors.primary
                              : AppColors.primaryBackground,
                        ),
                        Text(
                          'Tài khoản',
                          style: TextStyle(
                              color: controller.selectedIndex.value == 3
                                  ? AppColors.primary
                                  : AppColors.primaryBackground,
                              fontSize: DeviceUtils.getScreenWidth() / 40),
                        )
                      ])),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class NavigationController extends GetxController {
  static NavigationController get instance => Get.find();
  final Rx<int> selectedIndex = 0.obs;
  final List<Widget> screens = [
    const HomeScreen(),
    const LogScreen(),
    const NotificationScreeen(),
    const ProfileScreen(),
    const CheckinScreen()
  ];
}
