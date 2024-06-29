import 'package:fe_attendance_app/utils/constants/colors.dart';
import 'package:fe_attendance_app/utils/helpers/helper_functions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class TProfileMenuTitle extends StatelessWidget {
  const TProfileMenuTitle({
    super.key,
    required this.icon,
    required this.title,
    required this.onTap,
  });

  final IconData icon;
  final String title;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    bool isDark = THelperFunctions.isDarkMode(context);
    return Column(
      children: [
        ListTile(
          leading: Container(
            padding: const EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              color: isDark ? AppColors.primaryBackground : AppColors.bkIconProfile,
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: AppColors.secondary),
          ),
          title: Text(
            title,
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontSize: THelperFunctions.screenWidth() * 0.045,
                ),
          ),
          trailing: Container(
            padding: const EdgeInsets.all(8.0),
            child:
                const Icon(Iconsax.arrow_right_3, color: AppColors.secondary),
          ),
          onTap: onTap,
        ),
        
        const SizedBox(height: 20),
      ],
    );
  }
}
