import 'package:clean_architutre_learn/core/router/route_names.dart';
import 'package:clean_architutre_learn/features/authentication/presentation/pages/login_screen.dart';
import 'package:clean_architutre_learn/features/chat/presentation/pages/chat_screen.dart';
import 'package:clean_architutre_learn/features/profile/presentation/pages/profile_screen.dart';
import 'package:clean_architutre_learn/features/profile/presentation/pages/settings_screeen.dart';
import 'package:clean_architutre_learn/features/quiz/presentation/pages/home_screen.dart';
import 'package:flutter/cupertino.dart';

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
      path: '/home',
      name: RouteNames.home,
      builder: (context, state) => HomeScreen(),
      routes: [
        GoRoute(
          path: '/chat',
          name: RouteNames.chat,
          builder: (context, state) => ChatScreen(),
        ),
        GoRoute(
          path: 'settings',
          name: RouteNames.settings,
          builder: (context, state) => SettingsScreeen(),
          routes: [
            GoRoute(
              path: 'profile',
              name: RouteNames.profile,
              builder: (context, state) => ProfileScreen(),
            ),
          ],
        ),
      ],
    ),
  ],
);
