import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:todo_bloc_appwrite/core/features/todo/cubit/todo_cubit.dart';
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
  void initState() {
    context.read<TodoCubit>().getTodo();
    super.initState();
  }

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
      body: BlocBuilder<TodoCubit, TodoState>(
        builder: (context, state){
          if(state is TodoFetchLoading){
            return const Center(child: CircularProgressIndicator());
          }else if(state is TodoFetchSuccess){
            final todos = state.todoModel;

            return todos.isNotEmpty ? ListView.builder(
              itemCount: todos.length,
              itemBuilder: (context, index){
                final todo = todos[index];
                return ListTile(
                  onTap: () => context.goNamed(RoutesNames.editTodo, extra: todo),
                  title: Text(todo.title),
                  subtitle: Text(todo.description),
                  leading: CircleAvatar(
                    radius: 10,
                    backgroundColor: todo.isCompleted ? AppColors.snackBarGreen : AppColors.snackBarRed,
                  ),
                );
              }
            ) 
            : Center(
              child: Text(AppStrings.noDataFound)
            );
          }else if(state is TodoError){
            Center(
              child: Text(state.error)
            );
          }

          return Container();
        },
      ),
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