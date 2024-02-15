import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

import '../../constants/constants.dart';
import '../action/loading_widget.dart';

class ImageCachedWidget extends StatelessWidget {
  const ImageCachedWidget({
    super.key,
    required this.title,
  });

  final String title;

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: '${Const.imgURL}$title',
      placeholder: (context, url) {
        return const LoadingWidget();
      },
    );
  }
}
