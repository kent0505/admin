import 'package:go_router/go_router.dart';

import '../../features/splash/splash_page.dart';
import '../../features/auth/auth_page.dart';
import '../../features/user/user_page.dart';
import '../../features/home/home_page.dart';
import '../../features/web/web_page.dart';
import '../../features/logs/logs_page.dart';
import '../../features/category/pages/category_add_page.dart';
import '../../features/blog/pages/blog_add_page.dart';
import '../../features/content/pages/content_add_page.dart';
import '../../features/category/pages/category_update_page.dart';
import '../../features/blog/pages/blog_update_page.dart';
import '../../features/content/pages/content_update_page.dart';
import '../../features/image/image_page.dart';

import '../models/category.dart';
import '../models/blog.dart';
import '../models/content.dart';
import 'app_routes.dart';

GoRouter routerConfig = GoRouter(
  initialLocation: AppRoutes.splashPage,
  routes: [
    GoRoute(
      path: AppRoutes.splashPage,
      builder: (context, state) => const SplashPage(),
    ),
    GoRoute(
      path: AppRoutes.authPage,
      builder: (context, state) => const AuthPage(),
    ),
    GoRoute(
      path: AppRoutes.userPage,
      builder: (context, state) => const UserPage(),
    ),
    GoRoute(
      path: AppRoutes.homePage,
      builder: (context, state) => const HomePage(),
    ),
    GoRoute(
      path: AppRoutes.logsPage,
      builder: (context, state) => const LogsPage(),
      onExit: (context) => true,
    ),
    GoRoute(
      path: AppRoutes.webPage,
      builder: (context, state) => const WebPage(),
    ),
    GoRoute(
      path: AppRoutes.categoryAddPage,
      builder: (context, state) => const CategoryAddPage(),
    ),
    GoRoute(
      path: AppRoutes.blogAddPage,
      builder: (context, state) => const BlogAddPage(),
    ),
    GoRoute(
      path: AppRoutes.contentAddPage,
      builder: (context, state) => const ContentAddPage(),
      onExit: (context) => true,
    ),
    GoRoute(
      path: AppRoutes.categoryUpdatePage,
      builder: (context, state) => CategoryUpdatePage(
        category: state.extra as Category,
      ),
    ),
    GoRoute(
      path: AppRoutes.blogUpdatePage,
      builder: (context, state) => BlogUpdatePage(
        blog: state.extra as Blog,
      ),
    ),
    GoRoute(
      path: AppRoutes.contentUpdatePage,
      builder: (context, state) => ContentUpdatePage(
        content: state.extra as Content,
      ),
    ),
    GoRoute(
      path: AppRoutes.imageUpdatePage,
      builder: (context, state) => ImagePage(
        content: state.extra as Content,
      ),
      onExit: (context) => true,
    ),
  ],
);
