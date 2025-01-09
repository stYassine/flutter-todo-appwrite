import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_storage/get_storage.dart';
import 'package:todo_bloc_appwrite/core/features/auth/cubit/login_cubit.dart';
import 'package:todo_bloc_appwrite/core/features/auth/cubit/register_cubit.dart';
import 'package:todo_bloc_appwrite/core/features/splash/cubit/splash_cubit.dart';
import 'package:todo_bloc_appwrite/core/features/todo/cubit/todo_cubit.dart';
import 'package:todo_bloc_appwrite/core/locators/locator.dart';
import 'package:todo_bloc_appwrite/core/routes/routes.dart';
import 'package:todo_bloc_appwrite/core/theme/app_theme.dart';
import 'package:todo_bloc_appwrite/core/utils/app_strings.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  setupLocator();
  runApp(MultiBlocProvider(
    providers: [
      BlocProvider(create: (_) => RegisterCubit()),
      BlocProvider(create: (_) => LoginCubit()),
      BlocProvider(create: (_) => SplashCubit()),
      BlocProvider(create: (_) => TodoCubit()),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: AppStrings.appName,
      theme: AppTheme.darkThemeMode,
      routerConfig: router,
    );
  }
}
