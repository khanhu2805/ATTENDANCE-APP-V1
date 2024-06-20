import 'package:fe_attendance_app/features/main_feature/screens/log/log_screen.dart';
import 'package:fe_attendance_app/features/main_feature/screens/notification/notification_screen.dart';
import 'package:fe_attendance_app/utils/device/device_utility.dart';
import 'package:fe_attendance_app/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'features/main_feature/screens/checkin/checkin_screen.dart';
import 'features/main_feature/screens/home/home_screen.dart';
import 'features/main_feature/screens/profile/profile_screen.dart';

class NavigationMenu extends StatefulWidget {
  const NavigationMenu({ super.key});
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
            gradient: LinearGradient(
              // colors: isDark
              //     ? [Colors.blue, Colors.white]
              //     : [Colors.blue, Colors.],
              colors: [Colors.blue, Colors.white],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: FloatingActionButton(
            onPressed: () {
              controller.selectedIndex.value = 4;
            },
            backgroundColor: Colors.transparent,
            child: Icon(Iconsax.scan),
            elevation: 0,
          ),
        ),
        bottomNavigationBar: Obx(
          () => BottomAppBar(
            shape: const CircularNotchedRectangle(),
            height: DeviceUtils.getScreenHeight() / 10,
            elevation: 0,
            padding: EdgeInsets.all(4.0),
            color: isDark ? Colors.blue : Colors.white,
            child: IconTheme(
              data: IconThemeData(color: isDark ? Colors.white : Colors.black),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: () => {controller.selectedIndex.value = 0},
                    child: Container(
                      width: DeviceUtils.getScreenWidth() / 6,
                      decoration: BoxDecoration(
                        // color: controller.selectedIndex.value == 0
                        //     ? Colors.black.withOpacity(0.1)
                        //     : Colors.transparent,
                        gradient: LinearGradient(
                          colors: controller.selectedIndex.value == 0
                              ? isDark
                                  ? [Colors.blue, Colors.grey]
                                  : [Colors.blue, Colors.white]
                              : [Colors.transparent, Colors.transparent],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Icon(Iconsax.home),
                          Text(
                            'Trang chủ',
                            style: TextStyle(
                                fontSize: DeviceUtils.getScreenWidth() / 40),
                          ),
                        ],
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () => {controller.selectedIndex.value = 1},
                    child: Container(
                        width: DeviceUtils.getScreenWidth() / 6,
                        decoration: BoxDecoration(
                          // color: controller.selectedIndex.value == 0
                          //     ? Colors.black.withOpacity(0.1)
                          //     : Colors.transparent,
                          gradient: LinearGradient(
                            colors: controller.selectedIndex.value == 1
                                ? isDark
                                    ? [Colors.blue, Colors.grey]
                                    : [Colors.blue, Colors.white]
                                : [Colors.transparent, Colors.transparent],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Icon(
                                Iconsax.calendar,
                                color: Colors.grey,
                              ),
                              Text(
                                'Lịch sử',
                                style: TextStyle(
                                    color: Colors.grey,
                                    fontSize:
                                        DeviceUtils.getScreenWidth() / 40),
                              )
                            ])),
                  ),
                  SizedBox(
                    width: 35.0,
                  ),
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
                    onTap: () => {controller.selectedIndex.value = 2},
                    child: Container(
                        width: DeviceUtils.getScreenWidth() / 6,
                        decoration: BoxDecoration(
                          // color: controller.selectedIndex.value == 0
                          //     ? Colors.black.withOpacity(0.1)
                          //     : Colors.transparent,
                          gradient: LinearGradient(
                            colors: controller.selectedIndex.value == 2
                                ? isDark
                                    ? [Colors.blue, Colors.grey]
                                    : [Colors.blue, Colors.yellow]
                                : [Colors.transparent, Colors.transparent],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Icon(Iconsax.notification),
                              Text(
                                'Thông báo',
                                style: TextStyle(
                                    fontSize:
                                        DeviceUtils.getScreenWidth() / 40),
                              )
                            ])),
                  ),
                  InkWell(
                    onTap: () => {controller.selectedIndex.value = 3},
                    child: Container(
                        width: DeviceUtils.getScreenWidth() / 6,
                        decoration: BoxDecoration(
                          // color: controller.selectedIndex.value == 0
                          //     ? Colors.black.withOpacity(0.1)
                          //     : Colors.transparent,
                          gradient: LinearGradient(
                            colors: controller.selectedIndex.value == 3
                                ? isDark
                                    ? [Colors.blue, Colors.grey]
                                    : [Colors.blue, Colors.yellow]
                                : [Colors.transparent, Colors.transparent],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Icon(Iconsax.user),
                              Text(
                                'Tài khoản',
                                style: TextStyle(
                                    fontSize:
                                        DeviceUtils.getScreenWidth() / 40),
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
    const CheckinScreen()
  ];
}
