import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../features/home/bloc/home/home_bloc.dart';

class DropdownCID extends StatelessWidget {
  const DropdownCID({
    super.key,
    required this.controller,
  });

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('CID'),
        const SizedBox(height: 5),
        DropdownMenu(
          controller: controller,
          onSelected: (value) {
            controller.text = value.toString();
          },
          width: 200,
          hintText: 'CID',
          dropdownMenuEntries: context
              .read<HomeBloc>()
              .categories
              .where((category) => category.type != 1)
              .map(
                (category) => DropdownMenuEntry(
                  leadingIcon: Text('${category.id}'),
                  value: category.id,
                  label: category.title.length > 15
                      ? category.title.replaceRange(15, null, '...')
                      : category.title,
                ),
              )
              .toList(),
        ),
      ],
    );
  }
}
