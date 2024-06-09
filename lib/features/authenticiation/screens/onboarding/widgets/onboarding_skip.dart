import 'package:fe_attendance_app/features/authenticiation/controllers/onboarding/onboarding_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/device/device_utility.dart';
import '../../login/login.dart';

class OnBoardingSkip extends StatelessWidget {
  const OnBoardingSkip({
    super.key,
  });

  void _handleSkip(BuildContext context) {
    OnBoardingController.instance.skipPage();

    Get.offAll(() => const LoginScreen());
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
        top: DeviceUtils.getAppBarHeight(),
        right: AppSizes.defaultSpace,
        child: TextButton(onPressed: () => _handleSkip(context), child: const Text('Bỏ qua')));
  }
}