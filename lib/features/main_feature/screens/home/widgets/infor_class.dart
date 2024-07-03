import 'package:fe_attendance_app/utils/constants/colors.dart';
import 'package:fe_attendance_app/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';

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
            Icon(icon, color: AppColors.accent),
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
            Expanded(
              child: Container(
                padding:
                    EdgeInsets.only(left: THelperFunctions.screenWidth() / 30),
                alignment: Alignment.centerRight,
                child: Text(
                  text,
                  overflow: TextOverflow.clip,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      fontSize: THelperFunctions.screenWidth() * 0.035),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
