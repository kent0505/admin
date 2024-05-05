import 'package:blog/core/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../core/constants/constants.dart';
import '../../core/widgets/action/app_title.dart';
import '../../core/widgets/action/logo_widget.dart';
import '../../core/widgets/buttons/auth_button.dart';
import '../../core/widgets/buttons/auth_text_button.dart';
import '../../core/widgets/textfields/password_field.dart';
import '../../core/widgets/textfields/username_field.dart';
import 'bloc/auth_bloc.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  final usernameCon = TextEditingController();
  final passwordCon = TextEditingController();
  final passwordCon2 = TextEditingController();

  @override
  void dispose() {
    usernameCon.dispose();
    passwordCon.dispose();
    passwordCon2.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const LogoWidget(),
            const SizedBox(height: 20),
            AppTitle(title: Const.appTitle),
            const SizedBox(height: 60),
            BlocListener<AuthBloc, AuthState>(
              listener: (context, state) {
                if (state is AuthLoginSuccessState) {
                  showToast(context, 'AuthLoginSuccessState');
                  context.go('/home');
                }

                if (state is AuthErrorState) {
                  showToast(context, 'AuthErrorState', true);
                }

                if (state is AuthNullState) {
                  showToast(context, 'AuthNullState', true);
                }
              },
              child: BlocBuilder<AuthBloc, AuthState>(
                builder: (context, state) {
                  final loginStates = state is AuthLoginState ||
                      state is AuthLoginVisibleState ||
                      state is AuthLoginSuccessState ||
                      state is AuthLoginLoadingState;
                  final registerStates = state is AuthRegisterState ||
                      state is AuthRegisterVisibleState ||
                      state is AuthRegisterLoadingState;
                  final notVisibleStates = state is AuthLoginState ||
                      state is AuthRegisterState ||
                      state is AuthRegisterLoadingState;

                  if (loginStates) {
                    return Column(
                      children: [
                        UsernameField(
                          controller: usernameCon,
                          hintText: Const.usernameHintText,
                          enabled: loginStates,
                        ),
                        const SizedBox(height: 20),
                        PasswordField(
                          controller: passwordCon,
                          hintText: Const.passwordHintText,
                          enabled: loginStates,
                          visible: notVisibleStates,
                          onPressed: () {
                            context.read<AuthBloc>().add(ShowPasswordEvent());
                          },
                        ),
                        const SizedBox(height: 20),
                        AuthButton(
                          title: Const.loginText,
                          loading: state is AuthLoginLoadingState,
                          onPressed: () {
                            context.read<AuthBloc>().add(AuthLoginEvent(
                                  username: usernameCon.text,
                                  password: passwordCon.text,
                                ));
                            usernameCon.clear();
                            passwordCon.clear();
                          },
                        ),
                        const SizedBox(height: 20),
                        AuthTextButton(
                          title: Const.registerText,
                          loading: state is AuthLoginLoadingState,
                          onPressed: () {
                            context.read<AuthBloc>().add(ChangePageEvent());
                            usernameCon.clear();
                            passwordCon.clear();
                            passwordCon2.clear();
                          },
                        ),
                      ],
                    );
                  }

                  if (registerStates) {
                    return Column(
                      children: [
                        UsernameField(
                          controller: usernameCon,
                          hintText: Const.usernameHintText,
                          enabled: registerStates,
                        ),
                        const SizedBox(height: 20),
                        PasswordField(
                          controller: passwordCon,
                          hintText: Const.passwordHintText,
                          enabled: registerStates,
                          visible: notVisibleStates,
                          onPressed: () {
                            context.read<AuthBloc>().add(ShowPasswordEvent());
                          },
                        ),
                        const SizedBox(height: 20),
                        PasswordField(
                          controller: passwordCon2,
                          hintText: Const.confirmHintText,
                          enabled: registerStates,
                          visible: notVisibleStates,
                          onPressed: () {
                            context.read<AuthBloc>().add(ShowPasswordEvent());
                          },
                        ),
                        const SizedBox(height: 20),
                        AuthButton(
                          title: Const.registerText,
                          loading: state is AuthRegisterLoadingState,
                          onPressed: () {
                            context.read<AuthBloc>().add(AuthRegisterEvent(
                                  username: usernameCon.text,
                                  password: passwordCon.text,
                                  password2: passwordCon2.text,
                                ));
                            usernameCon.clear();
                            passwordCon.clear();
                            passwordCon2.clear();
                          },
                        ),
                        const SizedBox(height: 20),
                        AuthTextButton(
                          title: Const.loginText,
                          loading: state is AuthRegisterLoadingState,
                          onPressed: () {
                            context.read<AuthBloc>().add(ChangePageEvent());
                            usernameCon.clear();
                            passwordCon.clear();
                            passwordCon2.clear();
                          },
                        ),
                      ],
                    );
                  }

                  return Container();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
