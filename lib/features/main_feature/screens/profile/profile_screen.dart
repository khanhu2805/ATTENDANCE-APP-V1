import 'package:fe_attendance_app/features/main_feature/screens/profile/account_information_screen.dart';
import 'package:fe_attendance_app/features/main_feature/screens/profile/widgets/profile_header.dart';
import 'package:fe_attendance_app/features/main_feature/screens/profile/widgets/profile_menu_logout.dart';
import 'package:fe_attendance_app/features/main_feature/screens/profile/widgets/profile_menu_title.dart';
import 'package:fe_attendance_app/utils/constants/colors.dart';
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
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const TProfileHeader(),
                const SizedBox(height: 10),
                const Divider(
                    color: AppColors.darkGrey,
                    thickness: 0.5,
                    indent: 5,
                    endIndent: 5),
                const SizedBox(height: 10),
                TProfileMenuTitle(
                  icon: Iconsax.frame_1,
                  title: AppTexts.myProfileTitle,
                  onTap: () {
                    Get.to(const AccountInfoScreen());
                  },
                ),
                const SizedBox(height: 20),
                TProfileMenuTitle(
                  icon: Iconsax.setting,
                  title: AppTexts.settingTitle,
                  onTap: () {},
                ),
                const SizedBox(height: 20),
                TProfileMenuTitle(
                  icon: Iconsax.receipt_2_1,
                  title: AppTexts.termsTitle,
                  onTap: () {},
                ),
                const SizedBox(height: 20),
                TProfileMenuTitle(
                  icon: Iconsax.shield_tick,
                  title: AppTexts.privacyPolicyTitle,
                  onTap: () {},
                ),
                const SizedBox(height: 20),
                const TProfileMenuLogout(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
