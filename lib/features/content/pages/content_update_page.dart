import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../core/constants/constants.dart';
import '../../../core/models/content.dart';
import '../../../core/utils.dart';
import '../../../core/widgets/buttons/delete_button.dart';
import '../../../core/widgets/buttons/save_button.dart';
import '../../../core/widgets/textfields/textfield_widget.dart';
import '../../home/bloc/home/home_bloc.dart';
import '../bloc/content_bloc.dart';

class ContentUpdatePage extends StatefulWidget {
  const ContentUpdatePage({
    super.key,
    required this.content,
  });

  final Content content;

  @override
  State<ContentUpdatePage> createState() => _ContentUpdatePageState();
}

class _ContentUpdatePageState extends State<ContentUpdatePage> {
  final controller1 = TextEditingController();
  final controller2 = TextEditingController();

  @override
  void initState() {
    super.initState();
    controller1.text = widget.content.title;
    controller2.text = widget.content.index.toString();
  }

  @override
  void dispose() {
    controller1.dispose();
    controller2.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Text'),
        actions: [
          DeleteButton(
            title: Const.alertDeleteContent,
            onPressed: () {
              context
                  .read<ContentBloc>()
                  .add(DeleteContentEvent(widget.content));
            },
          ),
        ],
      ),
      body: ListView(
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
          const SizedBox(height: 20),
          BlocListener<ContentBloc, ContentState>(
            listener: (context, state) {
              if (state is ContentSuccessState) {
                context.pop();
                context
                    .read<HomeBloc>()
                    .add(LoadHomeEvent(state.message, state.status));
              }
              if (state is ContentErrorState) {
                showToast(context, state.message, state.status, true);
              }
            },
            child: BlocBuilder<ContentBloc, ContentState>(
              builder: (context, state) {
                return SaveButton(
                  title: Const.buttonUpdateText,
                  loading: state is ContentLoadingState,
                  onTap: () {
                    context.read<ContentBloc>().add(UpdateContentEvent(
                          Content(
                            id: widget.content.id,
                            title: controller1.text,
                            index: int.tryParse(controller2.text) ?? 0,
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
    );
  }
}
