import 'package:flutter/material.dart';

import '../../constants/constants.dart';

class ImagePickButton extends StatelessWidget {
  const ImagePickButton({
    super.key,
    required this.onPressed,
  });

  final void Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: onPressed,
      color: Colors.blueGrey,
      child: Text(
        Const.buttonPickImageText,
        style: const TextStyle(
          color: Colors.white,
        ),
      ),
    );
  }
}
