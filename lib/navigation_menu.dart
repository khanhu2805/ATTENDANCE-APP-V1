import 'package:fe_attendance_app/features/main_feature/screens/log/log_screen.dart';
import 'package:fe_attendance_app/features/main_feature/screens/notification/notification_screen.dart';
import 'package:fe_attendance_app/features/main_feature/screens/profile/account_information_screen.dart';
import 'package:fe_attendance_app/features/main_feature/screens/profile/privacy_policy_screen.dart';
import 'package:fe_attendance_app/features/main_feature/screens/profile/terms_conditon_screen.dart';
import 'package:fe_attendance_app/utils/constants/colors.dart';
import 'package:fe_attendance_app/utils/device/device_utility.dart';
import 'package:fe_attendance_app/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'features/main_feature/screens/checkin/checkin_screen.dart';
import 'features/main_feature/screens/home/home_screen.dart';
import 'features/main_feature/screens/profile/profile_screen.dart';

class NavigationMenu extends StatefulWidget {
  const NavigationMenu({super.key, this.index});
  final int? index;
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
    controller.selectedIndex.value = widget.index ?? 0;
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
            margin: EdgeInsets.only(
              bottom: THelperFunctions.screenHeight() / 30,
              left: THelperFunctions.screenWidth() / 20,
              right: THelperFunctions.screenWidth() / 20,
            ),
            height: THelperFunctions.screenHeight() / 15,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100.0),
                color: AppColors.secondary),
            child: Row(
              children: [
                Expanded(
                  flex: 3,
                  child: InkWell(
                    overlayColor: MaterialStateProperty.all(Colors.transparent),
                    onTap: () => {controller.selectedIndex.value = 0},
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(
                          controller.selectedIndex.value == 0
                              ? Iconsax.home_25
                              : Iconsax.home_24,
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
                              fontSize: DeviceUtils.getScreenWidth() / 30),
                        ),
                      ],
                    ),
                  ),
                ),
                const Expanded(flex: 2, child: SizedBox()),
                Expanded(
                  flex: 3,
                  child: InkWell(
                    overlayColor: MaterialStateProperty.all(Colors.transparent),
                    onTap: () => {controller.selectedIndex.value = 3},
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Icon(
                          controller.selectedIndex.value == 3
                              ? Iconsax.profile_circle5
                              : Iconsax.profile_circle4,
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
                              fontSize: DeviceUtils.getScreenWidth() / 30),
                        )
                      ],
                    ),
                  ),
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
    const CheckinScreen(),
    const AccountInfoScreen(),//5
    const PrivacyPolicyScreen(),//6
    const TermsConditionScreen(),//7
  ];
}
