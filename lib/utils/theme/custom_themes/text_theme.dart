import 'package:fe_attendance_app/utils/constants/colors.dart';
import 'package:flutter/material.dart';

class AppTextTheme {
  AppTextTheme._();

  static TextTheme lightTextTheme = TextTheme(
    headlineLarge: const TextStyle().copyWith(
        fontSize: 32.0,
        fontWeight: FontWeight.bold,
        color: AppColors.secondary),
    headlineMedium: const TextStyle().copyWith(
        fontSize: 24.0,
        fontWeight: FontWeight.w600,
        color: AppColors.secondary),
    headlineSmall: const TextStyle().copyWith(
        fontSize: 18.0,
        fontWeight: FontWeight.w600,
        color: AppColors.secondary),
    titleLarge: const TextStyle().copyWith(
        fontSize: 16.0,
        fontWeight: FontWeight.w600,
        color: AppColors.secondary),
    titleMedium: const TextStyle().copyWith(
        fontSize: 16.0,
        fontWeight: FontWeight.w500,
        color: AppColors.secondary),
    titleSmall: const TextStyle().copyWith(
        fontSize: 16.0,
        fontWeight: FontWeight.normal,
        color: AppColors.secondary),
    bodyLarge: const TextStyle().copyWith(
        fontSize: 14.0,
        fontWeight: FontWeight.w600,
        color: AppColors.secondary.withOpacity(0.7)),
    bodyMedium: const TextStyle().copyWith(
        fontSize: 14.0,
        fontWeight: FontWeight.w500,
        color: AppColors.secondary.withOpacity(0.7)),
    bodySmall: const TextStyle().copyWith(
        fontSize: 14.0,
        fontWeight: FontWeight.normal,
        color: AppColors.secondary.withOpacity(0.7)),
    labelLarge: const TextStyle().copyWith(
        fontSize: 12.0,
        fontWeight: FontWeight.normal,
        color: AppColors.secondary),
    labelMedium: const TextStyle().copyWith(
        fontSize: 12.0,
        fontWeight: FontWeight.normal,
        color: AppColors.secondary.withOpacity(0.5)),
  );

  static TextTheme darkTextTheme = TextTheme(
    headlineLarge: const TextStyle().copyWith(
        fontSize: 32.0, fontWeight: FontWeight.bold, color: Colors.white),
    headlineMedium: const TextStyle().copyWith(
        fontSize: 24.0, fontWeight: FontWeight.w600, color: Colors.white),
    headlineSmall: const TextStyle().copyWith(
        fontSize: 18.0, fontWeight: FontWeight.w600, color: Colors.white),
    titleLarge: const TextStyle().copyWith(
        fontSize: 16.0, fontWeight: FontWeight.w600, color: Colors.white),
    titleMedium: const TextStyle().copyWith(
        fontSize: 16.0, fontWeight: FontWeight.w500, color: Colors.white),
    titleSmall: const TextStyle().copyWith(
        fontSize: 16.0, fontWeight: FontWeight.w400, color: Colors.white),
    bodyLarge: const TextStyle().copyWith(
        fontSize: 14.0, fontWeight: FontWeight.w600, color: Colors.white),
    bodyMedium: const TextStyle().copyWith(
        fontSize: 14.0, fontWeight: FontWeight.normal, color: Colors.white),
    bodySmall: const TextStyle().copyWith(
        fontSize: 14.0,
        fontWeight: FontWeight.w500,
        color: Colors.white.withOpacity(0.5)),
    labelLarge: const TextStyle().copyWith(
        fontSize: 12.0, fontWeight: FontWeight.normal, color: Colors.white),
    labelMedium: const TextStyle().copyWith(
        fontSize: 12.0,
        fontWeight: FontWeight.normal,
        color: Colors.white.withOpacity(0.5)),
  );
}
