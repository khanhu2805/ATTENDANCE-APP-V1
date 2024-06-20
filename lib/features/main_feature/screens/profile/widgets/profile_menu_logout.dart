import 'package:fe_attendance_app/features/main_feature/controllers/profile/profile_controller.dart';
import 'package:fe_attendance_app/utils/constants/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:iconsax/iconsax.dart';

class TProfileMenuLogout extends StatelessWidget {
  const TProfileMenuLogout({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Container(
        padding: const EdgeInsets.all(8.0),
        decoration: const BoxDecoration(
          color: AppColors.bkIconProfileLogout,
          shape: BoxShape.circle,
        ),
        child: const Icon(Iconsax.logout4, color: AppColors.iconProfileLogout),
      ),
      title: const Text(
        'Đăng xuất',
        style: TextStyle(color: AppColors.iconProfileLogout),
      ),
      onTap: () {
        Get.put(ProfileController()).logout();
      },
    );
  }
}
