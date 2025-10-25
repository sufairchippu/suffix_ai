import 'package:clean_architutre_learn/core/router/route_names.dart';
import 'package:clean_architutre_learn/core/utils/custom_transition_page.dart';
import 'package:clean_architutre_learn/features/authentication/presentation/pages/login_screen.dart';
import 'package:clean_architutre_learn/features/authentication/presentation/pages/splash_screen.dart';
import 'package:clean_architutre_learn/features/banana/presentation/pages/nano_banana_screen.dart';
import 'package:clean_architutre_learn/features/chat/presentation/pages/chat_screen.dart';
import 'package:clean_architutre_learn/features/profile/presentation/pages/profile_screen.dart';
import 'package:clean_architutre_learn/features/profile/presentation/pages/settings_screeen.dart';
import 'package:clean_architutre_learn/features/quiz/presentation/pages/camera_result_screen.dart';
import 'package:clean_architutre_learn/features/quiz/presentation/pages/generation_screen.dart';
import 'package:clean_architutre_learn/features/quiz/presentation/pages/home_screen.dart';
import 'package:clean_architutre_learn/features/quiz/presentation/pages/quiz_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';

final GlobalKey<NavigatorState> rootNavigatorKey = GlobalKey<NavigatorState>();

final GoRouter appRouter = GoRouter(
  navigatorKey: rootNavigatorKey,
  initialLocation: '/splash',
  routes: <RouteBase>[
    //! Splash Screen with Fade
    GoRoute(
      path: '/splash',
      name: RouteNames.splash,
      pageBuilder: (context, state) => CupertinoPage(
        child: const SplashScreen(),
        //state:
        key: state.pageKey,
        // type: TransitionType.fade,
      ),
    ),

    //! Login Screen with Slide from Right
    GoRoute(
      path: '/login',
      name: RouteNames.login,
      pageBuilder: (context, state) => customBuildTransitionPage(
        child: const LoginScreen(),
        state: state,
        type: TransitionType.slideFromRight,
      ),
    ),

    //! Home Screen (Cupertino)
    GoRoute(
      path: '/home',
      name: RouteNames.home,
      pageBuilder: (context, state) => customBuildTransitionPage(
        duration: const Duration(milliseconds: 250),
        child: const HomeScreen(),
        state: state,
        type: TransitionType.scale,
      ),
      routes: [
        //! Chat Screen (Slide from Right)
        GoRoute(
          path: 'chat',
          name: RouteNames.chat,
          pageBuilder: (context, state) => customBuildTransitionPage(
            child: const ChatScreen(),
            state: state,
            type: TransitionType.slideFromLeft,
          ),
        ),
        GoRoute(
          path: 'nanoBanana',
          name: RouteNames.nanoBanana,
          pageBuilder: (context, state) => customBuildTransitionPage(
            child: const NanoBananaScreen(),
            state: state,
            type: TransitionType.scale,
          ),
        ),
        //! Camera Screen
        GoRoute(
          path: 'camera',
          name: RouteNames.camera,
          pageBuilder: (context, state) => customBuildTransitionPage(
            child: const CameraResultScreen(),
            state: state,
            type: TransitionType.slideFromRight,
          ),
        ),
        //! quiz Screen
        GoRoute(
          path: 'quiz',
          name: RouteNames.quiz,
          pageBuilder: (context, state) {
            return customBuildTransitionPage(
              child: const QuizScreen(),
              state: state,
              type: TransitionType.slideFromRight,
            );
          },
        ),
        //! Settings Screen (Slide from right)
        GoRoute(
          path: 'settings',
          name: RouteNames.settings,
          pageBuilder: (context, state) => customBuildTransitionPage(
            child: const SettingsScreeen(),
            state: state,
            type: TransitionType.slideFromRight,
          ),

          routes: [
            //! Profile Screen (Scale)
            GoRoute(
              path: 'profile',
              name: RouteNames.profile,
              pageBuilder: (context, state) => customBuildTransitionPage(
                child: const ProfileScreen(),
                state: state,

                type: TransitionType.scale,
              ),
            ),
          ],
        ),
        GoRoute(
          path: 'generate',
          name: RouteNames.generate,
          pageBuilder: (context, state) => customBuildTransitionPage(
            child: const GenerationScreen(),
            state: state,
          ),
        ),
      ],
    ),
  ],
);
