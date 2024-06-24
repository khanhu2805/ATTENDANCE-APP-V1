import 'package:fe_attendance_app/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';

import '../../../../../utils/constants/image_strings.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/constants/text_strings.dart';

class TLoginHeader extends StatelessWidget {
  const TLoginHeader({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Image(height: 150, image: AssetImage(AppImages.lightAppLogo)),
        Text(
          AppTexts.loginTitle,
          style: Theme.of(context)
              .textTheme
              .titleLarge
              ?.copyWith(fontSize: THelperFunctions.screenWidth() * 0.05),
        ),
        Text(
          'Mời giảng viên đăng nhập để tiếp tục',
          style: Theme.of(context)
              .textTheme
              .bodySmall
              ?.copyWith(fontSize: THelperFunctions.screenWidth() * 0.035),
        ),
        SizedBox(height: AppSizes.sm),
      ],
    );
  }
}
