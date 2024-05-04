import 'package:dio/dio.dart';

import '../../core/constants/constants.dart';
import '../../core/utils.dart';

class UserRepository {
  late Dio dio;

  UserRepository() {
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

  Future<int> updateUser(
    String username,
    String password,
    String newUsername,
    String newPassword,
  ) async {
    try {
      final response = await dio.put(
        Const.updateURL,
        data: {
          'username': username,
          'password': password,
          'new_username': newUsername,
          'new_password': newPassword,
        },
      );
      return response.statusCode!;
    } catch (e) {
      return 0;
    }
  }
}
