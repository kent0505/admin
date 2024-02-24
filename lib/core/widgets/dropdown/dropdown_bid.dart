import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../features/home/bloc/home/home_bloc.dart';

class DropdownBID extends StatelessWidget {
  const DropdownBID({
    super.key,
    required this.controller,
  });

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('BID'),
        const SizedBox(height: 5),
        DropdownMenu(
          controller: controller,
          onSelected: (value) {
            controller.text = value.toString();
          },
          width: 200,
          hintText: 'BID',
          dropdownMenuEntries: context
              .read<HomeBloc>()
              .blogs
              .map((blog) => DropdownMenuEntry(
                    leadingIcon: Text('${blog.id}'),
                    value: blog.id,
                    label: blog.title.length > 15
                        ? blog.title.replaceRange(15, null, '...')
                        : blog.title,
                  ))
              .toList(),
        ),
      ],
    );
  }
}
