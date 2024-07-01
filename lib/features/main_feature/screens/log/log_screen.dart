import 'package:fe_attendance_app/utils/constants/colors.dart';
import 'package:fe_attendance_app/utils/helpers/helper_functions.dart';
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
  late final List<String> _options;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller = Get.put(LogController());
    _options = [
      'Apple',
      'Banana',
      'Cherry',
      'Date',
      'Elderberry',
      'Fig',
      'Grape',
      'Honeydew',
    ];
  }

  @override
  Widget build(BuildContext context) {
    isDark = THelperFunctions.isDarkMode(context);
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Container(
              height: THelperFunctions.screenHeight() / 6,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: isDark
                      ? [
                          AppColors.accent.withOpacity(0.7),
                          AppColors.black,
                          AppColors.primary.withOpacity(0.7),
                        ]
                      : [
                          AppColors.primary.withOpacity(0.5),
                          AppColors.primaryBackground,
                          AppColors.accent.withOpacity(0.5)
                        ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(35.0),
                  bottomRight: Radius.circular(35.0),
                ),
              ),
              child: Text(
                'Lịch sử điểm danh',
                style: Theme.of(context).textTheme.headlineMedium,
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 20.0),
            DropdownMenu<String>(
              initialSelection: _options.first,
              leadingIcon: const Icon(Iconsax.book),
              width: THelperFunctions.screenWidth() * 0.8,
              onSelected: (String? value) {
                // This is called when the user selects an item.
              },
              dropdownMenuEntries:
                  _options.map<DropdownMenuEntry<String>>((String value) {
                return DropdownMenuEntry<String>(
                    value: value,
                    label: value,
                    style: ButtonStyle(
                      backgroundColor: WidgetStateProperty.all<Color>(
                          isDark ? Colors.black : Colors.white),
                    ));
              }).toList(),
            ),
            const SizedBox(
              height: 20.0,
            ),
            DropdownMenu<String>(
              initialSelection: _options.first,
              leadingIcon: const Icon(Iconsax.clock),
              width: THelperFunctions.screenWidth() * 0.8,
              onSelected: (String? value) {
                // This is called when the user selects an item.
              },
              dropdownMenuEntries:
                  _options.map<DropdownMenuEntry<String>>((String value) {
                return DropdownMenuEntry<String>(
                    value: value,
                    label: value,
                    style: ButtonStyle(
                      backgroundColor: WidgetStateProperty.all<Color>(
                          isDark ? Colors.black : Colors.white),
                    ));
              }).toList(),
            ),
            const SizedBox(
              height: 20.0,
            ),
            Container(
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.textSecondary.withOpacity(0.5),
                      blurRadius: 30,
                      spreadRadius: 0,
                      offset: const Offset(5, 10),
                    ),
                  ],
                ),
                child: MaterialButton(
                  onPressed: () => {},
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50),
                  ),
                  color: AppColors.secondary,
                  child: const Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Iconsax.search_normal_1,
                        color: AppColors.textWhite,
                      ),
                      SizedBox(
                        width: 5.0,
                      ),
                      Text(
                        'Tìm kiếm',
                        style: TextStyle(color: AppColors.textWhite),
                      ),
                    ],
                  ),
                ))
          ],
        ),
      ),
    );
  }
}

class LogController extends GetxController {
  static LogController get instance => Get.find();
  Rx<bool> showClassSection = false.obs;

// void updateShowClassSection(bool value) {
//   showClassSection.value = value;
// }
}
