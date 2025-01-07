import 'package:appwrite/appwrite.dart';
import 'package:todo_bloc_appwrite/core/utils/appwrite_contants.dart';

class AppwriteProvider {
  Client client = Client();
  Account? account;
  Databases? database;

  AppwriteProvider(){
    client
      .setEndpoint(AppWriteConstants.endpoint)
      .setProject(AppWriteConstants.projectId)
      .setSelfSigned(status: true);

    account = Account(client);
    database = Databases(client);

  }

}
