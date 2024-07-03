import 'package:fe_attendance_app/features/authenticiation/controllers/login/microsoft_controller.dart';
import 'package:fe_attendance_app/utils/constants/colors.dart';
import 'package:fe_attendance_app/utils/constants/image_strings.dart';
import 'package:fe_attendance_app/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppSocialButtons extends StatelessWidget {
  const AppSocialButtons({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(MicrosoftControlller());
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          decoration: BoxDecoration(
              border: Border.all(color: AppColors.grey),
              borderRadius: BorderRadius.circular(100)),
          child: IconButton(
            onPressed: () => controller.signInWithMicrosoft(),
            icon: const Image(
              width: AppSizes.iconMd,
              height: AppSizes.iconMd,
              image: AssetImage(AppImages.appLogoMicrosoft),
            ),
          ),
        )
      ],
    );
  }
}
