import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../core/constants/constants.dart';
import '../../../core/models/blog.dart';
import '../../../core/utils.dart';
import '../../../core/widgets/buttons/delete_button.dart';
import '../../../core/widgets/buttons/save_button.dart';
import '../../../core/widgets/dropdown/dropdown_cid.dart';
import '../../../core/widgets/textfields/textfield_widget.dart';
import '../../home/bloc/home/home_bloc.dart';
import '../bloc/blog_bloc.dart';

class BlogUpdatePage extends StatefulWidget {
  const BlogUpdatePage({
    super.key,
    required this.blog,
  });

  final Blog blog;

  @override
  State<BlogUpdatePage> createState() => _BlogUpdatePageState();
}

class _BlogUpdatePageState extends State<BlogUpdatePage> {
  final controller1 = TextEditingController();
  final controller2 = TextEditingController();
  final controller3 = TextEditingController();

  @override
  void initState() {
    super.initState();
    controller1.text = widget.blog.title;
    controller2.text = widget.blog.index.toString();
    controller3.text = widget.blog.cid.toString();
  }

  @override
  void dispose() {
    controller1.dispose();
    controller2.dispose();
    controller3.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Blog'),
        actions: [
          DeleteButton(
            title: Const.alertDeleteBlog,
            onPressed: () {
              context.read<BlogBloc>().add(DeleteBlogEvent(id: widget.blog.id));
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
          DropdownCID(controller: controller3),
          const SizedBox(height: 20),
          BlocListener<BlogBloc, BlogState>(
            listener: (context, state) {
              if (state is BlogSuccessState) {
                showToast(context, 'BlogSuccessState');
                context.pop();
                context.read<HomeBloc>().add(LoadHomeEvent());
              }
              if (state is BlogErrorState) {
                showToast(context, 'BlogErrorState', true);
              }
            },
            child: BlocBuilder<BlogBloc, BlogState>(
              builder: (context, state) {
                return SaveButton(
                  title: Const.buttonUpdateText,
                  loading: state is BlogLoadingState,
                  onPressed: () {
                    context.read<BlogBloc>().add(UpdateBlogEvent(
                          blog: BlogModel(
                            id: widget.blog.id,
                            title: controller1.text,
                            index: controller2.text,
                            cid: controller3.text,
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
