import 'package:fe_attendance_app/utils/constants/colors.dart';
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
    return ListTile(
      leading: Container(
        padding: const EdgeInsets.all(8.0),
        decoration: const BoxDecoration(
          color: AppColors.bkIconProfile,
          shape: BoxShape.circle,
        ),
        child: Icon(icon, color: AppColors.iconProfile),
      ),
      title: Text(title),
      trailing: Container(
        padding: const EdgeInsets.all(8.0),
        child: const Icon(Iconsax.arrow_right_3, color: AppColors.iconProfile),
      ),
      onTap: onTap,
    );
    
  }
}
