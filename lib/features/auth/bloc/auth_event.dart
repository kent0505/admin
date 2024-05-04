part of 'auth_bloc.dart';

abstract class AuthEvent {}

class ShowPasswordEvent extends AuthEvent {}

class ChangePageEvent extends AuthEvent {}

class AuthLoginEvent extends AuthEvent {
  final String username;
  final String password;
  AuthLoginEvent({
    required this.username,
    required this.password,
  });
}

class AuthRegisterEvent extends AuthEvent {
  final String username;
  final String password;
  final String password2;
  AuthRegisterEvent({
    required this.username,
    required this.password,
    required this.password2,
  });
}
