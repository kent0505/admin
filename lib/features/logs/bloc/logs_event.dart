part of 'logs_bloc.dart';

abstract class LogsEvent {}

class CheckEvent extends LogsEvent {}

class LoadLogsEvent extends LogsEvent {}

class StartTimerEvent extends LogsEvent {}

class StopTimerEvent extends LogsEvent {}

class DeleteLogsEvent extends LogsEvent {}
