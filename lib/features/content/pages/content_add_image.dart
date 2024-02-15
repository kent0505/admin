import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../core/constants/constants.dart';
import '../../../core/models/content.dart';
import '../../../core/utils.dart';
import '../../../core/widgets/buttons/image_pick_button.dart';
import '../../../core/widgets/buttons/save_button.dart';
import '../../../core/widgets/image/image_file_widget.dart';
import '../../../core/widgets/textfields/textfield_widget.dart';
import '../../home/bloc/home/home_bloc.dart';
import '../../image/bloc/image_bloc.dart';

class ContentAddImage extends StatefulWidget {
  const ContentAddImage({super.key});

  @override
  State<ContentAddImage> createState() => _ContentAddImageState();
}

class _ContentAddImageState extends State<ContentAddImage> {
  final controller1 = TextEditingController();
  final controller2 = TextEditingController();

  @override
  void dispose() {
    controller1.dispose();
    controller2.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        TextFieldWidget(
          controller: controller1,
          hintText: 'Index',
        ),
        TextFieldWidget(
          controller: controller2,
          hintText: 'BID',
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
              return ImagePickButton(
                onPressed: () async {
                  context.read<ImageBloc>().add(PickImageEvent());
                },
              );
            }
          },
        ),
        const SizedBox(height: 20),
        BlocListener<ImageBloc, ImageState>(
          listener: (context, state) {
            if (state is ImageSuccessState) {
              context
                  .read<HomeBloc>()
                  .add(LoadHomeEvent(Const.toastImageAdded, state.status));
              context.pop();
            }
            if (state is ImageErrorState) {
              Utils.showToast(context, state.message, state.status, true);
            }
          },
          child: BlocBuilder<ImageBloc, ImageState>(
            builder: (context, state) {
              return SaveButton(
                title: Const.buttonAddText,
                loading: state is ImageLoadingState,
                onTap: () async {
                  context.read<ImageBloc>().add(UploadImageEvent(
                        Content(
                          id: 0,
                          title: '',
                          index: int.tryParse(controller1.text) ?? 0,
                          image: 0,
                          bid: int.tryParse(controller2.text) ?? 0,
                        ),
                      ));
                },
              );
            },
          ),
        ),
      ],
    );
  }
}
