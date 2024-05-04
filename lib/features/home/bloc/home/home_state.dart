part of 'home_bloc.dart';

abstract class HomeState {}

class HomeInitial extends HomeState {}

class HomeLoadingState extends HomeState {}

class HomeLoadedState extends HomeState {
  final List<Category> categories;
  final List<Blog> blogs;
  final List<Content> contents;
  HomeLoadedState({
    required this.categories,
    required this.blogs,
    required this.contents,
  });
}

class HomeErrorState extends HomeState {}
