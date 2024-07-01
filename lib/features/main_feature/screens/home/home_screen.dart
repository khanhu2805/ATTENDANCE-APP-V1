import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fe_attendance_app/common/widgets/loaders/animation_loader.dart';
import 'package:fe_attendance_app/features/main_feature/controllers/home/home_controller.dart';
import 'package:fe_attendance_app/features/main_feature/screens/home/widgets/infor_class.dart';
import 'package:fe_attendance_app/navigation_menu.dart';
import 'package:fe_attendance_app/utils/constants/colors.dart';
import 'package:fe_attendance_app/utils/constants/image_strings.dart';
import 'package:fe_attendance_app/utils/formatters/formatter.dart';
import 'package:fe_attendance_app/utils/helpers/helper_functions.dart';
import 'package:fe_attendance_app/utils/popups/loaders.dart';
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
  late DateTime lastDayOfMonth;
  late ScrollController scrollController;
  @override
  void initState() {
    // TODO: implement initState
    homeController = Get.put(HomeController());
    navigationController = NavigationController.instance;
    homeController.getDate();
    scrollController = ScrollController();
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
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
                    GestureDetector(
                      onTap: () {
                        navigationController.selectedIndex.value = 2;
                      },
                      child: CircleAvatar(
                        radius: THelperFunctions.screenWidth() / 10,
                        backgroundImage:
                            const AssetImage(AppImages.erroImageProfile),
                      ),
                    ),
                    SizedBox(
                      width: THelperFunctions.screenWidth() / 30,
                    ),
                    GestureDetector(
                      onTap: () {
                        navigationController.selectedIndex.value = 2;
                      },
                      child: Column(
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
                  // margin: EdgeInsets.all(THelperFunctions.screenWidth() / 30),
                  // padding: EdgeInsets.all(THelperFunctions.screenWidth() / 30),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.0),
                    color: AppColors.primaryBackground,
                    // gradient: LinearGradient(
                    //   colors: [
                    //     AppColors.primary.withOpacity(0.5),
                    //     AppColors.primaryBackground,
                    //     AppColors.accent.withOpacity(0.5)
                    //   ],
                    //   begin: Alignment.topLeft,
                    //   end: Alignment.bottomRight,
                    // ),
                  ),
                  child: Obx(() {
                    if (homeController.now.value == DateTime(0, 0, 0)) {
                      return AppLoaders.showCircularLoader();
                    }
                    lastDayOfMonth = DateTime(homeController.now.value.year,
                        homeController.now.value.month + 1, 0);

                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding: EdgeInsets.all(
                              THelperFunctions.screenWidth() / 30),
                          child: Text(
                            'CA DẠY THÁNG ${homeController.now.value.month}',
                            style: Theme.of(context)
                                .textTheme
                                .titleLarge
                                ?.copyWith(
                                  fontSize:
                                      THelperFunctions.screenWidth() * 0.045,
                                ),
                          ),
                        ),
                        SizedBox(
                          height: THelperFunctions.screenHeight() / 8,
                          child: PageView.builder(
                            scrollDirection: Axis.horizontal,
                            // controller: scrollController,
                            padEnds: false,
                            // pageSnapping: false,
                            itemCount: lastDayOfMonth.day,
                            controller: PageController(
                                initialPage: homeController.now.value.day - 3,
                                viewportFraction: 1 / 5),
                            itemBuilder: (context, index) {
                              final currentDate = lastDayOfMonth.add(Duration(
                                  days: index + 1 - lastDayOfMonth.day));
                              final dayName =
                                  AppFormatter.formatDateToWeekDay(currentDate);

                              return GestureDetector(
                                onTap: () =>
                                    homeController.selectedDate.value = index,
                                child: Container(
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: 5.0),
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          color: AppColors.accent
                                              .withOpacity(0.5)),
                                      color: homeController
                                                  .selectedDate.value ==
                                              index
                                          ? AppColors.accent.withOpacity(0.8)
                                          : AppColors.white,
                                      borderRadius:
                                          BorderRadius.circular(10.0)),
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      Text(
                                        "${index + 1}",
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleMedium
                                            ?.copyWith(
                                                color: homeController
                                                            .selectedDate
                                                            .value ==
                                                        index
                                                    ? AppColors.white
                                                    : AppColors.accent,
                                                fontSize: THelperFunctions
                                                        .screenWidth() *
                                                    0.045),
                                      ),
                                      Text(
                                        dayName.substring(0, 3),
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyMedium
                                            ?.copyWith(
                                                color: homeController
                                                            .selectedDate
                                                            .value ==
                                                        index
                                                    ? AppColors.white
                                                    : AppColors.accent,
                                                fontSize: THelperFunctions
                                                        .screenWidth() *
                                                    0.045),
                                      ),
                                      Container(
                                        height:
                                            THelperFunctions.screenHeight() *
                                                0.008,
                                        width:
                                            THelperFunctions.screenWidth() / 8,
                                        decoration: BoxDecoration(
                                            color:
                                                homeController.now.value.day ==
                                                        index + 1
                                                    ? homeController
                                                                .selectedDate
                                                                .value ==
                                                            index
                                                        ? AppColors.white
                                                        : AppColors.accent
                                                    : Colors.transparent,
                                            borderRadius:
                                                BorderRadius.circular(10.0)),
                                      )
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.all(
                              THelperFunctions.screenWidth() / 30),
                          padding: EdgeInsets.all(
                              THelperFunctions.screenWidth() / 30),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0),
                            gradient: LinearGradient(
                              colors: [
                                AppColors.primary.withOpacity(0.5),
                                AppColors.primaryBackground,
                                AppColors.accent.withOpacity(0.5)
                              ],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                          ),
                          child: StreamBuilder<
                              QuerySnapshot<Map<String, dynamic>>?>(
                            stream: homeController
                                .getClass(homeController.selectedDate.value),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.done) {
                                if (snapshot.data!.docs.isEmpty) {
                                  return Center(
                                    child: TAnimationLoaderWidget(
                                      height:
                                          THelperFunctions.screenHeight() / 5,
                                      animation: AppImages
                                          .tickCongratulationsConfettiAnimation,
                                      text: 'Hôm nay không có ca dạy',
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleMedium
                                          ?.copyWith(
                                              fontSize: THelperFunctions
                                                      .screenWidth() *
                                                  0.04),
                                    ),
                                  );
                                }
                                return SizedBox(
                                  height: THelperFunctions.screenHeight() / 4,
                                  child: PageView.builder(
                                      itemCount:
                                          (snapshot.data!.docs.length / 5)
                                              .ceil(),
                                      itemBuilder: (context, index) {
                                        int startIndex = index;
                                        int endIndex = startIndex + 5;
                                        List pageItems =
                                            snapshot.data!.docs.sublist(
                                          startIndex,
                                          endIndex > snapshot.data!.docs.length
                                              ? snapshot.data!.docs.length
                                              : endIndex,
                                        );
                                        return ListView.builder(
                                          shrinkWrap: true,
                                          physics:
                                              const NeverScrollableScrollPhysics(),
                                          itemCount: pageItems.length,
                                          itemBuilder: (context, index) {
                                            return Padding(
                                              padding: EdgeInsets.only(
                                                  top: THelperFunctions
                                                          .screenWidth() /
                                                      20),
                                              child: GestureDetector(
                                                onTap: () {
                                                  showDialog(
                                                    context: context,
                                                    builder: (context) =>
                                                        Dialog(
                                                      insetPadding:
                                                          EdgeInsets.symmetric(
                                                              horizontal:
                                                                  THelperFunctions
                                                                          .screenWidth() /
                                                                      30),
                                                      backgroundColor:
                                                          AppColors.white,
                                                      shape:
                                                          RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          20.0)),
                                                      child: Column(
                                                          mainAxisSize:
                                                              MainAxisSize.min,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .center,
                                                          children: [
                                                            Container(
                                                              alignment:
                                                                  Alignment
                                                                      .center,
                                                              decoration: const BoxDecoration(
                                                                  color: AppColors
                                                                      .secondary,
                                                                  borderRadius:
                                                                      BorderRadius.vertical(
                                                                          top: Radius.circular(
                                                                              20.0))),
                                                              width: THelperFunctions
                                                                  .screenWidth(),
                                                              height: THelperFunctions
                                                                      .screenHeight() /
                                                                  15,
                                                              child: Text(
                                                                'Thông tin học phần'
                                                                    .toUpperCase(),
                                                                style: Theme.of(
                                                                        context)
                                                                    .textTheme
                                                                    .titleLarge
                                                                    ?.copyWith(
                                                                        color: AppColors
                                                                            .white,
                                                                        fontSize:
                                                                            THelperFunctions.screenWidth() *
                                                                                0.05),
                                                              ),
                                                            ),
                                                            Padding(
                                                              padding: EdgeInsets.all(
                                                                  THelperFunctions
                                                                          .screenWidth() /
                                                                      30),
                                                              child: Column(
                                                                children: [
                                                                  TextRow(
                                                                      label:
                                                                          'Mã LHP',
                                                                      text: pageItems[
                                                                              index]
                                                                          .id,
                                                                      icon: Iconsax
                                                                          .code),
                                                                  TextRow(
                                                                      label:
                                                                          'Tên HP',
                                                                      text: pageItems[
                                                                              index]
                                                                          .get(
                                                                              'name_of_class'),
                                                                      icon: Iconsax
                                                                          .book),
                                                                  TextRow(
                                                                      label:
                                                                          'Ngày giờ học',
                                                                      text:
                                                                          '${pageItems[index].get('day_of_class')} (${pageItems[index].get('start_hour')} - ${pageItems[index].get('end_hour')})',
                                                                      icon: Iconsax
                                                                          .timer),
                                                                  TextRow(
                                                                      label:
                                                                          'Ngày bắt đầu HP',
                                                                      text: AppFormatter.formatDate(pageItems[
                                                                              index]
                                                                          .get(
                                                                              'start_date')
                                                                          .toDate()),
                                                                      icon: Iconsax
                                                                          .calendar),
                                                                  TextRow(
                                                                      label:
                                                                          'Ngày kết thúc HP',
                                                                      text: AppFormatter.formatDate(pageItems[
                                                                              index]
                                                                          .get(
                                                                              'end_date')
                                                                          .toDate()),
                                                                      icon: Iconsax
                                                                          .calendar),
                                                                  Container(
                                                                    margin: EdgeInsets.only(
                                                                        top: THelperFunctions.screenHeight() /
                                                                            30),
                                                                    child: Row(
                                                                      children: [
                                                                        ElevatedButton(
                                                                          onPressed:
                                                                              () {
                                                                            Navigator.of(context).pop();
                                                                            navigationController.changeToLogScreen(pageItems[index].id);
                                                                          },
                                                                          child:
                                                                              const Text('Xem lịch sử điểm danh'),
                                                                        ),
                                                                        const Spacer(),
                                                                        ElevatedButton(
                                                                          onPressed:
                                                                              () {
                                                                            Navigator.of(context).pop();
                                                                          },
                                                                          child:
                                                                              const Text('Đóng'),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  )
                                                                ],
                                                              ),
                                                            )
                                                          ]),
                                                    ),
                                                  );
                                                },
                                                child: Column(
                                                  children: [
                                                    Row(
                                                      children: [
                                                        Container(
                                                          width: THelperFunctions
                                                                  .screenWidth() /
                                                              6,
                                                          alignment:
                                                              Alignment.center,
                                                          decoration: BoxDecoration(
                                                              color: AppColors
                                                                  .secondary,
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          8.0)),
                                                          child: Text(
                                                            pageItems[index].get(
                                                                'start_hour'),
                                                            style: Theme.of(
                                                                    context)
                                                                .textTheme
                                                                .titleMedium
                                                                ?.copyWith(
                                                                    color: AppColors
                                                                        .white,
                                                                    fontSize:
                                                                        THelperFunctions.screenWidth() *
                                                                            0.04),
                                                          ),
                                                        ),
                                                        // const Icon(
                                                        //   Iconsax.book,
                                                        //   color: AppColors
                                                        //       .secondary,
                                                        // ),
                                                        SizedBox(
                                                          width: THelperFunctions
                                                                  .screenWidth() /
                                                              30,
                                                        ),
                                                        SizedBox(
                                                          width: THelperFunctions
                                                                  .screenWidth() /
                                                              2,
                                                          child: Text(
                                                            pageItems[index].get(
                                                                'name_of_class'),
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                            maxLines: 1,
                                                            softWrap: false,
                                                            style: Theme.of(
                                                                    context)
                                                                .textTheme
                                                                .titleMedium
                                                                ?.copyWith(
                                                                    fontSize:
                                                                        THelperFunctions.screenWidth() *
                                                                            0.04),
                                                          ),
                                                        ),
                                                        const Spacer(),
                                                        const Icon(
                                                          Iconsax.arrow_right,
                                                          color: AppColors
                                                              .secondary,
                                                        )
                                                      ],
                                                    ),
                                                    Divider(
                                                      height: THelperFunctions
                                                              .screenHeight() /
                                                          30,
                                                      color: AppColors.secondary
                                                          .withOpacity(0.4),
                                                    )
                                                  ],
                                                ),
                                              ),
                                            );
                                          },
                                        );
                                      }),
                                );
                              }
                              return Center(
                                child: AppLoaders.showCircularLoader(),
                              );
                            },
                          ),
                        ),
                      ],
                    );
                  })),
              // GestureDetector(
              //   onTap: () => navigationController.selectedIndex.value = 1,
              //   child: Container(
              //     alignment: Alignment.centerLeft,
              //     padding: EdgeInsets.only(
              //         left: THelperFunctions.screenWidth() / 30),
              //     margin: EdgeInsets.all(THelperFunctions.screenWidth() / 30),
              //     width: THelperFunctions.screenWidth(),
              //     height: THelperFunctions.screenHeight() / 10,
              //     decoration: BoxDecoration(
              //         boxShadow: const [
              //           BoxShadow(
              //               spreadRadius: 2,
              //               blurRadius: 7,
              //               color: AppColors.grey,
              //               offset: Offset(5, 2.0))
              //         ],
              //         borderRadius: BorderRadius.circular(20.0),
              //         color: AppColors.primaryBackground,
              //         border: Border.all(color: AppColors.accent)
              //         // gradient: LinearGradient(
              //         //   colors: [
              //         //     AppColors.primary.withOpacity(0.5),
              //         //     AppColors.primaryBackground,
              //         //     AppColors.accent.withOpacity(0.5)
              //         //   ],
              //         //   begin: Alignment.topLeft,
              //         //   end: Alignment.bottomRight,
              //         // ),
              //         ),
              //     child: Text(
              //       'Lịch sử điểm danh'.toUpperCase(),
              //       style: Theme.of(context).textTheme.titleLarge?.copyWith(
              //             fontSize: THelperFunctions.screenWidth() * 0.045,
              //           ),
              //     ),
              //   ),
              // )
            ],
          ),
        ),
      ),
    );
  }
}
