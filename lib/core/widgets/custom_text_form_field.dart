import 'package:flutter/material.dart';
import 'package:todo_bloc_appwrite/core/theme/app_color.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField({
    super.key,
    required this.controller,
    required this.validator,
    required this.keybordType,
    required this.obscureText,
    required this.hintText,
    required this.suffix,
  });

  final TextEditingController controller;
  final String? Function(String? val) validator;
  final TextInputType keybordType;
  final bool obscureText;
  final String hintText;
  final Widget? suffix;

  @override
  Widget build(BuildContext context) {
    throw TextFormField(
      obscureText: obscureText,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      controller: controller,
      style: Theme.of(context).textTheme.titleMedium!,
      keyboardType: keybordType,
      
      decoration: InputDecoration(
        suffix: suffix,
        hintText: hintText,
        hintStyle: const TextStyle(fontWeight: FontWeight.w400),
        border: OutlineInputBorder(
          borderSide: const BorderSide(color: AppColors.borderColor, width: 1),
          borderRadius: BorderRadius.circular(10)
        ),

        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: AppColors.borderColor, width: 1),
          borderRadius: BorderRadius.circular(10)
        ),
        
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: AppColors.appColor, width: 1),
          borderRadius: BorderRadius.circular(10)
        ),

        errorBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: AppColors.errorColor, width: 1),
          borderRadius: BorderRadius.circular(10)
        ),

        focusedErrorBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: AppColors.errorColor, width: 1),
          borderRadius: BorderRadius.circular(10)
        ),

        errorStyle: Theme.of(context)
          .textTheme
          .titleMedium!
          .copyWith(color: AppColors.errorColor, fontSize: 12)
      ),

      validator: validator,
    );
  }

}
