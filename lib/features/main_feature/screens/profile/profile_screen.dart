
import 'package:fe_attendance_app/features/main_feature/screens/profile/widgets/profile_header.dart';
import 'package:fe_attendance_app/features/main_feature/screens/profile/widgets/profile_menu_logout.dart';
import 'package:fe_attendance_app/features/main_feature/screens/profile/widgets/profile_menu_title.dart';
import 'package:fe_attendance_app/navigation_menu.dart';
import 'package:fe_attendance_app/utils/constants/text_strings.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late NavigationController navigationController;

  @override
  void initState() {
    navigationController = NavigationController.instance;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const TProfileHeader(),
              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    TProfileMenuTitle(
                      icon: Iconsax.frame_1,
                      title: AppTexts.myProfileTitle,
                      onTap: () {
                        navigationController.selectedIndex.value = 5;
                      },
                    ),
                    TProfileMenuTitle(
                      icon: Iconsax.setting,
                      title: AppTexts.settingTitle,
                      onTap: () {},
                    ),
                    TProfileMenuTitle(
                      icon: Iconsax.receipt_2_1,
                      title: AppTexts.termsTitle,
                      onTap: () {
                        navigationController.selectedIndex.value = 7;
                      },
                    ),
                    TProfileMenuTitle(
                      icon: Iconsax.shield_tick,
                      title: AppTexts.privacyPolicyTitle,
                      onTap: () {
                        navigationController.selectedIndex.value = 6;
                      },
                    ),
                    const TProfileMenuLogout(),
                  ],
                ),
              ),
            ],
          
          ),
        ),
      ),
    );
  }
}
