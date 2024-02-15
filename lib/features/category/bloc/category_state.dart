part of 'category_bloc.dart';

abstract class CategoryState {}

class CategoryInitial extends CategoryState {}

class CategoryLoadingState extends CategoryState {}

class CategorySuccessState extends CategoryState {
  final String message;
  final int status;
  CategorySuccessState(
    this.message,
    this.status,
  );
}

class CategoryErrorState extends CategoryState {
  final String message;
  final int? status;
  CategoryErrorState(
    this.message,
    this.status,
  );
}
