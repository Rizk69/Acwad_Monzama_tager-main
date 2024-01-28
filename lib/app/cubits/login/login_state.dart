part of 'login_cubit.dart';

@immutable
abstract class LoginState {}

class LoginInitial extends LoginState {}

class ChangeVisibilityPasswordSate extends LoginState {}

class LoginLoadingState extends LoginState {}

class LoginSuccessState extends LoginState {}

class LoginFirstSuccessState extends LoginState {}

class LoginErrorState extends LoginState {
  final String error;

  LoginErrorState(this.error);
}

class LogoutLoadingState extends LoginState {}

class LogoutSuccessState extends LoginState {}

class LogoutErrorState extends LoginState {
  final String error;

  LogoutErrorState(this.error);
}

class ChangePasswordLoadingState extends LoginState {}

class ChangePasswordSuccessState extends LoginState {}

class ChangePasswordErrorState extends LoginState {
  final String error;

  ChangePasswordErrorState(this.error);
}

class GetUserLoadingState extends LoginState {}

class GetUserSuccessState extends LoginState {}

class GetUserErrorState extends LoginState {
  final String error;

  GetUserErrorState(this.error);
}

class UpdateUserInfoLoadingState extends LoginState {}

class UpdateUserInfoSuccessState extends LoginState {}

class UpdateUserInfoErrorState extends LoginState {
  final String error;

  UpdateUserInfoErrorState(this.error);
}

class AppChangeVisibilityPassword extends LoginState {}
