import 'package:go_router/go_router.dart';

import '../features/splash/splash_page.dart';
import '../features/auth/auth_page.dart';
import '../features/user/user_page.dart';
import '../features/home/home_page.dart';
import '../features/web/web_page.dart';
import '../features/logs/logs_page.dart';
import '../features/category/pages/category_add_page.dart';
import '../features/blog/pages/blog_add_page.dart';
import '../features/content/pages/content_add_page.dart';
import '../features/category/pages/category_update_page.dart';
import '../features/blog/pages/blog_update_page.dart';
import '../features/content/pages/content_update_page.dart';
import '../features/image/image_page.dart';

import 'firebase/notification_page.dart';
import 'models/category.dart';
import 'models/blog.dart';
import 'models/content.dart';

final routerConfig = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const SplashPage(),
    ),
    GoRoute(
      path: '/auth',
      builder: (context, state) => const AuthPage(),
    ),
    GoRoute(
      path: '/user',
      builder: (context, state) => const UserPage(),
    ),
    GoRoute(
      path: '/home',
      builder: (context, state) => const HomePage(),
    ),
    GoRoute(
      path: '/notification',
      builder: (context, state) => const NotificationPage(),
    ),
    GoRoute(
      path: '/logs',
      builder: (context, state) => const LogsPage(),
      onExit: (context) => true,
    ),
    GoRoute(
      path: '/web',
      builder: (context, state) => const WebPage(),
    ),
    GoRoute(
      path: '/category_add',
      builder: (context, state) => const CategoryAddPage(),
    ),
    GoRoute(
      path: '/blog_add',
      builder: (context, state) => const BlogAddPage(),
    ),
    GoRoute(
      path: '/content_add',
      builder: (context, state) => const ContentAddPage(),
      onExit: (context) => true,
    ),
    GoRoute(
      path: '/category_update',
      builder: (context, state) => CategoryUpdatePage(
        category: state.extra as Category,
      ),
    ),
    GoRoute(
      path: '/blog_update',
      builder: (context, state) => BlogUpdatePage(
        blog: state.extra as Blog,
      ),
    ),
    GoRoute(
      path: '/content_update',
      builder: (context, state) => ContentUpdatePage(
        content: state.extra as Content,
      ),
    ),
    GoRoute(
      path: '/image_update',
      builder: (context, state) => ImagePage(
        content: state.extra as Content,
      ),
      onExit: (context) => true,
    ),
  ],
);
