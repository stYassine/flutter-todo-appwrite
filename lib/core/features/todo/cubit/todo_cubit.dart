import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:todo_bloc_appwrite/core/locators/locator.dart';
import 'package:todo_bloc_appwrite/core/utils/storage_key.dart';
import 'package:todo_bloc_appwrite/core/utils/storage_service.dart';
import 'package:todo_bloc_appwrite/data/model/todo_model.dart';
import 'package:todo_bloc_appwrite/data/repository/todo_repository.dart';

part 'todo_state.dart';

class TodoCubit extends Cubit<TodoState> {
  TodoCubit() : super(TodoInitial());

  final TodoRepository _todoRepository = locator<TodoRepository>();
  final StorageService _storageService = locator<StorageService>();

  void addTodo({required String title, required String description,required bool isCompleted}) async {
    String userId = _storageService.getValue(StorageKey.userId);

    final res = await _todoRepository.addTodo(
      userId: userId, 
      title: title, 
      description: description, 
      isCompleted: isCompleted
    );

    res.fold(
      (failure) => emit(TodoError(error: failure.message)), 
      (document) => emit(TodoAddEditDeleteSuccess())
    );
  }

  void editTodo({required String documentId, required String title, required String description,required bool isCompleted}) async {
    final res = await _todoRepository.editTodo(
      documentId: documentId, 
      title: title, 
      description: description, 
      isCompleted: isCompleted
    );

    res.fold(
      (failure) => emit(TodoError(error: failure.message)), 
      (document) => emit(TodoAddEditDeleteSuccess())
    );
  } 

  void getTodo() async {
    String userId = _storageService.getValue(StorageKey.userId);

    final res = await _todoRepository.getTodo(userId: userId);

    res.fold(
      (failure) => emit(TodoError(error: failure.message)), 
      (todosList) => emit(TodoFetchSuccess(todoModel: todosList))
    );
  }

  void deleteTodo({required String documentId}) async {
    final res = await _todoRepository.deleteTodo(documentId: documentId);

    res.fold(
      (failure) => emit(TodoError(error: failure.message)), 
      (response) => emit(TodoAddEditDeleteSuccess())
    );
  }

}
