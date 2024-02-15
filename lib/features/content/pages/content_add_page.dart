import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../image/bloc/image_bloc.dart';
import 'content_add_text.dart';
import 'content_add_image.dart';

class ContentAddPage extends StatelessWidget {
  const ContentAddPage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: PopScope(
        onPopInvoked: (didPop) {
          print('POP SCOPE');
          context.read<ImageBloc>().add(RemoveImageEvent());
        },
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: AppBar(
            title: const Text('Content'),
            bottom: const TabBar(
              tabs: [
                Tab(text: 'Text'),
                Tab(text: 'Image'),
              ],
            ),
          ),
          body: const TabBarView(
            children: [
              ContentAddText(),
              ContentAddImage(),
            ],
          ),
        ),
      ),
    );
  }
}
