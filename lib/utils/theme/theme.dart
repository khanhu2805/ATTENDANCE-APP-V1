import 'package:fe_attendance_app/utils/theme/custom_themes/appbar_theme.dart';
import 'package:fe_attendance_app/utils/theme/custom_themes/bottom_sheet_theme.dart';
import 'package:fe_attendance_app/utils/theme/custom_themes/chip_theme.dart';
import 'package:fe_attendance_app/utils/theme/custom_themes/elevated_button_theme.dart';
import 'package:fe_attendance_app/utils/theme/custom_themes/outlined_button_theme.dart';
import 'package:fe_attendance_app/utils/theme/custom_themes/text_field_theme.dart';
import 'package:fe_attendance_app/utils/theme/custom_themes/text_theme.dart';
import 'package:flutter/material.dart';

class AppTheme {
  AppTheme._();

  static ThemeData lightTheme = ThemeData(
      useMaterial3: true,
      fontFamily: 'BeVietnamPro',
      brightness: Brightness.light,
      primaryColor: Colors.blue,
      scaffoldBackgroundColor: Colors.white,
      textTheme: AppTextTheme.lightTextTheme,
      elevatedButtonTheme: AppElevatedButtonTheme.lightElevatedButtonTheme,
      chipTheme: AppChipTheme.lightChipTheme,
      bottomSheetTheme: AppBottomSheetTheme.lightBottomSheetTheme,
      outlinedButtonTheme: AppOutlinedButtonTheme.lightOutlinedButtonTheme,
      inputDecorationTheme: AppTextFieldTheme.lightInputDecorationTheme,
    appBarTheme: AppAppBarTheme.lightAppBarTheme
  );
  static ThemeData darkTheme = ThemeData(
      useMaterial3: true,
      fontFamily: 'BeVietnamPro',
      brightness: Brightness.dark,
      primaryColor: Colors.blue,
      scaffoldBackgroundColor: Colors.black,
      textTheme: AppTextTheme.darkTextTheme,
      elevatedButtonTheme: AppElevatedButtonTheme.darkElevatedButtonTheme,
      chipTheme: AppChipTheme.darkChipTheme,
      bottomSheetTheme: AppBottomSheetTheme.darkBottomSheetTheme,
      outlinedButtonTheme: AppOutlinedButtonTheme.darkOutlinedButtonTheme,
      inputDecorationTheme: AppTextFieldTheme.darkInputDecorationTheme,
      appBarTheme: AppAppBarTheme.darkAppBarTheme
  );
}
