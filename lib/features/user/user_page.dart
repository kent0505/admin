import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../core/constants/constants.dart';
import '../../core/router/app_routes.dart';
import '../../core/utils.dart';
import '../../core/widgets/buttons/save_button.dart';
import '../../core/widgets/textfields/password_field.dart';
import '../../core/widgets/textfields/username_field.dart';
import 'bloc/user_bloc.dart';

class UserPage extends StatefulWidget {
  const UserPage({super.key});

  @override
  State<UserPage> createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  final _controller1 = TextEditingController();
  final _controller2 = TextEditingController();
  final _controller3 = TextEditingController();
  final _controller4 = TextEditingController();
  final _controller5 = TextEditingController();

  @override
  void dispose() {
    _controller1.dispose();
    _controller2.dispose();
    _controller3.dispose();
    _controller4.dispose();
    _controller5.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text('User'),
      ),
      body: BlocListener<UserBloc, UserState>(
        listener: (context, state) {
          if (state is UserSuccessState) {
            Utils.showToast(context, state.message, state.status);
            context.go(AppRoutes.authPage);
          }

          if (state is UserErrorState) {
            Utils.showToast(context, state.message, state.status, true);
          }
        },
        child: BlocBuilder<UserBloc, UserState>(
          builder: (context, state) {
            return Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Current'),
                  const SizedBox(height: 10),
                  UsernameField(
                    controller: _controller1,
                    hintText: Const.usernameHintText,
                    enabled: state is UserInitial || state is UserVisibleState,
                  ),
                  const SizedBox(height: 20),
                  PasswordField(
                    controller: _controller2,
                    hintText: Const.passwordHintText,
                    enabled: state is UserInitial || state is UserVisibleState,
                    visible: state is UserInitial || state is UserLoadingState,
                    onPressed: () {
                      context.read<UserBloc>().add(ShowPasswordEvent());
                    },
                  ),
                  const SizedBox(height: 20),
                  const Text('New'),
                  const SizedBox(height: 10),
                  UsernameField(
                    controller: _controller3,
                    hintText: 'New username',
                    enabled: state is UserInitial || state is UserVisibleState,
                  ),
                  const SizedBox(height: 20),
                  PasswordField(
                    controller: _controller4,
                    hintText: 'New password',
                    enabled: state is UserInitial || state is UserVisibleState,
                    visible: state is UserInitial || state is UserLoadingState,
                    onPressed: () {
                      context.read<UserBloc>().add(ShowPasswordEvent());
                    },
                  ),
                  const SizedBox(height: 20),
                  PasswordField(
                    controller: _controller5,
                    hintText: 'Confirm password',
                    enabled: state is UserInitial || state is UserVisibleState,
                    visible: state is UserInitial || state is UserLoadingState,
                    onPressed: () {
                      context.read<UserBloc>().add(ShowPasswordEvent());
                    },
                  ),
                  const SizedBox(height: 20),
                  SaveButton(
                    title: 'PUT',
                    loading: state is UserLoadingState,
                    onTap: () {
                      context.read<UserBloc>().add(UpdateEvent(
                            _controller1.text,
                            _controller2.text,
                            _controller3.text,
                            _controller4.text,
                            _controller5.text,
                          ));
                    },
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
