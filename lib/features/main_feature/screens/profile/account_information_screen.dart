import 'package:fe_attendance_app/features/main_feature/controllers/profile/profile_controller.dart';
import 'package:fe_attendance_app/features/main_feature/screens/profile/widgets/appbar_profile.dart';
import 'package:fe_attendance_app/features/main_feature/screens/profile/widgets/infor_screen.dart';
import 'package:fe_attendance_app/utils/constants/text_strings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AccountInfoScreen extends StatefulWidget {
  const AccountInfoScreen({super.key});

  @override
  State<AccountInfoScreen> createState() => _AccountInfoScreen();
}

class _AccountInfoScreen extends State<AccountInfoScreen> {
  late ProfileController controller;

  @override
  void initState() {
    super.initState();
    Get.lazyPut(() => ProfileController());
    controller = Get.find<ProfileController>();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            const TAppBar(
              title: AppTexts.myProfileTitle,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Obx(
                        () => TInforHeaderScreen(
                          displayName: controller.displayName.value,
                          jobTitle: controller.jobTitle.value,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(30),
                        child: Column(
                          children: [
                            Obx(
                              () => TInforScreen(
                                title: 'Tên người dùng',
                                content: controller.displayName.value,
                              ),
                            ),
                            Obx(
                              () => TInforScreen(
                                title: 'Địa chỉ mail',
                                content: controller.mail.value,
                              ),
                            ),
                            Obx(
                              () => TInforScreen(
                                title: 'Khoa',
                                content: controller.jobTitle.value,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
