import 'package:dio/dio.dart';

import '../../core/constants/constants.dart';
import '../../core/network/dio_options.dart';

class UserRepository {
  Future<int?> updateUser(
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
        options: options,
      );
      return response.statusCode!;
    } on DioException catch (e) {
      print(e);
      return e.response!.statusCode;
    } catch (e) {
      print(e);
      return null;
    }
  }
}
