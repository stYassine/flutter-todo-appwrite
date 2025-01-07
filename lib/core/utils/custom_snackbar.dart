

import 'package:flutter/material.dart';
import 'package:todo_bloc_appwrite/core/theme/app_color.dart';

class CustomSnackbar {
  
  static void showSuccess(BuildContext context, String message){
    _showSnackbar(context, message, AppColors.snackBarGreen);
  }
  static void showInfo(BuildContext context, String message){
    _showSnackbar(context, message, AppColors.snackBarBlue);
  }
  static void showError(BuildContext context, String message){
    _showSnackbar(context, message, AppColors.snackBarRed);
  }

  static void _showSnackbar(BuildContext context, String message, Color color){
    WidgetsBinding.instance.addPostFrameCallback((_){
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            message,
            style: Theme.of(context).textTheme.titleLarge!.copyWith(
              fontSize: 14,
              fontWeight: FontWeight.normal,
              color: AppColors.whiteColor
            ),
          ),
          backgroundColor: color,
        )
      );
    });
  }

}