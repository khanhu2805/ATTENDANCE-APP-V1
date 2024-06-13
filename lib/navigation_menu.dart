import 'package:fe_attendance_app/features/main_feature/screens/log/log_screen.dart';
import 'package:fe_attendance_app/features/main_feature/screens/notification/notification_screen.dart';
import 'package:fe_attendance_app/utils/device/device_utility.dart';
import 'package:fe_attendance_app/utils/helpers/helper_functions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
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
        floatingActionButton: FloatingActionButton(
          backgroundColor: isDark ? Colors.blue : Colors.blue[200],
          elevation: 0,
          onPressed: () {
            Get.to(() => const CheckinScreen());
          },
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(50),
          ),
          child: const Icon(Iconsax.scan),
        ),
        bottomNavigationBar: Obx(
          () => BottomAppBar(
            shape: const CircularNotchedRectangle(),
            height: DeviceUtils.getScreenHeight() / 10,
            elevation: 0,
            padding: EdgeInsets.all(4.0),
            color: isDark ? Colors.blue : Colors.blue[200],
            child: IconTheme(
              data: IconThemeData(color: isDark ? Colors.white : Colors.black),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: () => {controller.selectedIndex.value = 0},
                    child: Container(
                      width: DeviceUtils.getScreenWidth() / 6,
                      decoration: BoxDecoration(
                        color: controller.selectedIndex.value == 0
                            ? Colors.black.withOpacity(0.1)
                            : Colors.transparent,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Iconsax.home),
                          Text(
                            'Trang chủ',
                            style: TextStyle(fontSize: 10.0),
                          )
                        ],
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () => {controller.selectedIndex.value = 1},
                    child: Container(
                        width: DeviceUtils.getScreenWidth() / 6,
                        decoration: BoxDecoration(
                          color: controller.selectedIndex.value == 1
                              ? Colors.black.withOpacity(0.1)
                              : Colors.transparent,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Iconsax.calendar),
                              Text(
                                'Lịch sử',
                                style: TextStyle(fontSize: 10.0),
                              )
                            ])),
                  ),
                  Container(
                    width: DeviceUtils.getScreenWidth() / 4,
                    alignment: Alignment.center,
                    child: Text(
                      'Điểm danh',
                      style: TextStyle(fontSize: 10.0),
                    ),
                  ),
                  InkWell(
                    onTap: () => {controller.selectedIndex.value = 2},
                    child: Container(
                        width: DeviceUtils.getScreenWidth() / 6,
                        decoration: BoxDecoration(
                          color: controller.selectedIndex.value == 2
                              ? Colors.black.withOpacity(0.1)
                              : Colors.transparent,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Iconsax.notification),
                              Text(
                                'Thông báo',
                                style: TextStyle(fontSize: 10.0),
                              )
                            ])),
                  ),
                  InkWell(
                    onTap: () => {controller.selectedIndex.value = 3},
                    child: Container(
                        width: DeviceUtils.getScreenWidth() / 6,
                        decoration: BoxDecoration(
                          color: controller.selectedIndex.value == 3
                              ? Colors.black.withOpacity(0.1)
                              : Colors.transparent,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Iconsax.user),
                              Text(
                                'Tài khoản',
                                style: TextStyle(fontSize: 10.0),
                              )
                            ])),
                  ),
                ],
              ),
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
  ];
}
