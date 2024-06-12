import 'package:fe_attendance_app/features/authenticiation/controllers/onboarding/onboarding_controller.dart';
import 'package:fe_attendance_app/features/authenticiation/screens/onboarding/widgets/onboarding_dot_navigation.dart';
import 'package:fe_attendance_app/features/authenticiation/screens/onboarding/widgets/onboarding_next_button.dart';
import 'package:fe_attendance_app/features/authenticiation/screens/onboarding/widgets/onboarding_page.dart';
import 'package:fe_attendance_app/features/authenticiation/screens/onboarding/widgets/onboarding_skip.dart';
import 'package:fe_attendance_app/utils/constants/image_strings.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OnBoardingScreeen extends StatelessWidget {
  const OnBoardingScreeen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(OnBoardingController());
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              const OnBoardingSkip(),
              Expanded(
                child: PageView(
                  controller: controller.pageController,
                  onPageChanged: controller.updatePageIndicator,
                  children: const [
                    OnBoardingPage(
                        image: AppImages.onBoardingImage1,
                        title: 'Nhận diện gương mặt',
                        subTitle:
                            'Tính năng điểm danh bằng nhận diện gương mặt đem lại độ chính xác cao'),
                    OnBoardingPage(
                        image: AppImages.onBoardingImage2,
                        title: 'Lịch sử điểm danh',
                        subTitle:
                            'Xem trực tiếp lịch sử điểm danh với độ trực quan cao'),
                    OnBoardingPage(
                        image: AppImages.onBoardingImage3,
                        title: 'Xuất file điểm danh',
                        subTitle:
                            'Hỗ trợ xuất file điểm danh phục vụ cho nhu cầu của giảng viên')
                  ],
                ),
              ),
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  OnBoardingDotNavigation(),
                  OnBoardingNextButton(),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

