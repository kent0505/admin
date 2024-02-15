import 'package:flutter/material.dart';

class AuthTextButton extends StatelessWidget {
  const AuthTextButton({
    super.key,
    required this.title,
    required this.loading,
    required this.onPressed,
  });

  final String title;
  final bool loading;
  final void Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: loading ? null : onPressed,
      child: Text(
        loading ? '' : title,
      ),
    );
  }
}
