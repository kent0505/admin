part of 'user_bloc.dart';

abstract class UserEvent {}

class ShowPasswordEvent extends UserEvent {}

class UpdateEvent extends UserEvent {
  final String username;
  final String password;
  final String newUsername;
  final String newPassword;
  final String newPassword2;
  UpdateEvent(
    this.username,
    this.password,
    this.newUsername,
    this.newPassword,
    this.newPassword2,
  );
}
