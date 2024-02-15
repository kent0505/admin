import 'package:flutter/material.dart';

import '../../constants/constants.dart';
import '../../utils.dart';

class DeleteButton extends StatelessWidget {
  const DeleteButton({
    super.key,
    required this.title,
    required this.onPressed,
  });

  final String title;
  final void Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: Const.tooltipDelete,
      child: IconButton(
        onPressed: () {
          Utils.showAlertDialog(
            context,
            title,
            onPressed,
          );
        },
        icon: const Icon(Icons.delete),
      ),
    );
  }
}
