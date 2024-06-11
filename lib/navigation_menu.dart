import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:fe_attendance_app/features/action/screens/home/home_screen.dart';
import 'package:fe_attendance_app/features/action/screens/profile/profile_screen.dart';
import 'package:fe_attendance_app/utils/device/device_utility.dart';
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
    final iconList = [Iconsax.home, Iconsax.user];
    final labelList = ['Trang chủ', 'Tài khoản'];
    // return SafeArea(
    //   child: Scaffold(
    //       bottomNavigationBar: Obx(() => NavigationBar(
    //             height: DeviceUtils.getBottomNavigationBarHeight(),
    //             elevation: 0,
    //             selectedIndex: controller.selectedIndex.value,
    //             backgroundColor: isDark ? Colors.blue : Colors.blue[100],
    //             indicatorColor: Colors.black.withOpacity(0.1),
    //             onDestinationSelected: (index) =>
    //                 controller.selectedIndex.value = index,
    //             destinations: const [
    //               NavigationDestination(
    //                   icon: Icon(Iconsax.home), label: 'Trang chủ'),
    //               SizedBox(
    //                 width: 20,
    //                 child: Text('Điểm danh', ),
    //               ),
    //               NavigationDestination(
    //                   icon: Icon(Iconsax.user), label: 'Tài khoản')
    //             ],
    //           )),
    //       floatingActionButtonLocation:
    //           FloatingActionButtonLocation.centerDocked,
    //       floatingActionButton: FloatingActionButton(
    //         backgroundColor: isDark ? Colors.blue : Colors.blue[100],
    //         elevation: 0,
    //         onPressed: () {},
    //         shape: RoundedRectangleBorder(
    //             side: BorderSide(width: 1, color: Colors.black),
    //             borderRadius: BorderRadius.circular(50)),
    //         child: const Icon(Iconsax.scan),
    //       ),
    //       body: Obx(() => controller.screens[controller.selectedIndex.value])),
    // );
    return SafeArea(
      child: Scaffold(
          //destination screen
          floatingActionButton: FloatingActionButton(
            //params
            onPressed: () {
              Get.to(() => const CheckinScreen());
            },
            backgroundColor: isDark ? Colors.blue : Colors.blue[200],
            child: const Icon(Iconsax.scan),
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
          bottomNavigationBar: Obx(() => AnimatedBottomNavigationBar.builder(
              height: DeviceUtils.getBottomNavigationBarHeight(),
              elevation: 0,
              backgroundColor: isDark ? Colors.blue : Colors.blue[200],
              itemCount: iconList.length,
              tabBuilder: (int index, bool isActive) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 40),
                  child: Container(
                    decoration: BoxDecoration(
                      color: isActive
                          ? Colors.black.withOpacity(0.1)
                          : Colors.transparent,
                      borderRadius: BorderRadius.circular(10)
                    ),
                    
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          iconList[index],
                          size: 24,
                        ),
                        Text(labelList[index])
                      ],
                    ),
                  ),
                );

              },
              activeIndex: controller.selectedIndex.value,
              gapLocation: GapLocation.center,
              notchSmoothness: NotchSmoothness.softEdge,
              onTap: (index) => controller.selectedIndex.value = index)),
          body: Obx(() => controller.screens[controller.selectedIndex.value])),
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
