import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/constants/constants.dart';
import '../../../core/network/result.dart';
import '../../../../core/utils.dart';
import '../auth_repository.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final _repository = AuthRepository();

  AuthBloc() : super(AuthLoginState()) {
    on<ShowPasswordEvent>((event, emit) {
      if (state is AuthLoginState) {
        emit(AuthLoginVisibleState());
      } else if (state is AuthLoginVisibleState) {
        emit(AuthLoginState());
      } else if (state is AuthRegisterState) {
        emit(AuthRegisterVisibleState());
      } else if (state is AuthRegisterVisibleState) {
        emit(AuthRegisterState());
      }
    });

    on<ChangePageEvent>((event, emit) {
      if (state is AuthLoginState || state is AuthLoginVisibleState) {
        emit(AuthRegisterState());
      } else if (state is AuthRegisterState ||
          state is AuthRegisterVisibleState) {
        emit(AuthLoginState());
      }
    });

    on<AuthLoginEvent>((event, emit) async {
      if (event.username.isEmpty || event.password.isEmpty) {
        emit(AuthNullState(Const.toastNull, null));
        emit(AuthLoginState());
        return;
      }

      emit(AuthLoginLoadingState());

      Result result = await _repository.login(
        event.username,
        event.password,
      );

      if (result is LoginSuccessResult) {
        token = result.token;
        await saveData('token', result.token);
        await saveData('username', event.username.toUpperCase());
        await getData();
        emit(AuthLoginSuccessState());
      } else if (result is ErrorResult) {
        emit(AuthErrorState(result.message, result.status));
        emit(AuthLoginState());
      } else {
        emit(AuthLoginState());
      }
    });

    on<AuthRegisterEvent>((event, emit) async {
      if (event.username.isEmpty ||
          event.password.isEmpty ||
          event.password2.isEmpty) {
        emit(AuthNullState(Const.toastNull, null));
        emit(AuthRegisterState());
        return;
      }

      if (event.password != event.password2) {
        emit(AuthNullState(Const.toastPasswordError, null));
        emit(AuthRegisterState());
        return;
      }

      emit(AuthRegisterLoadingState());

      Result result = await _repository.register(
        event.username,
        event.password,
      );

      if (result is RegisterSuccessResult) {
        emit(AuthRegisterSuccessState(result.message, result.status));
        emit(AuthRegisterState());
      } else if (result is ErrorResult) {
        emit(AuthErrorState(result.message, result.status));
        emit(AuthRegisterState());
      }
    });
  }
}
