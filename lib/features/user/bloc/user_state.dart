part of 'user_bloc.dart';

abstract class UserState {}

class UserInitial extends UserState {}

class UserVisibleState extends UserState {}

class UserLoadingState extends UserState {}

class UserSuccessState extends UserState {}

class UserErrorState extends UserState {}
