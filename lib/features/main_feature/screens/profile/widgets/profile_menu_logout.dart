import 'package:fe_attendance_app/features/main_feature/controllers/profile/profile_controller.dart';
import 'package:fe_attendance_app/utils/constants/colors.dart';
import 'package:fe_attendance_app/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class TProfileMenuLogout extends StatelessWidget {
  const TProfileMenuLogout({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    bool isDark = THelperFunctions.isDarkMode(context);
    return ListTile(
      leading: Container(
        padding: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          color: isDark
                ? AppColors.iconProfileLogout.withOpacity(0.5)
                : AppColors.iconProfileLogout.withOpacity(0.2),
          shape: BoxShape.circle,
        ),
        child: const Icon(Iconsax.logout4, color: AppColors.iconProfileLogout),
      ),
      title: Text(
        'Đăng xuất',
        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontSize: THelperFunctions.screenWidth() * 0.045,
                  color: AppColors.iconProfileLogout
                ),
      ),
      onTap: () {
        Get.put(ProfileController()).logout();
      },
    );
  }
}
