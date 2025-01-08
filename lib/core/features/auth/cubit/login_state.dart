part of 'login_cubit.dart';

@immutable
sealed class LoginState {}

final class LoginInitial extends LoginState {}

final class LoginLoading extends LoginState {}

final class LoginSuccess extends LoginState {
  LoginSuccess({required this.session});

  final Session session;
}
final class LoginFailure extends LoginState {
  LoginFailure({required this.error});
  
  final String error;
}
