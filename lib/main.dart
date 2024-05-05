import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_core/firebase_core.dart';

import 'core/router.dart';
import 'core/theme/themes.dart';
import 'core/firebase/firebase_options.dart';
import 'core/firebase/firebase_api.dart';

import 'features/auth/bloc/auth_bloc.dart';
import 'features/user/bloc/user_bloc.dart';
import 'features/home/bloc/home/home_bloc.dart';
import 'features/home/bloc/tab/tab_bloc.dart';
import 'features/logs/bloc/logs_bloc.dart';
import 'features/category/bloc/category_bloc.dart';
import 'features/blog/bloc/blog_bloc.dart';
import 'features/content/bloc/content_bloc.dart';
import 'features/image/bloc/image_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await FirebaseApi().initNotifications();
  runApp(const MyApp());
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
        scrollBehavior: const ScrollBehaviorModified(),
      ),
    );
  }
}

class ScrollBehaviorModified extends ScrollBehavior {
  const ScrollBehaviorModified();
  @override
  ScrollPhysics getScrollPhysics(BuildContext context) {
    return const BouncingScrollPhysics();
  }
}

// cd Desktop/backend/fastapi/test2 && source venv/bin/activate
// uvicorn src.main:app --reload
// sudo lsof -t -i tcp:8000 | xargs kill -9
// adb reverse tcp:8000 tcp:8000