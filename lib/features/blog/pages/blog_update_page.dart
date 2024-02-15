import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../core/constants/constants.dart';
import '../../../core/models/blog.dart';
import '../../../core/utils.dart';
import '../../../core/widgets/buttons/delete_button.dart';
import '../../../core/widgets/buttons/save_button.dart';
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
  final _controller1 = TextEditingController();
  final _controller2 = TextEditingController();
  final _controller3 = TextEditingController();

  @override
  void initState() {
    super.initState();
    _controller1.text = widget.blog.title;
    _controller2.text = widget.blog.index.toString();
    _controller3.text = widget.blog.cid.toString();
  }

  @override
  void dispose() {
    _controller1.dispose();
    _controller2.dispose();
    _controller3.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<BlogBloc>();

    return BlocListener<BlogBloc, BlogState>(
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
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Blog'),
          actions: [
            DeleteButton(
              title: Const.alertDeleteBlog,
              onPressed: () {
                bloc.add(DeleteBlogEvent(widget.blog));
              },
            ),
          ],
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
            const SizedBox(height: 20),
            BlocBuilder<BlogBloc, BlogState>(
              builder: (context, state) {
                return SaveButton(
                  title: Const.buttonUpdateText,
                  loading: state is BlogLoadingState,
                  onTap: () async {
                    bloc.add(UpdateBlogEvent(
                      Blog(
                        id: widget.blog.id,
                        title: _controller1.text,
                        index: int.tryParse(_controller2.text) ?? 0,
                        date: widget.blog.date,
                        cid: int.tryParse(_controller3.text) ?? 0,
                      ),
                    ));
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
