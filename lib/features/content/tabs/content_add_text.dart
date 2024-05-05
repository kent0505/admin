import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../core/constants/constants.dart';
import '../../../core/models/content.dart';
import '../../../core/utils.dart';
import '../../../core/widgets/dropdown/dropdown_bid.dart';
import '../../../core/widgets/textfields/textfield_widget.dart';
import '../../../core/widgets/buttons/save_button.dart';
import '../../home/bloc/home/home_bloc.dart';
import '../bloc/content_bloc.dart';

class ContentAddText extends StatefulWidget {
  const ContentAddText({super.key});

  @override
  State<ContentAddText> createState() => _ContentAddTextState();
}

class _ContentAddTextState extends State<ContentAddText> {
  final controller1 = TextEditingController();
  final controller2 = TextEditingController();
  final controller3 = TextEditingController();

  @override
  void dispose() {
    controller1.dispose();
    controller2.dispose();
    controller3.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        TextFieldWidget(
          controller: controller1,
          hintText: 'Title',
          isTitle: true,
        ),
        TextFieldWidget(
          controller: controller2,
          hintText: 'Index',
        ),
        DropdownBID(controller: controller3),
        const SizedBox(height: 20),
        BlocListener<ContentBloc, ContentState>(
          listener: (context, state) {
            if (state is ContentSuccessState) {
              showToast(context, 'ContentSuccessState');
              context.pop();
              context.read<HomeBloc>().add(LoadHomeEvent());
            }

            if (state is ContentErrorState) {
              showToast(context, 'ContentErrorState', true);
            }
          },
          child: BlocBuilder<ContentBloc, ContentState>(
            builder: (context, state) {
              return SaveButton(
                title: Const.buttonAddText,
                loading: state is ContentLoadingState,
                onPressed: () {
                  context.read<ContentBloc>().add(AddContentEvent(
                        content: Content(
                          id: 0,
                          title: controller1.text,
                          index: int.tryParse(controller2.text) ?? 0,
                          image: 0,
                          bid: int.tryParse(controller3.text) ?? 0,
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
