import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:todo_bloc_appwrite/core/routes/routes_names.dart';
import 'package:todo_bloc_appwrite/core/theme/app_color.dart';
import 'package:todo_bloc_appwrite/core/utils/app_image_url.dart';
import 'package:todo_bloc_appwrite/core/utils/app_strings.dart';
import 'package:todo_bloc_appwrite/core/utils/validation_rules.dart';
import 'package:todo_bloc_appwrite/core/widgets/custom_text_form_field.dart';
import 'package:todo_bloc_appwrite/core/widgets/rounded_elevated_button.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final _loginFormKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool isPasswordVisible = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            child: Form(
              key: _loginFormKey,
              child: Column(
                children: [
                  Image.asset(
                    AppImagesUrl.logo,
                    width: 100,
                    height: 100,
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  // Email
                  CustomTextFormField(
                    controller: _emailController, 
                    validator: (val) {
                      if(val!.isEmpty){
                        return AppStrings.required;
                      }else if(ValidationRules.emailValidation.hasMatch(val)){
                        return AppStrings.provideValidEmail;
                      }
                      return null;
                    }, 
                    keybordType: TextInputType.emailAddress, 
                    obscureText: false, 
                    hintText: AppStrings.email, 
                    suffix: null
                  ),

                  const SizedBox(
                    height: 10,
                  ),

                  // Password
                  CustomTextFormField(
                    controller: _passwordController, 
                    validator: (val) {
                      if(val!.isEmpty){
                        return AppStrings.required;
                      }
                      return null;
                    }, 
                    keybordType: TextInputType.visiblePassword, 
                    obscureText: !isPasswordVisible,
                    hintText: AppStrings.password,
                    suffix: InkWell(
                      onTap: () {
                        setState(() {
                          isPasswordVisible = !isPasswordVisible;
                        });
                      },
                      child: Icon(
                        isPasswordVisible
                          ? Icons.visibility
                          :  Icons.visibility_off,
                        color: AppColors.greyColor,
                      ),
                    )
                  ),

                  const SizedBox(
                    height: 10,
                  ),

                  RoundedElevatedButton(
                    buttonText: AppStrings.login, 
                    onPressed: (){
                      if(_loginFormKey.currentState!.validate()){}
                    }
                  ),

                  const SizedBox(
                    height: 10,
                  ),

                  GestureDetector(
                    onTap: (){
                      context.pushNamed(RoutesNames.register);
                    },
                    child: RichText(
                      text: TextSpan(
                        text: AppStrings.newUser,
                        style: TextStyle(color: AppColors.greyColor),
                        children: [
                          TextSpan(
                            text: AppStrings.register,
                            style: TextStyle(
                              color: AppColors.appColor,
                              fontWeight: FontWeight.w500
                            )
                          )
                        ]
                      )
                    ),
                  )



                ],
              )
            ),
          ),
        ),
      ),
    );
  }
}
