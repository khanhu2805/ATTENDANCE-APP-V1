import 'package:flutter/material.dart';

import '../../../utils/constants/colors.dart';
import '../../../utils/helpers/helper_functions.dart';

class TFormDivider extends StatelessWidget {
  const TFormDivider({super.key, required this.dividerText});

  final String dividerText;

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Flexible(
            child: Divider(
                color: dark ? AppColors.darkGrey : AppColors.secondary,
                thickness: 0.5,
                indent: 60,
                endIndent: 5)),
        Text(dividerText,
            style: Theme.of(context)
                .textTheme
                .bodySmall
                ?.copyWith(fontSize: THelperFunctions.screenWidth() * 0.03)),
        Flexible(
            child: Divider(
                color: dark ? AppColors.darkGrey : AppColors.secondary,
                thickness: 0.5,
                indent: 5,
                endIndent: 60)),
      ],
    );
  }
}
