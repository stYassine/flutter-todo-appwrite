import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart';
import 'package:fpdart/fpdart.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:todo_bloc_appwrite/core/error/failure.dart';
import 'package:todo_bloc_appwrite/core/error/server_exception.dart';
import 'package:todo_bloc_appwrite/core/locators/locator.dart';
import 'package:todo_bloc_appwrite/core/utils/app_strings.dart';
import 'package:todo_bloc_appwrite/core/utils/appwrite_contants.dart';
import 'package:todo_bloc_appwrite/data/provider/appwrite_provider.dart';

abstract interface class IAuthRepository {
  // either is from : fpdart
  // if failed type will Failure
  // if success type will be User
  Future<Either<Failure, User>> register({
    required String firstName,
    required String lastName,
    required String email,
    required String password,
  });

}

class AuthRepository implements IAuthRepository{
  final AppwriteProvider _appwriteProvider = locator<AppwriteProvider>();
  final InternetConnectionChecker _internetConnectionChecker = locator<InternetConnectionChecker>();

  @override
  Future<Either<Failure, User>> register({required String firstName, required String lastName, required String email, required String password}) async {
    
    try{
      if(await _internetConnectionChecker.hasConnection){
        User user = await _appwriteProvider.account!.create(
          userId: ID.unique(), 
          email: email, 
          password: password,
          name: "$firstName $lastName"
        );

        await _appwriteProvider.database!.createDocument(
          databaseId: AppWriteConstants.databaseId, 
          collectionId: AppWriteConstants.userCollectionId, 
          documentId: user.$id,
          data: {
            "id": user.$id,
            "first_name": firstName,
            "last_name": lastName,
            "full_name": "$firstName $lastName",
            "email": email,
          }
        );

        return right(user);
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