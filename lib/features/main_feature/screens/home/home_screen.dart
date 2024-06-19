import 'dart:async';
import 'package:fe_attendance_app/features/main_feature/controllers/home/home_controller.dart';
import 'package:fe_attendance_app/navigation_menu.dart';
import 'package:fe_attendance_app/utils/constants/image_strings.dart';
import 'package:fe_attendance_app/utils/helpers/helper_functions.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
  Timer? _timer;
  late final PageController pageController;
  late NavigationController navigationController;
  late HomeController homeController;
  late final FirebaseAuth auth;
  void startTime() {
    _timer = Timer.periodic(const Duration(seconds: 3), (timer) {
      if (pageController.page == description.length - 1) {
        pageController.animateToPage(0,
            duration: const Duration(milliseconds: 500),
            curve: Curves.easeInOut);
      } else {
        pageController.nextPage(
            duration: const Duration(milliseconds: 500),
            curve: Curves.easeInOut);
      }
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    navigationController = NavigationController.instance;
    pageController = PageController(initialPage: 0);
    homeController = Get.put(HomeController());
    auth = FirebaseAuth.instance;
    description = [
      '\u2022 Ứng dụng yêu cầu kết nối internet để đồng bộ dữ liệu.\n\u2022 Hãy chắc chắn rằng thiết bị của thầy cô luôn có kết nối mạng ổn định khi sử dụng ứng dụng.',
      '\u2022 Tuân thủ các quy trình và chính sách về điểm danh của trường để đảm bảo tính nhất quán và minh bạch trong việc quản lý lớp học.',
      '\u2022 Nếu có bất kỳ thắc mắc hoặc vấn đề nào, thầy cô vui lòng liên hệ với bộ phận hỗ trợ của ứng dụng để được giải đáp và hỗ trợ kịp thời.'
    ];
    startTime();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _timer?.cancel();
  }

  @override
  Widget build(BuildContext context) {
    isDark = THelperFunctions.isDarkMode(context);
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Stack(
              children: [
                Container(
                  decoration: BoxDecoration(
                      color: isDark ? Colors.blue : Colors.blue[200],
                      borderRadius: const BorderRadius.only(
                          bottomLeft: Radius.circular(35.0),
                          bottomRight: Radius.circular(35.0))),
                  height: THelperFunctions.screenHeight() / 8,
                  width: THelperFunctions.screenWidth(),
                  constraints: const BoxConstraints(
                    minHeight: 130,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(
                        left: 30.0, right: 10.0, top: 40.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Xin chào giảng viên',
                                style: Theme.of(context).textTheme.titleSmall),
                            Text(auth.currentUser?.displayName ?? '',
                                style: Theme.of(context).textTheme.titleLarge),
                          ],
                        ),
                        IconButton(
                          icon: const Icon(Iconsax.notification),
                          onPressed: () =>
                              {navigationController.selectedIndex.value = 2},
                        )
                      ],
                    ),
                  ),
                ),
                Container(
                  alignment: Alignment.bottomCenter,
                  margin: EdgeInsets.only(
                      top: THelperFunctions.screenWidth() / 6 + 35),
                  child: Container(
                    width: THelperFunctions.screenWidth() * 0.8,
                    height: THelperFunctions.screenHeight() / 6,
                    constraints: const BoxConstraints(
                      minHeight: 150,
                      minWidth: 300,
                    ),
                    child: PageView.builder(
                        controller: pageController,
                        itemCount: description.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Material(
                              elevation: 8,
                              color: isDark ? Colors.black : Colors.white,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                  side: BorderSide(
                                      width: isDark ? 1 : 0,
                                      color: Colors.white)),
                              shadowColor: Colors.grey.withOpacity(0.5),
                              child: Padding(
                                padding: const EdgeInsets.all(15.0),
                                child: RichText(
                                  text: TextSpan(
                                    children: [
                                      TextSpan(
                                        text: description[index],
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyMedium,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                        }),
                  ),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.all(THelperFunctions.screenWidth() / 30),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () => {navigationController.selectedIndex.value = 4},
                    child: Card(
                      elevation: 6,
                      shadowColor: Colors.grey.withOpacity(0.5),
                      child: Container(
                        width: THelperFunctions.screenWidth() / 2.3,
                        decoration: BoxDecoration(
                            color: isDark ? Colors.blue : Colors.white,
                            borderRadius: BorderRadius.circular(10.0)),
                        child: Column(
                          children: [
                            Container(
                              constraints: const BoxConstraints(minHeight: 100),
                              child: Image(
                                height: THelperFunctions.screenHeight() / 6,
                                image: const AssetImage(
                                    AppImages.onBoardingImage1),
                              ),
                            ),
                            Container(
                              width: THelperFunctions.screenWidth() / 2.3,
                              height: THelperFunctions.screenHeight() / 5,
                              constraints: const BoxConstraints(minHeight: 90),
                              decoration: BoxDecoration(
                                color: isDark ? Colors.black : Colors.blue[200],
                                borderRadius: const BorderRadius.only(
                                    bottomRight: Radius.circular(10.0),
                                    bottomLeft: Radius.circular(10.0)),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(6.0),
                                child: Column(
                                  children: [
                                    Container(
                                      height:
                                          THelperFunctions.screenHeight() / 15,
                                      alignment: Alignment.center,
                                      child: Text(
                                        'Điểm danh',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyLarge,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 5.0,
                                    ),
                                    Text(
                                      'Điểm danh sinh viên vào 15 phút đầu giờ và cuối giờ',
                                      style: Theme.of(context)
                                          .textTheme
                                          .labelMedium,
                                    )
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () => {navigationController.selectedIndex.value = 1},
                    child: Card(
                      elevation: 6,
                      shadowColor: Colors.grey.withOpacity(0.5),
                      child: Container(
                        width: THelperFunctions.screenWidth() / 2.3,
                        decoration: BoxDecoration(
                            color: isDark ? Colors.blue : Colors.white,
                            borderRadius: BorderRadius.circular(10.0)),
                        child: Column(
                          children: [
                            Container(
                              constraints: const BoxConstraints(minHeight: 100),
                              child: Image(
                                height: THelperFunctions.screenHeight() / 6,
                                image: const AssetImage(
                                    AppImages.onBoardingImage2),
                              ),
                            ),
                            Container(
                              width: THelperFunctions.screenWidth() / 2.3,
                              height: THelperFunctions.screenHeight() / 5,
                              constraints: const BoxConstraints(minHeight: 90),
                              decoration: BoxDecoration(
                                color: isDark ? Colors.black : Colors.blue[200],
                                borderRadius: const BorderRadius.only(
                                    bottomRight: Radius.circular(10.0),
                                    bottomLeft: Radius.circular(10.0)),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(6.0),
                                child: Column(
                                  children: [
                                    Container(
                                      height:
                                          THelperFunctions.screenHeight() / 15,
                                      alignment: Alignment.center,
                                      child: Text(
                                        'Lịch sử\nđiểm danh',
                                        textAlign: TextAlign.center,
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyLarge,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 5.0,
                                    ),
                                    Text(
                                      'Xem lịch sử điểm danh sinh viên',
                                      style: Theme.of(context)
                                          .textTheme
                                          .labelMedium,
                                    )
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            )
            // SingleChildScrollView(
            //   child:,
            // )
          ],
        ),
      ),
    );
  }
}
