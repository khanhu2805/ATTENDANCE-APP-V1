import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import '../../../utils/constants/sizes.dart';

class TAnimationLoaderWidget extends StatelessWidget {
  const TAnimationLoaderWidget({
    super.key,
    required this.text,
    required this.animation,
    this.showAction = false,
    this.actionText,
    this.onActionPressed,
    this.height,
    this.width,
    this.style,
  });

  final String text;
  final TextStyle? style;
  final String animation;
  final bool showAction;
  final String? actionText;
  final VoidCallback? onActionPressed;
  final double? height, width;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Lottie.asset(animation,
              height: height ?? MediaQuery.of(context).size.height * 0.5,
              width: width), // Display Lottie animation
          const SizedBox(height: AppSizes.defaultSpace),
          Text(
            text,
            style: style ?? Theme.of(context).textTheme.bodyMedium,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: AppSizes.defaultSpace),
          showAction
              ? SizedBox(
                  width: 200,
                  child: OutlinedButton(
                    onPressed: onActionPressed,
                    // style: OutlinedButton.styleFrom(Theme.of(context).outlinedButtonTheme.),
                    child: Text(
                      actionText!,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ),
                )
              : const SizedBox(),
        ],
      ),
    );
  }
}
