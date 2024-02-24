part of 'auth_bloc.dart';

abstract class AuthEvent {}

class ShowPasswordEvent extends AuthEvent {}

class ChangePageEvent extends AuthEvent {}

class AuthLoginEvent extends AuthEvent {
  final String username;
  final String password;
  AuthLoginEvent(
    this.username,
    this.password,
  );
}

class AuthRegisterEvent extends AuthEvent {
  final String username;
  final String password;
  final String password2;
  AuthRegisterEvent(
    this.username,
    this.password,
    this.password2,
  );
}
