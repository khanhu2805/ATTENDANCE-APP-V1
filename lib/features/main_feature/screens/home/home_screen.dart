import 'package:fe_attendance_app/common/widgets/loaders/animation_loader.dart';
import 'package:fe_attendance_app/features/main_feature/controllers/home/home_controller.dart';
import 'package:fe_attendance_app/features/main_feature/screens/home/widgets/infor_class.dart';
import 'package:fe_attendance_app/navigation_menu.dart';
import 'package:fe_attendance_app/utils/constants/colors.dart';
import 'package:fe_attendance_app/utils/constants/image_strings.dart';
import 'package:fe_attendance_app/utils/formatters/formatter.dart';
import 'package:fe_attendance_app/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late List<String> description;
  late bool isDark;
  late NavigationController navigationController;
  late HomeController homeController;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    homeController = Get.put(HomeController());
    navigationController = NavigationController.instance;
  }

  @override
  Widget build(BuildContext context) {
    isDark = THelperFunctions.isDarkMode(context);
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.symmetric(
                    horizontal: THelperFunctions.screenWidth() / 30,
                    vertical: THelperFunctions.screenHeight() / 30),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: THelperFunctions.screenWidth() / 10,
                      backgroundImage:
                          const AssetImage(AppImages.erroImageProfile),
                    ),
                    SizedBox(
                      width: THelperFunctions.screenWidth() / 30,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Xin chào giảng viên',
                          style: Theme.of(context)
                              .textTheme
                              .bodySmall
                              ?.copyWith(
                                  fontSize:
                                      THelperFunctions.screenWidth() * 0.04),
                        ),
                        SizedBox(
                          height: THelperFunctions.screenHeight() * 0.01,
                        ),
                        Text(
                          homeController.auth.currentUser!.displayName
                                  ?.toUpperCase() ??
                              '',
                          style: Theme.of(context)
                              .textTheme
                              .titleLarge
                              ?.copyWith(
                                  fontSize:
                                      THelperFunctions.screenWidth() * 0.045),
                        )
                      ],
                    ),
                    const Spacer(),
                    IconButton(
                      color: AppColors.secondary,
                      onPressed: () {
                        navigationController.selectedIndex.value = 2;
                      },
                      icon: const Icon(Iconsax.notification),
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.all(THelperFunctions.screenWidth() / 30),
                padding: EdgeInsets.all(THelperFunctions.screenWidth() / 30),
                width: THelperFunctions.screenWidth(),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  gradient: const LinearGradient(
                    colors: [
                      AppColors.primary,
                      AppColors.primaryBackground,
                      AppColors.accent
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Ca điểm danh hôm nay',
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            fontSize: THelperFunctions.screenWidth() * 0.045,
                          ),
                    ),
                    FutureBuilder(
                      future: homeController.getClass(),
                      builder: (context, snapshot) {
                        if (!snapshot.hasData) {
                          return Padding(
                            padding: EdgeInsets.all(
                                THelperFunctions.screenWidth() / 30),
                            child: const Center(
                                child: CircularProgressIndicator(
                              color: AppColors.secondary,
                              strokeWidth: 3,
                            )),
                          );
                        } else if (snapshot.data!.docs.isEmpty) {
                          return Center(
                            child: TAnimationLoaderWidget(
                              height: THelperFunctions.screenHeight() / 5,
                              animation: AppImages
                                  .tickCongratulationsConfettiAnimation,
                              text: 'Hôm nay không có ca dạy',
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium
                                  ?.copyWith(
                                      fontSize: THelperFunctions.screenWidth() *
                                          0.04),
                            ),
                          );
                        }
                        return ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: snapshot.data?.docs.length,
                          itemBuilder: (context, index) {
                            return Padding(
                                padding: EdgeInsets.only(
                                    top: THelperFunctions.screenWidth() / 20),
                                child: GestureDetector(
                                  onTap: () {
                                    showDialog(
                                      context: context,
                                      builder: (context) => Dialog(
                                        insetPadding: EdgeInsets.symmetric(
                                            horizontal:
                                                THelperFunctions.screenWidth() /
                                                    30),
                                        backgroundColor:
                                            AppColors.primaryBackground,
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(20.0)),
                                        child: Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: THelperFunctions
                                                      .screenWidth() /
                                                  30,
                                              vertical: THelperFunctions
                                                      .screenHeight() /
                                                  30),
                                          child: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                Text(
                                                  'Thông tin học phần',
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .titleLarge
                                                      ?.copyWith(
                                                          fontSize: THelperFunctions
                                                                  .screenWidth() *
                                                              0.05),
                                                ),
                                                TextRow(
                                                    label: 'Mã LHP',
                                                    text: snapshot
                                                        .data!.docs[index].id,
                                                    icon: Iconsax.code),
                                                TextRow(
                                                    label: 'Tên HP',
                                                    text: snapshot
                                                        .data?.docs[index]
                                                        .get('name_of_class'),
                                                    icon: Iconsax.book),
                                                TextRow(
                                                    label: 'Ngày giờ học',
                                                    text:
                                                        '${snapshot.data?.docs[index].get('day_of_class')} (${snapshot.data?.docs[index].get('start_hour')} - ${snapshot.data?.docs[index].get('end_hour')})',
                                                    icon: Iconsax.timer),
                                                TextRow(
                                                    label: 'Ngày bắt đầu HP',
                                                    text: AppFormatter
                                                        .formatDate(snapshot
                                                            .data?.docs[index]
                                                            .get('start_date')
                                                            .toDate()),
                                                    icon: Iconsax.calendar),
                                                TextRow(
                                                    label: 'Ngày kết thúc HP',
                                                    text:
                                                        AppFormatter.formatDate(
                                                            snapshot.data
                                                                ?.docs[index]
                                                                .get('end_date')
                                                                .toDate()),
                                                    icon: Iconsax.calendar),
                                                Container(
                                                  margin: EdgeInsets.only(
                                                      top: THelperFunctions
                                                              .screenHeight() /
                                                          30),
                                                  alignment:
                                                      Alignment.centerRight,
                                                  child: ElevatedButton(
                                                      onPressed: () {
                                                        Navigator.of(context)
                                                            .pop();
                                                      },
                                                      child: Text('Đóng')),
                                                )
                                              ]),
                                        ),
                                      ),
                                    );
                                  },
                                  child: Row(
                                    children: [
                                      const Icon(
                                        Iconsax.book,
                                        color: AppColors.secondary,
                                      ),
                                      SizedBox(
                                        width:
                                            THelperFunctions.screenWidth() / 30,
                                      ),
                                      Text(
                                        snapshot.data!.docs[index]
                                            .get('name_of_class'),
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleMedium
                                            ?.copyWith(
                                                fontSize: THelperFunctions
                                                        .screenWidth() *
                                                    0.04),
                                      )
                                    ],
                                  ),
                                ));
                          },
                        );
                      },
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
