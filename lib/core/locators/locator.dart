import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:todo_bloc_appwrite/core/utils/storage_service.dart';
import 'package:todo_bloc_appwrite/data/provider/appwrite_provider.dart';
import 'package:todo_bloc_appwrite/data/repository/auth_repository.dart';
import 'package:todo_bloc_appwrite/data/repository/todo_repository.dart';

// I : is shorthand for Instance
final locator = GetIt.I;

// this is used for dependency Injection
void setupLocator() {
  
  locator.registerLazySingleton<InternetConnectionChecker>(()=> InternetConnectionChecker() );
  locator.registerLazySingleton<StorageService>(() => StorageService());
  locator.registerLazySingleton<AppwriteProvider>(() => AppwriteProvider());
  locator.registerLazySingleton<AuthRepository>(() => AuthRepository());
  locator.registerLazySingleton<TodoRepository>(() => TodoRepository());

}
