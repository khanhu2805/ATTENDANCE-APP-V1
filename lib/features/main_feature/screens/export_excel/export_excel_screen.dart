import 'package:fe_attendance_app/features/main_feature/controllers/export_excel/export_excel_controller.dart';
import 'package:fe_attendance_app/utils/constants/colors.dart';
import 'package:fe_attendance_app/utils/helpers/helper_functions.dart';
import 'package:fe_attendance_app/utils/popups/loaders.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class ExportExcelScreen extends StatefulWidget {
  const ExportExcelScreen({super.key});

  @override
  State<ExportExcelScreen> createState() => _ExportExcelScreenState();
}

class _ExportExcelScreenState extends State<ExportExcelScreen> {
  late ExportExcelController controller;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller = Get.put(ExportExcelController());
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            alignment: Alignment.center,
            margin: EdgeInsets.symmetric(
                vertical: THelperFunctions.screenHeight() / 20,
                horizontal: THelperFunctions.screenWidth() / 30),
            child: Column(
              children: [
                Text(
                  'Xuất file điểm danh'.toUpperCase(),
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontSize: THelperFunctions.screenWidth() * 0.05),
                ),
                SizedBox(
                  height: THelperFunctions.screenHeight() * 0.01,
                ),
                Text(
                  '(Vui lòng chọn lớp học phần muốn xuất file điểm danh)',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      fontSize: THelperFunctions.screenWidth() * 0.03),
                ),
                SizedBox(
                  height: THelperFunctions.screenHeight() / 25,
                ),
                FutureBuilder(
                  future: controller.getClass(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      if (snapshot.hasData) {
                        return Column(
                          children: [
                            // Row(
                            //   children: [
                            //     Expanded(
                            //       flex: 1,
                            //       child: Text(
                            //         'Mã lớp học phần:',
                            //         style: Theme.of(context)
                            //             .textTheme
                            //             .bodyMedium
                            //             ?.copyWith(
                            //                 fontSize:
                            //                     THelperFunctions.screenWidth() *
                            //                         0.035),
                            //       ),
                            //     ),
                            //     Expanded(
                            //       flex: 1,
                            //       child: Text(
                            //         '${snapshot.data?.id}',
                            //         textAlign: TextAlign.left,
                            //         style: Theme.of(context)
                            //             .textTheme
                            //             .titleMedium
                            //             ?.copyWith(
                            //                 fontSize:
                            //                     THelperFunctions.screenWidth() *
                            //                         0.04),
                            //       ),
                            //     )
                            //   ],
                            // ),

                            // Row(
                            //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            //   children: [
                            //     Expanded(
                            //       flex: 1,
                            //       child: Text(
                            //         'Tên lớp học phần:',
                            //         style: Theme.of(context)
                            //             .textTheme
                            //             .bodyMedium
                            //             ?.copyWith(
                            //                 fontSize:
                            //                     THelperFunctions.screenWidth() *
                            //                         0.035),
                            //       ),
                            //     ),
                            //     Expanded(
                            //       flex: 1,
                            //       child: Text(
                            //         '${snapshot.data?.get('name_of_class')}',
                            //         textAlign: TextAlign.left,
                            //         style: Theme.of(context)
                            //             .textTheme
                            //             .titleMedium
                            //             ?.copyWith(
                            //                 fontSize:
                            //                     THelperFunctions.screenWidth() *
                            //                         0.04),
                            //       ),
                            //     )
                            //   ],
                            // ),
                            // SizedBox(
                            //   height: THelperFunctions.screenHeight() / 20,
                            // ),
                            DropdownMenu<String>(
                              inputDecorationTheme: InputDecorationTheme(
                                constraints: BoxConstraints(
                                  maxHeight:
                                      THelperFunctions.screenHeight() / 12,
                                ),
                              ),
                              textStyle: Theme.of(context)
                                  .textTheme
                                  .titleSmall
                                  ?.copyWith(
                                      fontSize: THelperFunctions.screenWidth() *
                                          0.04),
                              menuStyle: MenuStyle(
                                  backgroundColor: MaterialStateProperty.all(
                                      AppColors.white),
                                  surfaceTintColor: MaterialStateProperty.all(
                                      AppColors.white)),
                              initialSelection: snapshot.data!.first,
                              leadingIcon: const Icon(Iconsax.book),
                              label: Text(
                                'Lớp học phần',
                                style: TextStyle(
                                    fontSize:
                                        THelperFunctions.screenWidth() * 0.045),
                              ),
                              width: THelperFunctions.screenWidth() * 0.8,
                              onSelected: (String? value) {
                                controller.selected =
                                    value!.split('-')[0].removeAllWhitespace;
                              },
                              dropdownMenuEntries: snapshot.data!
                                  .map<DropdownMenuEntry<String>>(
                                      (String value) {
                                return DropdownMenuEntry<String>(
                                    value: value,
                                    label: value,
                                    style: ButtonStyle(
                                        foregroundColor:
                                            MaterialStateProperty.all(
                                                AppColors.secondary)));
                              }).toList(),
                            ),
                            SizedBox(
                              height: THelperFunctions.screenHeight() / 25,
                            ),
                            // DropdownMenu<String>(
                            //   inputDecorationTheme: InputDecorationTheme(
                            //     constraints: BoxConstraints(
                            //       maxHeight: THelperFunctions.screenHeight() / 12,
                            //     ),
                            //   ),
                            //   textStyle: Theme.of(context)
                            //       .textTheme
                            //       .titleSmall
                            //       ?.copyWith(
                            //           fontSize:
                            //               THelperFunctions.screenWidth() * 0.04),
                            //   menuStyle: MenuStyle(
                            //       backgroundColor:
                            //           MaterialStateProperty.all(AppColors.white),
                            //       surfaceTintColor:
                            //           MaterialStateProperty.all(AppColors.white)),
                            //   initialSelection: controller.check == 'check_in'
                            //       ? 'Checkin'
                            //       : 'Checkout',
                            //   leadingIcon: const Icon(Iconsax.calendar),
                            //   label: Text(
                            //     'Checkin/ Checkout',
                            //     style: TextStyle(
                            //         fontSize:
                            //             THelperFunctions.screenWidth() * 0.045),
                            //   ),
                            //   width: THelperFunctions.screenWidth() * 0.8,
                            //   onSelected: (String? value) {
                            //     controller.check =
                            //         value == 'Checkin' ? 'check_in' : 'check_out';
                            //   },
                            //   dropdownMenuEntries: ['Checkin', 'Checkout']
                            //       .map<DropdownMenuEntry<String>>((String value) {
                            //     return DropdownMenuEntry<String>(
                            //         value: value,
                            //         label: value,
                            //         style: ButtonStyle(
                            //             foregroundColor:
                            //                 MaterialStateProperty.all(
                            //                     AppColors.secondary)));
                            //   }).toList(),
                            // ),
                            // SizedBox(
                            //   height: THelperFunctions.screenHeight() / 30,
                            // ),
                            ElevatedButton(
                              onPressed: controller.exportToExcel,
                              child: const Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(Iconsax.document_download),
                                  SizedBox(
                                    width: 10.0,
                                  ),
                                  Text(
                                    'Xuất file',
                                  )
                                ],
                              ),
                            ),
                          ],
                        );
                      }
                      return Center(
                          child: Text(
                        'Chưa có thông tin ca học',
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium
                            ?.copyWith(
                                fontSize:
                                    THelperFunctions.screenWidth() * 0.045),
                      ));
                    } else {
                      return AppLoaders.showCircularLoader();
                    }
                  },
                ),
                SizedBox(
                  height: THelperFunctions.screenHeight() / 25,
                ),
                Obx(() => Visibility(
                    visible: controller.loading.value,
                    child: Column(
                      children: [
                        AppLoaders.showCircularLoader(),
                        const Text('Đang xử lý file ...'),
                        SizedBox(height: THelperFunctions.screenHeight() / 50),
                        ElevatedButton(
                          onPressed: () {
                            controller.cancel = true;
                          },
                          style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.error,
                              side: BorderSide.none),
                          child: const Text(
                            'Cancel',
                          ),
                        )
                      ],
                    )))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
