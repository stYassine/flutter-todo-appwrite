import 'package:go_router/go_router.dart';
import 'package:todo_bloc_appwrite/core/features/auth/view/login_view.dart';
import 'package:todo_bloc_appwrite/core/features/auth/view/register_view.dart';
import 'package:todo_bloc_appwrite/core/features/splash/view/splash_view.dart';
import 'package:todo_bloc_appwrite/core/routes/routes_names.dart';

final GoRouter router = GoRouter(
  routes: [
    GoRoute(
      name: RoutesNames.splash,
      path: "/",
      builder: (context, state) => const SplashView(),
    ),
    GoRoute(
      name: RoutesNames.register,
      path: "/register",
      builder: (context, state) => const RegisterView(),
    ),
    GoRoute(
      name: RoutesNames.login,
      path: "/login",
      builder: (context, state) => const LoginView(),
    ),
  ]
);