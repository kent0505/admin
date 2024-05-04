import 'package:flutter_bloc/flutter_bloc.dart';

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
        emit(AuthNullState());
        emit(AuthLoginState());
        return;
      }

      emit(AuthLoginLoadingState());

      AuthResult result = await _repository.login(
        event.username,
        event.password,
      );

      if (result is AuthLoginSuccessResult) {
        await saveData('token', result.token);
        await saveData('username', event.username);
        await getData();
        emit(AuthLoginSuccessState());
      } else if (result is ErrorResult) {
        emit(AuthErrorState());
        emit(AuthLoginState());
      } else {
        emit(AuthLoginState());
      }
    });

    on<AuthRegisterEvent>((event, emit) async {
      if (event.username.isEmpty ||
          event.password.isEmpty ||
          event.password2.isEmpty) {
        emit(AuthNullState());
        emit(AuthRegisterState());
        return;
      }

      if (event.password != event.password2) {
        emit(AuthNullState());
        emit(AuthRegisterState());
        return;
      }

      emit(AuthRegisterLoadingState());

      AuthResult result = await _repository.register(
        event.username,
        event.password,
      );

      if (result is AuthRegisterSuccessResult) {
        emit(AuthRegisterSuccessState());
        emit(AuthRegisterState());
      } else if (result is ErrorResult) {
        emit(AuthErrorState());
        emit(AuthRegisterState());
      }
    });
  }
}
