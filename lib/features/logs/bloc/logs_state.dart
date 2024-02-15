part of 'logs_bloc.dart';

abstract class LogsState {}

class LogsInitial extends LogsState {}

class LogsLoadedState extends LogsState {
  final int lines;
  List<String> logs;
  LogsLoadedState(
    this.lines,
    this.logs,
  );
}

class LogsDeletedState extends LogsState {
  final String message;
  final int status;
  LogsDeletedState(
    this.message,
    this.status,
  );
}

class LogsErrorState extends LogsState {
  final String message;
  final int status;
  LogsErrorState(
    this.message,
    this.status,
  );
}
