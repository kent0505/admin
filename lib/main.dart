import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'core/router/router.dart';
import 'core/theme/themes.dart';
import 'core/utils.dart';
import 'features/auth/bloc/auth_bloc.dart';
import 'features/user/bloc/user_bloc.dart';
import 'features/home/bloc/home/home_bloc.dart';
import 'features/home/bloc/tab/tab_bloc.dart';
import 'features/logs/bloc/logs_bloc.dart';
import 'features/category/bloc/category_bloc.dart';
import 'features/blog/bloc/blog_bloc.dart';
import 'features/content/bloc/content_bloc.dart';
import 'features/image/bloc/image_bloc.dart';

Future<void> main() async {
  runApp(const MyApp());
  await Utils.getToken();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => AuthBloc()),
        BlocProvider(create: (context) => UserBloc()),
        BlocProvider(create: (context) => HomeBloc()),
        BlocProvider(create: (context) => TabBloc()),
        BlocProvider(create: (context) => LogsBloc()),
        BlocProvider(create: (context) => CategoryBloc()),
        BlocProvider(create: (context) => BlogBloc()),
        BlocProvider(create: (context) => ContentBloc()),
        BlocProvider(create: (context) => ImageBloc()),
      ],
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        theme: theme,
        routerConfig: routerConfig,
      ),
    );
  }
}
