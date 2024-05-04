import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../core/constants/constants.dart';
import '../../core/router.dart';
import '../../core/utils.dart';
import '../../core/widgets/action/error_text.dart';
import '../../core/widgets/action/loading_widget.dart';
import 'tabs/blogs_list.dart';
import 'tabs/category_list.dart';
import 'tabs/contents_list.dart';
import 'widgets/drawer_widget.dart';
import 'bloc/home/home_bloc.dart';
import 'bloc/tab/tab_bloc.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  void loadHome() {
    context.read<HomeBloc>().add(LoadHomeEvent());
  }

  @override
  void initState() {
    super.initState();
    loadHome();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        drawer: const DrawerWidget(),
        appBar: AppBar(
          title: Text(Const.appTitle),
          actions: [
            Tooltip(
              message: Const.tooltipOpenUrl,
              child: IconButton(
                onPressed: () {
                  context.push(AppRoutes.webPage);
                },
                icon: const Icon(Icons.language),
              ),
            ),
            Tooltip(
              message: Const.tooltipLogs,
              child: IconButton(
                icon: const Icon(Icons.data_array_rounded),
                onPressed: () {
                  context.push(AppRoutes.logsPage);
                },
              ),
            ),
            BlocBuilder<TabBloc, TabState>(
              builder: (context, state) {
                return Tooltip(
                  message: Const.tooltipAdd,
                  child: IconButton(
                    icon: const Icon(Icons.add_rounded),
                    onPressed: () {
                      if (state is TabCategoryState) {
                        context.push(AppRoutes.categoryAddPage);
                      }

                      if (state is TabBlogState) {
                        context.push(AppRoutes.blogAddPage);
                      }

                      if (state is TabContentState) {
                        context.push(AppRoutes.contentAddPage);
                      }
                    },
                  ),
                );
              },
            ),
          ],
          bottom: const TabBar(
            tabs: [
              Tab(text: 'Categories'),
              Tab(text: 'Blogs'),
              Tab(text: 'Contents'),
            ],
          ),
        ),
        body: BlocListener<HomeBloc, HomeState>(
          listener: (context, state) {
            if (state is HomeLoadedState) {
              showToast(context, 'Loaded');
            }

            if (state is HomeErrorState) {
              showToast(context, 'Error', true);
            }
          },
          child: BlocBuilder<HomeBloc, HomeState>(
            builder: (context, state) {
              if (state is HomeLoadingState) {
                return const LoadingWidget();
              }

              if (state is HomeErrorState) {
                return ErrorText(
                  errorText: 'Error',
                  onPressed: loadHome,
                );
              }

              if (state is HomeLoadedState) {
                return TabBarView(
                  children: [
                    CategoryList(categories: state.categories),
                    BlogsList(blogs: state.blogs),
                    ContentsList(contents: state.contents),
                  ],
                );
              }

              return Container();
            },
          ),
        ),
      ),
    );
  }
}
