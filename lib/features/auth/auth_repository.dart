import 'package:dio/dio.dart';

import '../../core/constants/constants.dart';
import '../../core/network/dio_options.dart';
import '../../core/network/result.dart';

class AuthRepository {
  Future<Result> login(String username, String password) async {
    try {
      final response = await dio.post(
        Const.loginURL,
        data: {
          'username': username,
          'password': password,
        },
        options: Options(
          validateStatus: (_) => true,
        ),
      );

      if (response.statusCode == 200) {
        return LoginSuccessResult(
          response.data['access_token'],
        );
      } else {
        return ErrorResult(
          response.data['detail'],
          response.statusCode!,
        );
      }
    } catch (e) {
      return ServerErrorResult();
    }
  }

  Future<Result> register(String username, String password) async {
    try {
      final response = await dio.post(
        Const.registerURL,
        data: {
          'username': username,
          'password': password,
        },
        options: Options(
          validateStatus: (_) => true,
        ),
      );

      if (response.statusCode == 200) {
        return RegisterSuccessResult(
          response.data['detail'],
          response.statusCode!,
        );
      } else {
        return ErrorResult(
          response.data['detail'],
          response.statusCode!,
        );
      }
    } catch (e) {
      return ServerErrorResult();
    }
  }
}
