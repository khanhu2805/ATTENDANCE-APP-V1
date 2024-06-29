import 'package:fe_attendance_app/utils/constants/colors.dart';
import 'package:fe_attendance_app/utils/constants/image_strings.dart';
import 'package:fe_attendance_app/utils/constants/sizes.dart';
import 'package:fe_attendance_app/utils/helpers/helper_functions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TInforScreen extends StatelessWidget {
  const TInforScreen({
    super.key,
    required this.title,
    required this.content,
  });

  final String title;
  final String content;

  @override
  Widget build(BuildContext context) {
    bool isDark = THelperFunctions.isDarkMode(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: AppSizes.fontSizeLg,
                color: isDark
                    ? AppColors.white.withOpacity(0.6)
                    : AppColors.secondary.withOpacity(0.6),
              ),
            ),
            const Spacer(),
            SizedBox(
              width: MediaQuery.of(context).size.width - 200,
              child: Text(
                content,
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontSize: THelperFunctions.screenWidth() * 0.045,
                    ),
                softWrap: true,
                textAlign: TextAlign.end,
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        Divider(
          height: 1,
          thickness: 1,
          color: isDark
              ? AppColors.white.withOpacity(0.4)
              : AppColors.secondary.withOpacity(0.4),
        ),
        const SizedBox(height: 10),
      ],
    );
  }
}

class TInforHeaderScreen extends StatelessWidget {
  const TInforHeaderScreen({
    super.key,
    required this.displayName,
    required this.jobTitle,
  });

  final String displayName;
  final String jobTitle;

  @override
  Widget build(BuildContext context) {
    bool isDark = THelperFunctions.isDarkMode(context);
    return Container(
      height: THelperFunctions.screenHeight() / 8,
      width: THelperFunctions.screenWidth(),
      constraints: const BoxConstraints(
        minHeight: 230,
      ),
      decoration: BoxDecoration(
        color: isDark
            ? AppColors.primaryBackgroundDark
            : AppColors.primaryBackground,
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(35.0),
          bottomRight: Radius.circular(35.0),
        ),
      ),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        const SizedBox(height: 30),
        const Center(
          child: CircleAvatar(
            radius: 60,
            backgroundImage: AssetImage(AppImages.erroImageProfile),
          ),
        ),
        const SizedBox(height: 10),
        Center(
            child: Text(
          displayName.toUpperCase(),
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontSize: THelperFunctions.screenWidth() * 0.045,
                fontWeight: FontWeight.bold,
              ),
        )),
        const SizedBox(height: 5),
        Center(
            child: Text(jobTitle,
                style: TextStyle(
                  fontSize: 18,
                  color: isDark
                      ? AppColors.white.withOpacity(0.4)
                      : AppColors.secondary.withOpacity(0.4),
                ))),
      ]),
    );
  }
}
