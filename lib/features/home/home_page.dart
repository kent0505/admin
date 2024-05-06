import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

import '../../core/constants/constants.dart';
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
    FirebaseMessaging.onMessageOpenedApp.listen(
      (event) => context.push('/notification'),
    );
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        drawer: const DrawerWidget(),
        appBar: AppBar(
          // title: Text(Const.appTitle),
          actions: [
            Tooltip(
              message: 'Notifications',
              child: IconButton(
                onPressed: () {
                  context.push('/notification');
                },
                icon: const Icon(Icons.notifications),
              ),
            ),
            Tooltip(
              message: Const.tooltipOpenUrl,
              child: IconButton(
                onPressed: () {
                  context.push('/web');
                },
                icon: const Icon(Icons.language),
              ),
            ),
            Tooltip(
              message: Const.tooltipLogs,
              child: IconButton(
                icon: const Icon(Icons.data_array_rounded),
                onPressed: () {
                  context.push('/logs');
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
                        context.push('/category_add');
                      }

                      if (state is TabBlogState) {
                        context.push('/blog_add');
                      }

                      if (state is TabContentState) {
                        context.push('/content_add');
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
              showToast(context, 'HomeLoadedState');
            }

            if (state is HomeErrorState) {
              showToast(context, 'HomeErrorState', true);
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
