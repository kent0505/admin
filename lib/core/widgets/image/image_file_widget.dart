import 'dart:io';

import 'package:flutter/material.dart';

import '../../constants/constants.dart';

class ImageFileWidget extends StatelessWidget {
  const ImageFileWidget({
    super.key,
    required this.image,
    required this.onPressed,
  });

  final File image;
  final void Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Center(child: Image.file(image)),
        Positioned(
          right: 10,
          top: 10,
          child: Tooltip(
            message: Const.tooltipRemoveImage,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Material(
                color: Colors.blueGrey,
                child: IconButton(
                  splashColor: Colors.transparent,
                  onPressed: onPressed,
                  color: Colors.white,
                  icon: const Icon(Icons.close),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
