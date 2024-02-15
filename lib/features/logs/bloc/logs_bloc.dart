import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/constants/constants.dart';
import '../../../core/network/dio_options.dart';

part 'logs_event.dart';
part 'logs_state.dart';

class LogsBloc extends Bloc<LogsEvent, LogsState> {
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
      try {
        final response = await dio.get(
          Const.logsURL,
          options: options,
        );

        if (response.statusCode == 200) {
          final lines = response.data['lines'];
          final logs = response.data['logs'];
          emit(LogsLoadedState(
            lines,
            List<String>.from(logs).reversed.toList(),
          ));
        } else {
          emit(LogsErrorState(Const.toastError, response.statusCode!));
        }
      } catch (e) {
        print(e);
        emit(LogsErrorState(Const.toastError, 500));
      }
    });

    on<DeleteLogsEvent>((event, emit) async {
      try {
        final response = await dio.get(
          Const.deleteLogsURL,
          options: options,
        );

        if (response.statusCode == 200) {
          emit(LogsDeletedState(Const.toastLogsDeleted, response.statusCode!));
        } else {
          emit(LogsErrorState(Const.toastError, response.statusCode!));
        }
      } catch (e) {
        emit(LogsErrorState(Const.toastError, 500));
      }
    });
  }
}
