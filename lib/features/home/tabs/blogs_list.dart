import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../core/models/blog.dart';
import '../../../core/widgets/data/data_widget.dart';
import '../../../core/widgets/data/header_widget.dart';
import '../bloc/home/home_bloc.dart';
import '../bloc/tab/tab_bloc.dart';

class BlogsList extends StatelessWidget {
  const BlogsList({super.key, required this.blogs});

  final List<Blog> blogs;

  @override
  Widget build(BuildContext context) {
    context.read<TabBloc>().add(ChangeTabEvent(index: 1));

    return RefreshIndicator(
      onRefresh: () async {
        context.read<HomeBloc>().add(LoadHomeEvent());
      },
      child: ListView(
        padding: const EdgeInsets.symmetric(vertical: 10),
        children: [
          const HeaderWidget(type: 1),
          const SizedBox(height: 10),
          for (Blog blog in blogs) ...[
            DataWidget(
              type: 1,
              onTap: () {
                context.push('/blog_update', extra: blog);
              },
              titles: [
                blog.id.toString(),
                blog.title,
                blog.index.toString(),
                blog.cid.toString(),
              ],
            ),
          ],
        ],
      ),
    );
  }
}
