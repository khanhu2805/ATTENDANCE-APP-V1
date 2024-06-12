import 'package:fe_attendance_app/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = THelperFunctions.isDarkMode(context);
    final description = [
      'Ứng dụng yêu cầu kết nối internet để đồng bộ dữ liệu.\nHãy chắc chắn rằng thiết bị của thầy cô luôn có kết nối mạng ổn định khi sử dụng ứng dụng.',
      'Tuân thủ các quy trình và chính sách về điểm danh của trường để đảm bảo tính nhất quán và minh bạch trong việc quản lý lớp học.',
      'Nếu có bất kỳ thắc mắc hoặc vấn đề nào, thầy cô vui lòng liên hệ với bộ phận hỗ trợ của ứng dụng để được giải đáp và hỗ trợ kịp thời.'
    ];
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
                          bottomLeft: Radius.circular(20.0),
                          bottomRight: Radius.circular(20.0))),
                  height: THelperFunctions.screenHeight() / 6,
                  width: THelperFunctions.screenWidth(),
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
                            Text('Nguyễn Thị Mỹ Hạnh',
                                style: Theme.of(context).textTheme.titleLarge),
                          ],
                        ),
                        IconButton(
                          icon: const Icon(Iconsax.notification),
                          onPressed: () {},
                        )
                      ],
                    ),
                  ),
                ),
                Container(
                  alignment: Alignment.bottomCenter,
                  margin: EdgeInsets.only(
                      top: THelperFunctions.screenWidth() / 6 + 35),
                  child: SizedBox(
                    width: THelperFunctions.screenWidth() * 0.8,
                    height: THelperFunctions.screenHeight() / 6,
                    child: PageView.builder(
                        itemCount: 3,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: EdgeInsets.all(10.0),
                            child: Material(
                              elevation: 8,
                              color: Colors.white,
                              shadowColor: Colors.grey.withOpacity(0.5),
                              borderRadius: BorderRadius.circular(20),

                              child: Padding(
                                padding: EdgeInsets.all(15.0),
                                child: Text(
                                  description[index],
                                  style: Theme.of(context).textTheme.bodyMedium,
                                ),
                              ),
                            ),
                          );
                        }),
                  ),
                )
              ],
            ),
            // SingleChildScrollView(
            //   child:,
            // )
          ],
        ),
      ),
    );
  }
}
