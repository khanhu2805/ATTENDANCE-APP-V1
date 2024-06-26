import 'package:fe_attendance_app/features/main_feature/screens/profile/account_information_screen.dart';
import 'package:fe_attendance_app/features/main_feature/screens/profile/privacy_policy_screen.dart';
import 'package:fe_attendance_app/features/main_feature/screens/profile/terms_conditon_screen.dart';
import 'package:fe_attendance_app/features/main_feature/screens/profile/widgets/profile_header.dart';
import 'package:fe_attendance_app/features/main_feature/screens/profile/widgets/profile_menu_logout.dart';
import 'package:fe_attendance_app/features/main_feature/screens/profile/widgets/profile_menu_title.dart';
import 'package:fe_attendance_app/utils/constants/text_strings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
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
                      Get.to(const AccountInfoScreen());
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
                      Get.to(const TermsConditionScreen());
                    },
                  ),
                  TProfileMenuTitle(
                    icon: Iconsax.shield_tick,
                    title: AppTexts.privacyPolicyTitle,
                    onTap: () {
                      Get.to(const PrivacyPolicyScreen());
                    },
                  ),
                  const TProfileMenuLogout(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
