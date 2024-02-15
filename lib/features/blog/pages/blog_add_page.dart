import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../core/constants/constants.dart';
import '../../../core/models/blog.dart';
import '../../../core/utils.dart';
import '../../../core/widgets/buttons/save_button.dart';
import '../../../core/widgets/textfields/textfield_widget.dart';
import '../../home/bloc/home/home_bloc.dart';
import '../bloc/blog_bloc.dart';

class BlogAddPage extends StatefulWidget {
  const BlogAddPage({super.key});

  @override
  State<BlogAddPage> createState() => _BlogAddPageState();
}

class _BlogAddPageState extends State<BlogAddPage> {
  final _controller1 = TextEditingController();
  final _controller2 = TextEditingController();
  final _controller3 = TextEditingController();

  @override
  void dispose() {
    _controller1.dispose();
    _controller2.dispose();
    _controller3.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Blog'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          TextFieldWidget(
            controller: _controller1,
            hintText: 'Title',
            isTitle: true,
          ),
          TextFieldWidget(
            controller: _controller2,
            hintText: 'Index',
          ),
          TextFieldWidget(
            controller: _controller3,
            hintText: 'CID',
          ),
          DropdownMenu(
            controller: _controller3,
            onSelected: (value) {
              print(_controller3.text);
            },
            hintText: 'CID',
            dropdownMenuEntries: context
                .read<HomeBloc>()
                .categories
                .where((category) => category.type != 1)
                .map((category) => DropdownMenuEntry(
                      value: category.id,
                      label: category.title,
                    ))
                .toList(),
          ),
          const SizedBox(height: 20),
          BlocListener<BlogBloc, BlogState>(
            listener: (context, state) {
              if (state is BlogSuccessState) {
                context.pop();
                context
                    .read<HomeBloc>()
                    .add(LoadHomeEvent(state.message, state.status));
              }
              if (state is BlogErrorState) {
                Utils.showToast(context, state.message, state.status, true);
              }
            },
            child: BlocBuilder<BlogBloc, BlogState>(
              builder: (context, state) {
                return SaveButton(
                  title: Const.buttonAddText,
                  loading: state is BlogLoadingState,
                  onTap: () {
                    context.read<BlogBloc>().add(AddBlogEvent(
                          Blog(
                            id: 0,
                            title: _controller1.text,
                            index: int.tryParse(_controller2.text) ?? 0,
                            date: 0,
                            cid: int.tryParse(_controller3.text) ?? 0,
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
