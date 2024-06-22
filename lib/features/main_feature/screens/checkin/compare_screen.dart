import 'package:fe_attendance_app/features/main_feature/controllers/checkin/face_recognition_controller.dart';
import 'package:fe_attendance_app/features/main_feature/controllers/checkin/checkin_controller.dart';
import 'package:fe_attendance_app/features/main_feature/screens/checkin/face_recognition_screen.dart';
import 'package:fe_attendance_app/features/main_feature/screens/log/log_screen.dart';
import 'package:fe_attendance_app/navigation_menu.dart';
import 'package:fe_attendance_app/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
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
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(180.0),
                  topRight: Radius.circular(180.0)),
            ),
            builder: (context) {
              return Container(
                height: THelperFunctions.screenHeight() / 6, // Adjust as needed
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Vui lòng quét thẻ sinh viên'),
                    SizedBox(
                      height: 10.0,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        navigationController.selectedIndex.value = 1;
                        Get.offAll(() => NavigationMenu());
                      },
                      child: Text(
                        'Kết thúc ca điểm danh',
                        style: Theme.of(context).textTheme.titleMedium,
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
