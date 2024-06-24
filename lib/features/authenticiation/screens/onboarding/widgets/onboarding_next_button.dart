import 'package:fe_attendance_app/features/authenticiation/controllers/onboarding/onboarding_controller.dart';
import 'package:fe_attendance_app/utils/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';


class OnBoardingNextButton extends StatelessWidget {
  const OnBoardingNextButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
          onPressed: () => OnBoardingController.instance.nextPage(),
          style: ElevatedButton.styleFrom(
      shape: const CircleBorder(),
      backgroundColor: AppColors.secondary,
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0)),
          child: const Icon(Iconsax.arrow_right_3),
        );
  }
}
