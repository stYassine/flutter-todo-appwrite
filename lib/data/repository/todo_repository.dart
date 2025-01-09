import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart';
import 'package:fpdart/fpdart.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:todo_bloc_appwrite/core/error/failure.dart';
import 'package:todo_bloc_appwrite/core/error/server_exception.dart';
import 'package:todo_bloc_appwrite/core/locators/locator.dart';
import 'package:todo_bloc_appwrite/core/utils/app_strings.dart';
import 'package:todo_bloc_appwrite/core/utils/appwrite_contants.dart';
import 'package:todo_bloc_appwrite/data/model/todo_model.dart';
import 'package:todo_bloc_appwrite/data/provider/appwrite_provider.dart';

abstract interface class ITodoRepository {
  Future<Either<Failure, Document>> addTodo({
    required String userId,
    required String title,
    required String description,
    required bool isCompleted,
  });

  Future<Either<Failure, Document>> editTodo({
    required String documentId,
    required String title,
    required String description,
    required bool isCompleted,
  });

  Future<Either<Failure, List<TodoModel>>> getTodo({required String userId});
  
  Future<Either<Failure, dynamic>> deleteTodo({required String documentId});

}

class TodoRepository implements ITodoRepository{

  final AppwriteProvider _appwriteProvider = locator<AppwriteProvider>();
  final InternetConnectionChecker _internetConnectionChecker = locator<InternetConnectionChecker>();

  @override
  Future<Either<Failure, Document>> addTodo({required String userId, required String title, required String description, required bool isCompleted}) async {
    try{
      if(await _internetConnectionChecker.hasConnection){ 
        String documentId = ID.unique();

        Document document = await _appwriteProvider.database!.createDocument(
          databaseId: AppWriteConstants.databaseId, 
          collectionId: AppWriteConstants.todoCollectionId, 
          documentId: documentId,
          data: {
            "id": documentId,
            "userId": userId,
            "title": title,
            "description": description,
            "isCompleted": false
          }
        );

        return right(document);
      }else{
        return left(Failure(message: AppStrings.internetNotFound));
      }
       
    }on AppwriteException catch(e){
      return left(Failure(message: e.message!));
    }on ServerException catch(e){
      return left(Failure(message: e.message!));
    }
  }

  @override
  Future<Either<Failure, Document>> editTodo({required String documentId, required String title, required String description, required bool isCompleted}) async {

    try{
      if(await _internetConnectionChecker.hasConnection){

        Document document = await _appwriteProvider.database!.updateDocument(
          databaseId: AppWriteConstants.databaseId, 
          collectionId: AppWriteConstants.todoCollectionId, 
          documentId: documentId,
          data: {
            "title": title,
            "description": description,
            "isCompleted": false
          }
        );

        return right(document);
      }else{
        return left(Failure(message: AppStrings.internetNotFound));
      }
       
    }on AppwriteException catch(e){
      return left(Failure(message: e.message!));
    }on ServerException catch(e){
      return left(Failure(message: e.message!));
    }
  }

  @override
  Future<Either<Failure, List<TodoModel>>> getTodo({required String userId}) async {
    try{
      if(await _internetConnectionChecker.hasConnection){ 
        String documentId = ID.unique();

        DocumentList list = await _appwriteProvider.database!.listDocuments(
          databaseId: AppWriteConstants.databaseId, 
          collectionId: AppWriteConstants.todoCollectionId,
          queries: [
            Query.equal("userId", userId)
          ]
        );

        Map<String, dynamic> data = list.toMap();
        List d = data['documents'].toList();

        List<TodoModel> todoList = d.map((e) => TodoModel.fromMap(e['data']) ).toList();

        return right(todoList);
      }else{
        return left(Failure(message: AppStrings.internetNotFound));
      }
       
    }on AppwriteException catch(e){
      return left(Failure(message: e.message!));
    }on ServerException catch(e){
      return left(Failure(message: e.message!));
    }
  }

  @override
  Future<Either<Failure, dynamic>> deleteTodo({required String documentId}) async {
    try{
      if(await _internetConnectionChecker.hasConnection){

        var response = await _appwriteProvider.database!.deleteDocument(
          databaseId: AppWriteConstants.databaseId, 
          collectionId: AppWriteConstants.todoCollectionId,
          documentId: documentId
        );
        return right(response);
      }else{
        return left(Failure(message: AppStrings.internetNotFound));
      }
       
    }on AppwriteException catch(e){
      return left(Failure(message: e.message!));
    }on ServerException catch(e){
      return left(Failure(message: e.message!));
    }
  }

}