import 'package:go_router/go_router.dart';
import 'package:todo_bloc_appwrite/core/features/auth/view/login_view.dart';
import 'package:todo_bloc_appwrite/core/features/auth/view/register_view.dart';
import 'package:todo_bloc_appwrite/core/features/splash/view/splash_view.dart';
import 'package:todo_bloc_appwrite/core/features/todo/view/add_edit_todo_view.dart';
import 'package:todo_bloc_appwrite/core/features/todo/view/todo_view.dart';
import 'package:todo_bloc_appwrite/core/routes/routes_names.dart';
import 'package:todo_bloc_appwrite/data/model/todo_model.dart';

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
    GoRoute(
      name: RoutesNames.todo,
      path: "/todo",
      builder: (context, state) => const TodoView(),
    ),
    GoRoute(
      name: RoutesNames.addTodo,
      path: "/add-todo",
      builder: (context, state) => const AddEditTodoView(),
    ),
    GoRoute(
      name: RoutesNames.editTodo,
      path: "/edit-todo",
      builder: (context, state) {
        final todoModel = state.extra as TodoModel;
        return AddEditTodoView(todoModel: todoModel);
      } 
    ),
  ]
);