import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../core/constants/constants.dart';
import '../../core/router.dart';
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
  final controller1 = TextEditingController();
  final controller2 = TextEditingController();
  final controller3 = TextEditingController();
  final controller4 = TextEditingController();
  final controller5 = TextEditingController();

  @override
  void dispose() {
    controller1.dispose();
    controller2.dispose();
    controller3.dispose();
    controller4.dispose();
    controller5.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text('User'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: BlocListener<UserBloc, UserState>(
          listener: (context, state) {
            if (state is UserSuccessState) {
              showToast(context, 'UserSuccessState');
              context.go(AppRoutes.authPage);
            }

            if (state is UserErrorState) {
              showToast(context, 'UserErrorState', true);
            }
          },
          child: BlocBuilder<UserBloc, UserState>(
            builder: (context, state) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Current'),
                  const SizedBox(height: 10),
                  UsernameField(
                    controller: controller1,
                    hintText: Const.usernameHintText,
                    enabled: state is UserInitial || state is UserVisibleState,
                  ),
                  const SizedBox(height: 20),
                  PasswordField(
                    controller: controller2,
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
                    controller: controller3,
                    hintText: 'New username',
                    enabled: state is UserInitial || state is UserVisibleState,
                  ),
                  const SizedBox(height: 20),
                  PasswordField(
                    controller: controller4,
                    hintText: 'New password',
                    enabled: state is UserInitial || state is UserVisibleState,
                    visible: state is UserInitial || state is UserLoadingState,
                    onPressed: () {
                      context.read<UserBloc>().add(ShowPasswordEvent());
                    },
                  ),
                  const SizedBox(height: 20),
                  PasswordField(
                    controller: controller5,
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
                            controller1.text,
                            controller2.text,
                            controller3.text,
                            controller4.text,
                            controller5.text,
                          ));
                    },
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
