import 'package:fe_attendance_app/features/action/screens/home/home_screen.dart';
import 'package:fe_attendance_app/features/action/screens/profile/profile_screen.dart';
import 'package:fe_attendance_app/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import 'features/action/screens/checkin/checkin_screen.dart';

class NavigationMenu extends StatelessWidget {
  const NavigationMenu({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(NavigationController());
    final isDark = THelperFunctions.isDarkMode(context);
    return SafeArea(
      child: Scaffold(
        body: Obx(
          () => controller.screens[controller.selectedIndex.value],
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: FloatingActionButton(
          backgroundColor: isDark ? Colors.blue : Colors.blue[200],
          elevation: 0,
          onPressed: () {Get.to(() => const CheckinScreen());},
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(50),
          ),
          child: const Icon(Iconsax.scan),
        ),
        bottomNavigationBar: Obx(
          () => BottomAppBar(
            shape: const CircularNotchedRectangle(),
            // height: DeviceUtils.getBottomNavigationBarHeight(),
            elevation: 0,
            color: isDark ? Colors.blue : Colors.blue[200],
            child: IconTheme(
              data: IconThemeData(color: isDark ? Colors.white : Colors.black),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  InkWell(
                    onTap: () => {controller.selectedIndex.value = 0},
                    child: Container(
                      padding: const EdgeInsets.all(6.0),
                      decoration: BoxDecoration(
                        color: controller.selectedIndex.value == 0
                            ? Colors.black.withOpacity(0.1)
                            : Colors.transparent,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Column(
                        children: [Icon(Iconsax.home), Text('Trang chủ')],
                      ),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsetsDirectional.only(top: 25),
                    child: Text('Điểm danh'),
                  ),
                  InkWell(
                    onTap: () => {controller.selectedIndex.value = 1},
                    child: Container(
                        padding: const EdgeInsets.all(6.0),
                        decoration: BoxDecoration(
                          color: controller.selectedIndex.value == 1
                              ? Colors.black.withOpacity(0.1)
                              : Colors.transparent,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Column(
                            children: [Icon(Iconsax.user), Text('Tài khoản')])),
                  )
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
  final Rx<int> selectedIndex = 0.obs;
  final List<StatelessWidget> screens = [
    const HomeScreen(),
    const ProfileScreen(),
    const CheckinScreen()
  ];
}
