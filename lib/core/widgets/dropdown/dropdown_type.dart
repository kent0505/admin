import 'package:flutter/material.dart';

class DropdownType extends StatelessWidget {
  const DropdownType({
    super.key,
    required this.controller,
  });

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Type'),
        const SizedBox(height: 5),
        DropdownMenu(
          controller: controller,
          onSelected: (value) {
            controller.text = value.toString();
          },
          hintText: 'Type',
          width: 200,
          dropdownMenuEntries: const [
            DropdownMenuEntry(
              label: '0',
              value: 0,
            ),
            DropdownMenuEntry(
              label: '1',
              value: 1,
            ),
          ],
        ),
      ],
    );
  }
}
