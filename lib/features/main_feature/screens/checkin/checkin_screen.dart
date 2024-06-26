import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fe_attendance_app/common/widgets/loaders/animation_loader.dart';
import 'package:fe_attendance_app/utils/constants/image_strings.dart';
import 'package:fe_attendance_app/utils/formatters/formatter.dart';
import 'package:fe_attendance_app/utils/helpers/helper_functions.dart';
import 'package:fe_attendance_app/utils/popups/loaders.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
            alignment: Alignment.center,
            child: StreamBuilder<QueryDocumentSnapshot<Map<String, dynamic>>?>(
              stream: controller.getClassInfo(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  if (snapshot.hasData) {
                    return Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'CA ĐIỂM DANH',
                            style: Theme.of(context)
                                .textTheme
                                .titleLarge
                                ?.copyWith(
                                    fontSize:
                                        THelperFunctions.screenWidth() * 0.05),
                          ),
                          TAnimationLoaderWidget(
                              height: THelperFunctions.screenHeight() / 4,
                              text: '',
                              animation: AppImages.docerAnimation),
                          Text(
                            snapshot.data!
                                .get('name_of_class')
                                .toString()
                                .toUpperCase(),
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium
                                ?.copyWith(
                                    fontSize:
                                        THelperFunctions.screenWidth() * 0.04),
                          ),
                          Text(
                            snapshot.data!.id.toString(),
                            style: Theme.of(context)
                                .textTheme
                                .titleSmall
                                ?.copyWith(
                                    fontSize:
                                        THelperFunctions.screenWidth() * 0.04),
                          ),
                          Text(
                            '${snapshot.data?.get('start_hour')} - ${snapshot.data?.get('end_hour')}',
                            style: Theme.of(context)
                                .textTheme
                                .titleSmall
                                ?.copyWith(
                                    fontSize:
                                        THelperFunctions.screenWidth() * 0.04),
                          ),
                          SizedBox(
                            height: THelperFunctions.screenHeight() / 10,
                          ),
                          OutlinedButton(
                              onPressed: () => {controller.startCheckin()},
                              child: Text(controller.checkin
                                  ? 'Check in'
                                  : 'Check out'))
                        ]);
                  }
                  return TAnimationLoaderWidget(
                      text: 'Hiện tại chưa có ca điểm danh',
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          fontSize: THelperFunctions.screenWidth() * 0.045),
                      animation: AppImages.byeAnimation);
                }
                return AppLoaders.showCircularLoader();
              },
            )),
      ),
    );
  }
}
