import 'package:fe_attendance_app/features/authenticiation/controllers/onboarding/onboarding_controller.dart';
import 'package:fe_attendance_app/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
    return TextButton(
      onPressed: () => _handleSkip(context),
      style: ButtonStyle(
          overlayColor: MaterialStateProperty.all(Colors.transparent)),
      child: Text(
        'Bỏ qua',
        style: Theme.of(context)
            .textTheme
            .titleLarge
            ?.copyWith(fontSize: THelperFunctions.screenWidth() * 0.04),
      ),
    );
  }
}
