import 'package:flutter/material.dart';

import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/device/device_utility.dart';

class OnBoardingPage extends StatelessWidget {
  const OnBoardingPage(
      {super.key,
        required this.image,
        required this.title,
        required this.subTitle});

  final String image, title, subTitle;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(AppSizes.defaultSpace),
        child: Column(
          children: [
            Image(
              image: AssetImage(image),
              width: DeviceUtils.getScreenWidth() * 0.8,
              height: DeviceUtils.getScreenHeight() * 0.6,
            ),
            Text(title,
                style: Theme.of(context).textTheme.headlineMedium,
                textAlign: TextAlign.center),
            Text(subTitle,
                style: Theme.of(context).textTheme.bodyMedium,
                textAlign: TextAlign.center)
          ],
        ));
  }
}