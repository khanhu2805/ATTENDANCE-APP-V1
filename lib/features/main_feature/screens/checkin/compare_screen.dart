import 'package:fe_attendance_app/features/main_feature/controllers/checkin/face_recognition_controller.dart';
import 'package:fe_attendance_app/features/main_feature/controllers/checkin/checkin_controller.dart';
import 'package:fe_attendance_app/navigation_menu.dart';
import 'package:fe_attendance_app/utils/helpers/helper_functions.dart';
import 'package:flutter/cupertino.dart';
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
              return SizedBox(
                height: THelperFunctions.screenHeight() / 6, // Adjust as needed
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      controller.screenIndex.value == 0
                          ? 'Vui lòng quét thẻ sinh viên'
                          : 'Mã sinh viên: ${controller.studentCode.value}',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontSize: THelperFunctions.screenWidth() * 0.038),
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Get.offAll(() => const NavigationMenu(
                              index: 1,
                            ));
                      },
                      child: Text(
                        'Kết thúc ca điểm danh',
                        style: TextStyle(
                            fontSize: THelperFunctions.screenWidth() * 0.04),
                      ),
                    ),
                  ],
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
