part of 'notification_bloc.dart';

abstract class NotificationState {}

class NotificationInitial extends NotificationState {}

class NotificationLoadingState extends NotificationState {}

class NotificationLoadedState extends NotificationState {
  final String title;
  final String body;
  NotificationLoadedState({
    required this.title,
    required this.body,
  });
}

class NotificationErrorState extends NotificationState {}
