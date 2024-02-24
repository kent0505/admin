import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../core/constants/constants.dart';
import '../../../core/models/content.dart';
import '../../../core/router/app_routes.dart';
import '../../../core/widgets/data/data_widget.dart';
import '../../../core/widgets/data/header_widget.dart';
import '../../home/bloc/home/home_bloc.dart';
import '../../home/bloc/tab/tab_bloc.dart';

class ContentsList extends StatelessWidget {
  const ContentsList({
    super.key,
    required this.contents,
  });

  final List<Content> contents;

  @override
  Widget build(BuildContext context) {
    context.read<TabBloc>().add(ChangeTabEvent(2));

    return RefreshIndicator(
      onRefresh: () async {
        context.read<HomeBloc>().add(LoadHomeEvent(Const.toastLoaded, 200));
      },
      child: ListView(
        padding: const EdgeInsets.symmetric(vertical: 10),
        children: [
          const HeaderWidget(type: 2),
          const SizedBox(height: 10),
          for (Content content in contents) ...[
            DataWidget(
              type: 2,
              onTap: () {
                if (content.image == 0) {
                  context.push(AppRoutes.contentUpdatePage, extra: content);
                } else {
                  context.push(AppRoutes.imageUpdatePage, extra: content);
                }
              },
              titles: [
                content.id.toString(),
                content.title,
                content.index.toString(),
                content.image.toString(),
                content.bid.toString(),
              ],
            ),
          ],
        ],
      ),
    );
  }
}
