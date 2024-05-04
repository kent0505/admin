import 'package:dio/dio.dart';

import '../../core/constants/constants.dart';
import '../../core/utils.dart';

class LogsRepository {
  late Dio dio;

  LogsRepository() {
    final options = BaseOptions(
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      receiveDataWhenStatusError: true,
      connectTimeout: const Duration(seconds: 5),
      receiveTimeout: const Duration(seconds: 5),
    );

    dio = Dio(options);
  }

  Future<LogsResult> getLogs() async {
    try {
      final response = await dio.get(Const.logsURL);

      if (response.statusCode == 200) {
        final lines = response.data['lines'];
        final logs = response.data['logs'];
        return LogsLoadedResult(
          lines: lines,
          logs: List<String>.from(logs).reversed.toList(),
        );
      } else {
        return LogsErrorResult();
      }
    } catch (e) {
      print(e);
      return LogsErrorResult();
    }
  }

  Future<int> deleteLogs() async {
    try {
      final response = await dio.get(
        Const.deleteLogsURL,
      );

      return response.statusCode!;
    } catch (e) {
      return 0;
    }
  }
}

abstract class LogsResult {}

class LogsLoadedResult extends LogsResult {
  final int lines;
  final List<String> logs;
  LogsLoadedResult({
    required this.lines,
    required this.logs,
  });
}

class LogsErrorResult extends LogsResult {}
