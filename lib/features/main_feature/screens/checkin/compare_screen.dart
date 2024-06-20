import 'package:fe_attendance_app/features/main_feature/controllers/checkin/camera_controller.dart';
import 'package:fe_attendance_app/features/main_feature/controllers/checkin/checkin_controller.dart';
import 'package:fe_attendance_app/features/main_feature/screens/log/log_screen.dart';
import 'package:fe_attendance_app/navigation_menu.dart';
import 'package:fe_attendance_app/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CompareScreen extends StatefulWidget {
  const CompareScreen({super.key});

  @override
  State<CompareScreen> createState() => _CompareScreenState();
}

class _CompareScreenState extends State<CompareScreen> {
  late CheckinController controller;
  late MyCameraController cameraController;
  late NavigationController navigationController;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller = CheckinController.instance;
    cameraController = MyCameraController.instance;
    navigationController = NavigationController.instance;
  }

  @override
  void dispose() {
    // TODO: implement dispose
    cameraController.cameraController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Obx(
          () => Column(children: [
            Container(
              height: THelperFunctions.screenHeight() * 0.7,
              width: THelperFunctions.screenWidth(),
              child: controller.screen[controller.screenIndex.value],
            ),
            Container(
              margin:
                  EdgeInsets.only(top: THelperFunctions.screenHeight() * 0.05),
              alignment: Alignment.center,
              child: controller.screenIndex.value == 0
                  ? controller.studentCode.value != ''
                      ? controller.studentCode.value != '0'
                          ? Text(
                              'Mã sinh viên: ${controller.studentCode.value}\nVui lòng đưa gương mặt vào khung quy định')
                          : Text('Sinh viên không có trong danh sách lớp')
                      : Text('Vui lòng quét mã vạch trên thẻ sinh viên')
                  : cameraController.loading.value
                      ? CircularProgressIndicator()
                      : cameraController.studentCode.value ==
                              'Không nhận diện được'
                          ? Text('Không nhận diện được')
                          : cameraController.studentCode.value != ''
                              ? cameraController.studentCode.value ==
                                      controller.studentCode.value
                                  ? Text(
                                      'Trùng khớp : ${cameraController.studentCode.value}')
                                  : Text(
                                      'Không trùng khớp\n Mã sinh viên: ${controller.studentCode.value}\nNhận diện: ${cameraController.studentCode.value}')
                              : Text(
                                  'Mã sinh viên: ${controller.studentCode.value}\nVui lòng đưa gương mặt vào khung quy định'),
            ),
            ElevatedButton(
                onPressed: () {
                  navigationController.selectedIndex.value = 1;
                  Get.offAll(() => NavigationMenu());
                },
                child: Text('Kết thúc'))
          ]),
        ),
      ),
    );
  }
}
