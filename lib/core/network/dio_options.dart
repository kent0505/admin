import 'package:dio/dio.dart';

import '../utils.dart';

final dio = Dio();

final options = Options(
  headers: {
    'Content-Type': 'application/json',
    'Authorization': 'Bearer $token',
  },
  receiveTimeout: const Duration(seconds: 5),
  sendTimeout: const Duration(seconds: 5),
);
