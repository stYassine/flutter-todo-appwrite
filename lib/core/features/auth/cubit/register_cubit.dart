import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:todo_bloc_appwrite/core/locators/locator.dart';
import 'package:todo_bloc_appwrite/data/repository/auth_repository.dart';

part 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit() : super(RegisterInitial());

  AuthRepository _authRepository = locator<AuthRepository>();

  void register({required String firstName,required String lastName,required String email,required String password}) async {
    emit(RegisterLoading());
    final response = await _authRepository.register(
      firstName: firstName, 
      lastName: lastName, 
      email: email, 
      password: password
    );
    
    response.fold(
      (failure) => emit(RegisterError(error: failure.message)),
      (user) => emit(RegisterSuccess()) 
    );


  }
}
