import 'package:fe_attendance_app/features/main_feature/controllers/log/log_controller.dart';
import 'package:fe_attendance_app/features/main_feature/screens/log/widget/data_table.dart';
import 'package:fe_attendance_app/utils/constants/colors.dart';
import 'package:fe_attendance_app/utils/helpers/helper_functions.dart';
import 'package:fe_attendance_app/utils/popups/loaders.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class LogScreen extends StatefulWidget {
  const LogScreen({super.key, this.id});
  final String? id;
  @override
  State<LogScreen> createState() => _LogScreenState();
}

class _LogScreenState extends State<LogScreen> {
  late bool isDark;
  late LogController controller;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller = Get.put(LogController());
    controller.getClassInfo(widget.id ?? '').then((value) {
      controller.getLog();
    });
  }

  @override
  Widget build(BuildContext context) {
    isDark = THelperFunctions.isDarkMode(context);
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
                  'Lịch sử điểm danh'.toUpperCase(),
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontSize: THelperFunctions.screenWidth() * 0.05),
                ),
                SizedBox(
                  height: THelperFunctions.screenHeight() / 30,
                ),
                FutureBuilder(
                  future: controller.getClassInfo(widget.id ?? ''),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      return Column(
                        children: [
                          Row(
                            children: [
                              Expanded(
                                flex: 1,
                                child: Text(
                                  'Mã lớp học phần:',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium
                                      ?.copyWith(
                                          fontSize:
                                              THelperFunctions.screenWidth() *
                                                  0.035),
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child: Text(
                                  '${snapshot.data?.id}',
                                  textAlign: TextAlign.left,
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleMedium
                                      ?.copyWith(
                                          fontSize:
                                              THelperFunctions.screenWidth() *
                                                  0.04),
                                ),
                              )
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                flex: 1,
                                child: Text(
                                  'Tên lớp học phần:',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium
                                      ?.copyWith(
                                          fontSize:
                                              THelperFunctions.screenWidth() *
                                                  0.035),
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child: Text(
                                  '${snapshot.data?.get('name_of_class')}',
                                  textAlign: TextAlign.left,
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleMedium
                                      ?.copyWith(
                                          fontSize:
                                              THelperFunctions.screenWidth() *
                                                  0.04),
                                ),
                              )
                            ],
                          ),
                          SizedBox(
                            height: THelperFunctions.screenHeight() / 20,
                          ),
                          DropdownMenu<String>(
                            inputDecorationTheme: InputDecorationTheme(
                              constraints: BoxConstraints(
                                maxHeight: THelperFunctions.screenHeight() / 12,
                              ),
                            ),
                            textStyle: Theme.of(context)
                                .textTheme
                                .titleSmall
                                ?.copyWith(
                                    fontSize:
                                        THelperFunctions.screenWidth() * 0.04),
                            menuStyle: MenuStyle(
                                backgroundColor:
                                    MaterialStateProperty.all(AppColors.white),
                                surfaceTintColor:
                                    MaterialStateProperty.all(AppColors.white)),
                            initialSelection: controller.selected,
                            leadingIcon: const Icon(Iconsax.calendar),
                            label: Text(
                              'Ngày (Buổi)',
                              style: TextStyle(
                                  fontSize:
                                      THelperFunctions.screenWidth() * 0.045),
                            ),
                            width: THelperFunctions.screenWidth() * 0.8,
                            onSelected: (String? value) {
                              controller.selected = value ?? '';
                            },
                            dropdownMenuEntries: controller.option
                                .map<DropdownMenuEntry<String>>((String value) {
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
                            height: THelperFunctions.screenHeight() / 30,
                          ),
                          DropdownMenu<String>(
                            inputDecorationTheme: InputDecorationTheme(
                              constraints: BoxConstraints(
                                maxHeight: THelperFunctions.screenHeight() / 12,
                              ),
                            ),
                            textStyle: Theme.of(context)
                                .textTheme
                                .titleSmall
                                ?.copyWith(
                                    fontSize:
                                        THelperFunctions.screenWidth() * 0.04),
                            menuStyle: MenuStyle(
                                backgroundColor:
                                    MaterialStateProperty.all(AppColors.white),
                                surfaceTintColor:
                                    MaterialStateProperty.all(AppColors.white)),
                            initialSelection: controller.check,
                            leadingIcon: const Icon(Iconsax.calendar),
                            label: Text(
                              'Checkin/ Checkout',
                              style: TextStyle(
                                  fontSize:
                                      THelperFunctions.screenWidth() * 0.045),
                            ),
                            width: THelperFunctions.screenWidth() * 0.8,
                            onSelected: (String? value) {
                              controller.check = value ?? '';
                            },
                            dropdownMenuEntries: ['check_in', 'check_out']
                                .map<DropdownMenuEntry<String>>((String value) {
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
                            height: THelperFunctions.screenHeight() / 30,
                          ),
                          ElevatedButton(
                            onPressed: () => {controller.getLog()},
                            child: const Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(Iconsax.search_normal_1),
                                SizedBox(
                                  width: 5.0,
                                ),
                                Text(
                                  'Tìm kiếm',
                                )
                              ],
                            ),
                          ),
                          SizedBox(
                            height: THelperFunctions.screenHeight() / 30,
                          ),
                          StreamBuilder(
                            stream: controller.logStream,
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return AppLoaders.showCircularLoader();
                              }
                              if (snapshot.data!.isEmpty) {
                                return Center(
                                  child: Text(
                                    'Chưa có thông tin lịch sử điểm danh',
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleMedium
                                        ?.copyWith(
                                            fontSize:
                                                THelperFunctions.screenWidth() *
                                                    0.04),
                                  ),
                                );
                              }
                              return SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: LogDataTable(log: snapshot.data));
                            },
                          )
                        ],
                      );
                    } else {
                      return AppLoaders.showCircularLoader();
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
