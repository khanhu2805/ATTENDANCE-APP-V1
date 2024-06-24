import 'package:fe_attendance_app/utils/constants/colors.dart';
import 'package:fe_attendance_app/utils/formatters/formatter.dart';
import 'package:fe_attendance_app/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class TextRow extends StatelessWidget {
  const TextRow(
      {super.key, required this.label, required this.text, required this.icon});
  final IconData icon;
  final String label;
  final String text;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: THelperFunctions.screenHeight() / 30,
        ),
        Row(
          children: [
            Icon(icon, color: AppColors.secondary),
            SizedBox(
              width: THelperFunctions.screenWidth() * 0.01,
            ),
            Text(
              label,
              style: Theme.of(context)
                  .textTheme
                  .titleMedium
                  ?.copyWith(fontSize: THelperFunctions.screenWidth() * 0.04),
            ),
            Spacer(),
            Text(
              text,
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium
                  ?.copyWith(fontSize: THelperFunctions.screenWidth() * 0.035),
            ),
          ],
        ),
      ],
    );
  }
}
