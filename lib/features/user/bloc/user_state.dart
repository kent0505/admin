part of 'user_bloc.dart';

abstract class UserState {}

class UserInitial extends UserState {}

class UserVisibleState extends UserState {}

class UserLoadingState extends UserState {}

class UserSuccessState extends UserState {
  final String message;
  final int status;
  UserSuccessState(
    this.message,
    this.status,
  );
}

class UserErrorState extends UserState {
  final String message;
  final int? status;
  UserErrorState(
    this.message,
    this.status,
  );
}
