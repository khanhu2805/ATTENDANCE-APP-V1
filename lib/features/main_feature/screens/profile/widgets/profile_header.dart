import 'package:fe_attendance_app/utils/constants/colors.dart';
import 'package:fe_attendance_app/utils/constants/image_strings.dart';
import 'package:fe_attendance_app/utils/helpers/helper_functions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TProfileHeader extends StatefulWidget {
  const TProfileHeader({
    super.key,
  });

  @override
  State<TProfileHeader> createState() => _TProfileHeaderState();
}

class _TProfileHeaderState extends State<TProfileHeader> {
  late bool isDark;
  @override
  Widget build(BuildContext context) {
    isDark = THelperFunctions.isDarkMode(context);
    return Container(
      height: THelperFunctions.screenHeight() / 8,
      width: THelperFunctions.screenWidth(),
      constraints: const BoxConstraints(
        minHeight: 180,
      ),
      decoration: BoxDecoration(
        color: isDark ? AppColors.primaryBackgroundDark : AppColors.primaryBackground, 
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(35.0),
          bottomRight: Radius.circular(35.0),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 20),
              const CircleAvatar(
                radius: 50,
                backgroundImage: AssetImage(AppImages.erroImageProfile),
              ),
              const SizedBox(height: 10),
              Text(
                FirebaseAuth.instance.currentUser?.displayName?.toUpperCase() ?? 'N/A',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontSize: THelperFunctions.screenWidth() * 0.045,
                      fontWeight: FontWeight.bold,
                    ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
