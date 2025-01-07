import 'package:flutter/material.dart';
import 'package:todo_bloc_appwrite/core/theme/app_color.dart';

class AppTheme {
  static final darkThemeMode = ThemeData.dark(useMaterial3: true)
    .copyWith(
      scaffoldBackgroundColor: AppColors.backgroundColor,
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.appBarColor
      ),
      progressIndicatorTheme: const ProgressIndicatorThemeData(
        color: AppColors.appColor
      )
    );
}
