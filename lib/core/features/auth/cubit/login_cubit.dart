import 'package:appwrite/models.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:todo_bloc_appwrite/core/locators/locator.dart';
import 'package:todo_bloc_appwrite/data/repository/auth_repository.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());

  AuthRepository _authRepository = locator<AuthRepository>();

  void login({required String email,required String password}) async {
    emit(LoginLoading());
    final response = await _authRepository.login(email: email,password: password);
    response.fold(
      (failure) => emit(LoginFailure(error: failure.message)),
      (session) => emit(LoginSuccess(session: session)) 
    );

  }


}
