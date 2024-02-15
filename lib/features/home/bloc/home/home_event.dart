part of 'home_bloc.dart';

abstract class HomeEvent {}

class LoadHomeEvent extends HomeEvent {
  final String message;
  final int status;
  LoadHomeEvent(
    this.message,
    this.status,
  );
}
