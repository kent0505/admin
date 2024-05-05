import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../core/constants/constants.dart';
import '../../core/models/content.dart';
import '../../core/utils.dart';
import '../../core/widgets/image/image_cached_widget.dart';
import '../../core/widgets/buttons/delete_button.dart';
import '../../core/widgets/image/image_file_widget.dart';
import '../../core/widgets/buttons/image_pick_button.dart';
import '../../core/widgets/buttons/save_button.dart';
import '../../core/widgets/textfields/textfield_widget.dart';
import '../home/bloc/home/home_bloc.dart';
import 'bloc/image_bloc.dart';

class ImagePage extends StatefulWidget {
  const ImagePage({
    super.key,
    required this.content,
  });

  final Content content;

  @override
  State<ImagePage> createState() => _ImagePageState();
}

class _ImagePageState extends State<ImagePage> {
  final controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    controller.text = widget.content.index.toString();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      onPopInvoked: (didPop) {
        print('POP SCOPE');
        context.read<ImageBloc>().add(RemoveImageEvent());
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Image'),
          actions: [
            DeleteButton(
              title: Const.alertDeleteContent,
              onPressed: () {
                context
                    .read<ImageBloc>()
                    .add(DeleteImageEvent(content: widget.content));
              },
            ),
          ],
        ),
        body: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            TextFieldWidget(
              controller: controller,
              hintText: 'Index',
            ),
            ImagePickButton(
              onPressed: () {
                context.read<ImageBloc>().add(PickImageEvent());
              },
            ),
            const SizedBox(height: 20),
            BlocBuilder<ImageBloc, ImageState>(
              builder: (context, state) {
                final image = context.read<ImageBloc>().image;

                if (image != null) {
                  return ImageFileWidget(
                    image: image,
                    onPressed: () {
                      context.read<ImageBloc>().add(RemoveImageEvent());
                    },
                  );
                } else {
                  return ImageCachedWidget(
                    title: widget.content.title,
                  );
                }
              },
            ),
            const SizedBox(height: 20),
            BlocListener<ImageBloc, ImageState>(
              listener: (context, state) {
                if (state is ImageSuccessState) {
                  showToast(context, 'ImageSuccessState');
                  context.pop();
                  context.read<HomeBloc>().add(LoadHomeEvent());
                }

                if (state is ImageErrorState) {
                  showToast(context, 'ImageErrorState', true);
                }
              },
              child: BlocBuilder<ImageBloc, ImageState>(
                builder: (context, state) {
                  return SaveButton(
                    title: Const.buttonUpdateText,
                    loading: state is ImageLoadingState,
                    onPressed: () {
                      context.read<ImageBloc>().add(UpdateImageEvent(
                            content: Content(
                              id: widget.content.id,
                              title: widget.content.title,
                              index: int.tryParse(controller.text) ?? 0,
                              image: widget.content.image,
                              bid: widget.content.bid,
                            ),
                          ));
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
