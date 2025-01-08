import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:todo_bloc_appwrite/core/routes/routes_names.dart';
import 'package:todo_bloc_appwrite/core/theme/app_color.dart';
import 'package:todo_bloc_appwrite/core/utils/app_strings.dart';

class TodoView extends StatefulWidget {
  const TodoView({super.key});

  @override
  State<TodoView> createState() => _TodoViewState();
}

class _TodoViewState extends State<TodoView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppStrings.todo),
        actions: [
          IconButton(
            onPressed: () {

            }, 
            icon: const Icon(Icons.person)
          )
        ],
      ),
      body: Container(),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          context.pushNamed(RoutesNames.addTodo);
        },
        backgroundColor: AppColors.appColor,
        child: const Icon(Icons.add),
      ),
    );
  }
}