import 'package:flutter/material.dart';

class UsernameField extends StatelessWidget {
  const UsernameField({
    super.key,
    required this.controller,
    required this.hintText,
    required this.enabled,
    this.onPressed,
  });

  final TextEditingController controller;
  final String hintText;
  final bool enabled;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      enabled: enabled,
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        hintText: hintText,
        border: const OutlineInputBorder(),
        prefixIcon: const Icon(Icons.person),
      ),
      onTapOutside: (_) {
        FocusManager.instance.primaryFocus?.unfocus();
      },
    );
  }
}
