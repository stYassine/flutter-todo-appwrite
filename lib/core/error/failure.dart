import 'package:todo_bloc_appwrite/core/utils/app_strings.dart';

class Failure {
  final String message;
  Failure({this.message = AppStrings.internalServerError});
}
