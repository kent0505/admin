part of 'blog_bloc.dart';

abstract class BlogState {}

class BlogInitial extends BlogState {}

class BlogLoadingState extends BlogState {}

class BlogSuccessState extends BlogState {
  final String message;
  final int status;
  BlogSuccessState(
    this.message,
    this.status,
  );
}

class BlogErrorState extends BlogState {
  final String message;
  final int? status;
  BlogErrorState(
    this.message,
    this.status,
  );
}
