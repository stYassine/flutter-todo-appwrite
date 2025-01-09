import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:todo_bloc_appwrite/core/features/todo/cubit/todo_cubit.dart';
import 'package:todo_bloc_appwrite/core/theme/app_color.dart';
import 'package:todo_bloc_appwrite/core/utils/app_strings.dart';
import 'package:todo_bloc_appwrite/core/utils/custom_snackbar.dart';
import 'package:todo_bloc_appwrite/core/utils/full_screen_dialog_loader.dart';
import 'package:todo_bloc_appwrite/core/widgets/custom_text_form_field.dart';
import 'package:todo_bloc_appwrite/core/widgets/rounded_elevated_button.dart';
import 'package:todo_bloc_appwrite/data/model/todo_model.dart';

class AddEditTodoView extends StatefulWidget {
  const AddEditTodoView({
    super.key,
    this.todoModel
  });

  final TodoModel? todoModel; 

  @override
  State<AddEditTodoView> createState() => _AddEditTodoViewState();
}

class _AddEditTodoViewState extends State<AddEditTodoView> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _titleEditingtroller;
  late TextEditingController _descriptionEditingController;
  late bool isCompleted;

  clearText() {
    _titleEditingtroller.clear();
    _descriptionEditingController.clear();
  }

  void _submit() {
    if (_formKey.currentState!.validate()) {
      final String title = _titleEditingtroller.text;
      final String description = _descriptionEditingController.text;

      // create
      if(widget.todoModel == null){
        context.read<TodoCubit>().addTodo(title: title, description: description, isCompleted: isCompleted);
      }else{ // update
        context.read<TodoCubit>().editTodo(documentId: widget.todoModel!.id, title: title, description: description, isCompleted: isCompleted);
      }

    }
  }

  void _deleteTodo({required String documentId}){
    AwesomeDialog(
      context: context,
      dialogType: DialogType.warning,
      animType: AnimType.rightSlide,
      title: AppStrings.deleteTodo,
      desc: AppStrings.areYouSureToDeleteTodo,
      btnCancelOnPress: (){},
      btnOkOnPress: (){
        context.read<TodoCubit>().deleteTodo(documentId: documentId);
      },
    ).show();
  }

  @override
  void initState() {
    
    _titleEditingtroller = TextEditingController(text: widget.todoModel?.title ?? '');
    _descriptionEditingController = TextEditingController(text: widget.todoModel?.description ?? '');
    isCompleted = widget.todoModel?.isCompleted ?? false;

    super.initState();
  }

  @override
  void dispose() {
    _titleEditingtroller.dispose();
    _descriptionEditingController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.todoModel == null ? AppStrings.addTodo : AppStrings.editTodo),
          actions: [
            if(widget.todoModel!=null)
              IconButton(
                onPressed: () {
                  _deleteTodo(documentId: widget.todoModel!.id);
                },
                icon: const Icon(Icons.delete, color: AppColors.whiteColor),
              )
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(8),
          child: BlocConsumer<TodoCubit, TodoState>(
            listener: (context, state) {
              if(state is TodoAddEditDeleteLoading){
                FullScreenDialogLoader.show(context);
              }else if(state is TodoAddEditDeleteSuccess){
                FullScreenDialogLoader.cancel(context);
                clearText();

                if(widget.todoModel==null){
                  CustomSnackbar.showSuccess(context, AppStrings.todoCreatedSuccessfully);
                }else{
                  CustomSnackbar.showSuccess(context, AppStrings.todoUpdatedSuccessfully);
                }

                context.pop();
                context.read<TodoCubit>().getTodo();
              }else if(state is TodoError){
                FullScreenDialogLoader.cancel(context);
                CustomSnackbar.showError(context, state.error);
              }
            },
            builder: (context, state) {
              return Form(
                key: _formKey,
                child: Column(
                  children: [
                    // Title
                    CustomTextFormField(
                      controller: _titleEditingtroller,
                      validator: (val) {
                        if (val!.isEmpty) {
                          return AppStrings.required;
                        }
                        return null;
                      },
                      keybordType: TextInputType.text,
                      obscureText: false,
                      hintText: AppStrings.title,
                      suffix: null
                    ),

                    const SizedBox(height: 10),

                    // Description
                    CustomTextFormField(
                      controller: _descriptionEditingController,
                      validator: (val) {
                        if (val!.isEmpty) {
                          return AppStrings.required;
                        }
                        return null;
                      },
                      keybordType: TextInputType.text,
                      obscureText: false,
                      hintText: AppStrings.title,
                      suffix: null
                    ),

                    const SizedBox(height: 10),

                    // checkbox
                    if(widget.todoModel != null)
                      Checkbox(
                        value: widget.todoModel!.isCompleted, 
                        onChanged: (value){
                          setState(() {
                            isCompleted = value!;
                          });
                        }
                      ),

                    const SizedBox(height: 10),

                    // Submit Button
                    RoundedElevatedButton(
                      buttonText: widget.todoModel == null ? AppStrings.add : AppStrings.update,
                      onPressed: () {
                        _submit();
                      }
                    )
                  ],
                ),
              );
            },
          ),
        ));
  }
}
