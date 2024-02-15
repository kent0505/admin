import 'package:blog/core/router/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../core/constants/constants.dart';
import '../../core/models/category.dart';
import '../../core/widgets/data/data_widget.dart';
import '../../core/widgets/data/header_widget.dart';
import '../home/bloc/home/home_bloc.dart';
import '../home/bloc/tab/tab_bloc.dart';

class CategoryList extends StatelessWidget {
  const CategoryList({
    super.key,
    required this.categories,
  });

  final List<Category> categories;

  @override
  Widget build(BuildContext context) {
    context.read<TabBloc>().add(ChangeTabEvent(0));

    return RefreshIndicator(
      onRefresh: () async {
        context.read<HomeBloc>().add(LoadHomeEvent(Const.toastLoaded, 200));
      },
      child: ListView(
        padding: const EdgeInsets.symmetric(vertical: 10),
        children: [
          const HeaderWidget(type: 0),
          const SizedBox(height: 10),
          for (Category category in categories) ...[
            DataWidget(
              onTap: () {
                context.push(AppRoutes.categoryUpdatePage, extra: category);
              },
              titles: [
                category.id.toString(),
                category.title,
                category.index.toString(),
                category.type.toString(),
              ],
            ),
          ],
        ],
      ),
    );
  }
}
