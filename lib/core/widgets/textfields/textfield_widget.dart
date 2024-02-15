import 'package:flutter/material.dart';

class TextFieldWidget extends StatelessWidget {
  const TextFieldWidget({
    super.key,
    required this.controller,
    required this.hintText,
    this.isTitle = false,
  });

  final TextEditingController controller;
  final String hintText;
  final bool isTitle;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(hintText),
        const SizedBox(height: 5),
        TextField(
          controller: controller,
          keyboardType: isTitle ? null : TextInputType.number,
          textCapitalization: TextCapitalization.sentences,
          maxLines: isTitle ? null : 1,
          decoration: InputDecoration(
            hintText: hintText,
            border: const OutlineInputBorder(),
          ),
          onTapOutside: (_) {
            FocusManager.instance.primaryFocus?.unfocus();
          },
        ),
        const SizedBox(height: 15),
      ],
    );
  }
}
