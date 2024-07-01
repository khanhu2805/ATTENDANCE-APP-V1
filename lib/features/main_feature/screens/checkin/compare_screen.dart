import 'package:fe_attendance_app/features/main_feature/controllers/checkin/face_recognition_controller.dart';
import 'package:fe_attendance_app/features/main_feature/controllers/checkin/checkin_controller.dart';
import 'package:fe_attendance_app/navigation_menu.dart';
import 'package:fe_attendance_app/utils/constants/colors.dart';
import 'package:fe_attendance_app/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CompareScreen extends StatefulWidget {
  const CompareScreen({super.key});

  @override
  State<CompareScreen> createState() => _CompareScreenState();
}

class _CompareScreenState extends State<CompareScreen>
    with SingleTickerProviderStateMixin {
  late CheckinController controller;
  late bool isDark;
  late FaceRecognitionController faceRecognitionController;
  late NavigationController navigationController;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller = CheckinController.instance;
    navigationController = NavigationController.instance;
  }

  @override
  void dispose() {
    // TODO: implement dispose
    faceRecognitionController.cameraController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    isDark = THelperFunctions.isDarkMode(context);
    return SafeArea(
      child: Scaffold(
          bottomSheet: BottomSheet(
            enableDrag: false,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(180.0),
                  topRight: Radius.circular(180.0)),
            ),
            builder: (context) {
              return Container(
                height: THelperFunctions.screenHeight() / 6,
                decoration: BoxDecoration(
                  color: isDark ? AppColors.primaryBackgroundDark : AppColors.primaryBackground,
                  borderRadius: BorderRadius.circular(14.0),
                  border: Border.all(color: isDark ? AppColors.primaryBackgroundDark : Colors.grey), 
                ),
                padding: const EdgeInsets.all(16.0),
                child: SizedBox(
                  height:
                      THelperFunctions.screenHeight() / 6,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Obx(() => Text(
                            controller.screenIndex.value == 0
                                ? 'Vui lòng quét thẻ sinh viên'
                                : 'Mã sinh viên: ${controller.studentCode.value}',
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium
                                ?.copyWith(
                                    fontSize:
                                        THelperFunctions.screenWidth() * 0.038),
                          )),
                      const SizedBox(
                        height: 10.0,
                      ),
                      ElevatedButton(
                        onPressed: () {
                          Get.offAll(() => NavigationMenu(
                                index: 1,
                                id: controller.documentSnapshot?.id,
                              ));
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.secondary,
                        ),
                        child: Text(
                          'Kết thúc ca điểm danh',
                          style: TextStyle(
                              fontSize: THelperFunctions.screenWidth() * 0.04),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
            onClosing: () {},
          ),
          body: Obx(
            () => controller.screen[controller.screenIndex.value],
          )),
    );
  }
}
