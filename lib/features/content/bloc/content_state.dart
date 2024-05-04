part of 'content_bloc.dart';

abstract class ContentState {}

class ContentInitial extends ContentState {}

class ContentLoadingState extends ContentState {}

class ContentSuccessState extends ContentState {}

class ContentErrorState extends ContentState {}
