import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../logs_repository.dart';

part 'logs_event.dart';
part 'logs_state.dart';

class LogsBloc extends Bloc<LogsEvent, LogsState> {
  final _repository = LogsRepository();
  Timer? _timer;

  LogsBloc() : super(LogsInitial()) {
    on<CheckEvent>((event, emit) {
      if (state is! LogsLoadedState) {
        add(LoadLogsEvent());
        add(StartTimerEvent());
      }
    });

    on<StartTimerEvent>((event, emit) {
      _timer = Timer.periodic(const Duration(seconds: 5), (_) {
        add(LoadLogsEvent());
      });
    });

    on<StopTimerEvent>((event, emit) {
      _timer!.cancel();
      emit(LogsInitial());
    });

    on<LoadLogsEvent>((event, emit) async {
      emit(LogsLoadingState());

      LogsResult result = await _repository.getLogs();

      if (result is LogsLoadedResult) {
        emit(LogsLoadedState(
          lines: result.lines,
          logs: result.logs,
        ));
      } else {
        emit(LogsErrorState());
      }
    });

    on<DeleteLogsEvent>((event, emit) async {
      emit(LogsLoadingState());
      int status = await _repository.deleteLogs();

      if (status == 200) {
        emit(LogsDeletedState());
      } else {
        emit(LogsErrorState());
      }
    });
  }
}
