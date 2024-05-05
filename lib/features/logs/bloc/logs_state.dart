part of 'logs_bloc.dart';

abstract class LogsState {}

class LogsInitial extends LogsState {}

class LogsLoadedState extends LogsState {
  final int lines;
  final List<String> logs;
  LogsLoadedState({
    required this.lines,
    required this.logs,
  });
}

class LogsDeletedState extends LogsState {}

class LogsErrorState extends LogsState {}
