import 'package:fe_attendance_app/common/widgets/loaders/animation_loader.dart';
import 'package:fe_attendance_app/features/main_feature/controllers/checkin/face_recognition_controller.dart';
import 'package:fe_attendance_app/features/main_feature/screens/checkin/compare_screen.dart';
import 'package:fe_attendance_app/utils/constants/image_strings.dart';
import 'package:fe_attendance_app/utils/formatters/formatter.dart';
import 'package:fe_attendance_app/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gmt/gmt.dart';
import '../../controllers/checkin/checkin_controller.dart';

class CheckinScreen extends StatefulWidget {
  const CheckinScreen({super.key});

  @override
  State<CheckinScreen> createState() => _CheckinScreenState();
}

class _CheckinScreenState extends State<CheckinScreen> {
  late CheckinController controller;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller = Get.put(CheckinController());
    controller.getClassInfo();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Obx(() => !controller.loading.value
            ? controller.documentSnapshot != null
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                        TAnimationLoaderWidget(
                          text: '',
                          animation: AppImages.pencilAnimation,
                          height: THelperFunctions.screenHeight() / 5,
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: THelperFunctions.screenWidth() / 15),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Mã LHP:',
                                    style:
                                        Theme.of(context).textTheme.bodyMedium,
                                  ),
                                  Text(controller.documentSnapshot!.id,
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                      )),
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Tên HP:',
                                    style:
                                        Theme.of(context).textTheme.bodyMedium,
                                  ),
                                  Text(controller.documentSnapshot!
                                      .get('name_of_class')),
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Ngày bắt đầu HP: ',
                                    style:
                                        Theme.of(context).textTheme.bodyMedium,
                                  ),
                                  Text(AppFormatter.formatDate(controller
                                      .documentSnapshot!
                                      .get('start_date')
                                      .toDate())),
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Ngày kết thúc HP: ',
                                    style:
                                        Theme.of(context).textTheme.bodyMedium,
                                  ),
                                  Text(AppFormatter.formatDate(controller
                                      .documentSnapshot!
                                      .get('end_date')
                                      .toDate())),
                                ],
                              ),
                              Padding(
                                  padding: EdgeInsets.symmetric(
                                      vertical:
                                          THelperFunctions.screenHeight() / 15),
                                  child: Text(
                                      'BUỔI ${AppFormatter.numberOfWeek(controller.documentSnapshot!.get('start_date').toDate(), controller.dateTime)} - ${AppFormatter.formatDate(controller.dateTime)}')),
                              Text(controller.checkin ? 'Checkin' : 'Checkout'),
                            ],
                          ),
                        ),
                        OutlinedButton(
                            onPressed: () {
                              // Get.to(() => CompareScreen());
                              controller.startCheckin();
                            },
                            child: Text(
                              'Bắt đầu',
                              style: Theme.of(context).textTheme.bodyMedium,
                            ))
                      ])
                : TAnimationLoaderWidget(
                    text: 'Chưa tới ca điểm danh\nVui lòng quay lại sau',
                    animation: AppImages.searchAnimation)
            : Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const CircularProgressIndicator(
                      color: Colors.blue,
                    ),
                    Text(
                      'Lấy thông tin ...',
                      style: Theme.of(context).textTheme.bodyMedium,
                    )
                  ],
                ),
              )),
      ),
    );
  }
}
