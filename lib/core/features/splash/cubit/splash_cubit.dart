import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:todo_bloc_appwrite/core/locators/locator.dart';
import 'package:todo_bloc_appwrite/data/repository/auth_repository.dart';

part 'splash_state.dart';

class SplashCubit extends Cubit<SplashState> {
  SplashCubit() : super(SplashInitial());

  AuthRepository _authRepository = locator<AuthRepository>();

  void checkSession() async {
    emit(SplashLoading());
    final response = await _authRepository.checkSession();
    response.fold(
      (failure) => emit(SplashError(error: failure.message)),
      (session) => emit(SplashSuccess()) 
    );

  }

}
