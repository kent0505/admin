import 'package:flutter/material.dart';

class PasswordField extends StatelessWidget {
  const PasswordField({
    super.key,
    required this.controller,
    required this.hintText,
    required this.enabled,
    required this.visible,
    required this.onPressed,
  });

  final TextEditingController controller;
  final String hintText;
  final bool enabled;
  final bool visible;
  final void Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      enabled: enabled,
      textInputAction: null,
      obscureText: visible,
      decoration: InputDecoration(
        hintText: hintText,
        border: const OutlineInputBorder(),
        prefixIcon: const Icon(Icons.password),
        suffixIcon: IconButton(
          onPressed: onPressed,
          splashRadius: 20,
          icon: visible
              ? const Icon(Icons.visibility)
              : const Icon(Icons.visibility_off),
        ),
      ),
      onTapOutside: (_) {
        FocusManager.instance.primaryFocus?.unfocus();
      },
    );
  }
}
