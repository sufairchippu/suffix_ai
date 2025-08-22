import 'package:clean_architutre_learn/core/router/route_names.dart';
import 'package:clean_architutre_learn/features/authentication/presentation/pages/login_screen.dart';
import 'package:clean_architutre_learn/features/chat/presentation/pages/chat_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../features/authentication/presentation/pages/splash_screen.dart';

final GlobalKey<NavigatorState> rootNavigatorKey = GlobalKey<NavigatorState>();

final GoRouter appRouter = GoRouter(
  navigatorKey: rootNavigatorKey,
  initialLocation: '/splash',
  routes: <RouteBase>[
    //!common
    //*splash
    GoRoute(
      path: '/splash',
      name: RouteNames.splash,
      builder: (context, state) => SplashScreen(),
    ),
    GoRoute(
      path: '/login',
      name: RouteNames.login,
      builder: (context, state) => LoginScreen(),
    ),
    GoRoute(
      path: '/chat',
      name: RouteNames.chat,
      builder: (context, state) => ChatScreen(),
    ),
  ],
);
