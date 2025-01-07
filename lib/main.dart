import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_bloc_appwrite/core/features/auth/cubit/register_cubit.dart';
import 'package:todo_bloc_appwrite/core/locators/locator.dart';
import 'package:todo_bloc_appwrite/core/routes/routes.dart';
import 'package:todo_bloc_appwrite/core/theme/app_theme.dart';
import 'package:todo_bloc_appwrite/core/utils/app_strings.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  setupLocator();
  runApp(MultiBlocProvider(
    providers: [
      BlocProvider(create: (_) => RegisterCubit())
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
