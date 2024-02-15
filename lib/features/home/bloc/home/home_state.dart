part of 'home_bloc.dart';

abstract class HomeState {}

class HomeInitial extends HomeState {}

class HomeLoadingState extends HomeState {}

class HomeLoadedState extends HomeState {
  final List<Category> categories;
  final List<Blog> blogs;
  final List<Content> contents;
  final String message;
  final int status;
  HomeLoadedState(
    this.categories,
    this.blogs,
    this.contents,
    this.message,
    this.status,
  );
}

class HomeErrorState extends HomeState {
  final String message;
  final int status;
  HomeErrorState(
    this.message,
    this.status,
  );
}
