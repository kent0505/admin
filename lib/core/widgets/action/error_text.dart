import 'package:flutter/material.dart';

class ErrorText extends StatelessWidget {
  const ErrorText({
    super.key,
    required this.errorText,
    required this.onPressed,
  });

  final String errorText;
  final void Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(errorText),
          TextButton(
            onPressed: onPressed,
            child: const Text('Reload'),
          ),
        ],
      ),
    );
  }
}
