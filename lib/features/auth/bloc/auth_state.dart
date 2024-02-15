part of 'auth_bloc.dart';

abstract class AuthState {}

class AuthLoginState extends AuthState {}

class AuthLoginVisibleState extends AuthState {}

class AuthRegisterState extends AuthState {}

class AuthRegisterVisibleState extends AuthState {}

class AuthLoginLoadingState extends AuthState {}

class AuthRegisterLoadingState extends AuthState {}

class AuthLoginSuccessState extends AuthState {}

class AuthRegisterSuccessState extends AuthState {
  final String message;
  final int status;
  AuthRegisterSuccessState(
    this.message,
    this.status,
  );
}

class AuthErrorState extends AuthState {
  final String message;
  final int status;
  AuthErrorState(
    this.message,
    this.status,
  );
}

class AuthNullState extends AuthState {
  final String message;
  final int? status;
  AuthNullState(this.message, this.status);
}
