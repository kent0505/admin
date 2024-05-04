part of 'blog_bloc.dart';

abstract class BlogState {}

class BlogInitial extends BlogState {}

class BlogLoadingState extends BlogState {}

class BlogSuccessState extends BlogState {}

class BlogErrorState extends BlogState {}
