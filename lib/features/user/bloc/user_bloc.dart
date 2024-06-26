import 'package:flutter_bloc/flutter_bloc.dart';

import '../user_repository.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final _repository = UserRepository();

  UserBloc() : super(UserInitial()) {
    on<ShowPasswordEvent>((event, emit) {
      if (state is UserInitial) {
        emit(UserVisibleState());
      } else if (state is UserVisibleState) {
        emit(UserInitial());
      }
    });

    on<UpdateEvent>((event, emit) async {
      if (event.username.isEmpty ||
          event.password.isEmpty ||
          event.newUsername.isEmpty ||
          event.newPassword.isEmpty ||
          event.newPassword2.isEmpty) {
        emit(UserErrorState());
        emit(UserInitial());
        return;
      }

      if (event.newPassword != event.newPassword2) {
        emit(UserErrorState());
        emit(UserInitial());
        return;
      }

      if (event.username == event.newUsername &&
          event.password == event.newPassword) {
        emit(UserErrorState());
        emit(UserInitial());
        return;
      }

      int status = await _repository.updateUser(
        event.username,
        event.password,
        event.newUsername,
        event.newPassword,
      );

      if (status == 200) {
        emit(UserSuccessState());
        emit(UserInitial());
      } else {
        emit(UserErrorState());
        emit(UserInitial());
      }
    });
  }
}
