import 'package:dio/dio.dart';

import '../constants/constants.dart';

final dio = Dio();

final options = Options(
  headers: {
    'Content-Type': 'application/json',
    'Authorization': 'Bearer ${Const.token}',
  },
  receiveTimeout: const Duration(seconds: 5),
  sendTimeout: const Duration(seconds: 5),
);
