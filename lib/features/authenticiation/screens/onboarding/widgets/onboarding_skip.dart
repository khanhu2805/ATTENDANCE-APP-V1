import 'package:fe_attendance_app/features/authenticiation/controllers/onboarding/onboarding_controller.dart';
import 'package:flutter/material.dart';

import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/device/device_utility.dart';

class OnBoardingSkip extends StatelessWidget {
  const OnBoardingSkip({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
        top: DeviceUtils.getAppBarHeight(),
        right: AppSizes.defaultSpace,
        child: TextButton(onPressed: () =>OnBoardingController.instance.skipPage(), child: const Text('Bỏ qua')));
  }
}