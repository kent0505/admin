part of 'content_bloc.dart';

abstract class ContentState {}

class ContentInitial extends ContentState {}

class ContentLoadingState extends ContentState {}

class ContentSuccessState extends ContentState {
  final String message;
  final int status;
  ContentSuccessState(
    this.message,
    this.status,
  );
}

class ContentErrorState extends ContentState {
  final String message;
  final int? status;
  ContentErrorState(
    this.message,
    this.status,
  );
}
