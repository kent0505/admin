part of 'auth_bloc.dart';

abstract class AuthState {}

class AuthLoginState extends AuthState {}

class AuthLoginVisibleState extends AuthState {}

class AuthRegisterState extends AuthState {}

class AuthRegisterVisibleState extends AuthState {}

class AuthLoginLoadingState extends AuthState {}

class AuthRegisterLoadingState extends AuthState {}

class AuthLoginSuccessState extends AuthState {}

class AuthRegisterSuccessState extends AuthState {}

class AuthErrorState extends AuthState {}

class AuthNullState extends AuthState {}
