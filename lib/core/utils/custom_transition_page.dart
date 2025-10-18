import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';

/// Enum for different transition types
enum TransitionType { cupertino, slideFromRight, slideFromLeft, fade, scale }

/// Helper function to build a custom page with transition
CustomTransitionPage<void> customBuildTransitionPage({
  required Widget child,
  required GoRouterState state,
  TransitionType type = TransitionType.cupertino,
  Duration duration = const Duration(milliseconds: 400),
}) {
  return CustomTransitionPage<void>(
    key: state.pageKey,
    child: child,
    fullscreenDialog: true, // 👈 ensures fullscreen
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      // Disable rounded corner clipping by wrapping in ClipRect
      return ClipRect(
        // 👈 important
        child: _buildTransition(type, animation, secondaryAnimation, child),
      );
    },
    transitionDuration: duration,
    reverseTransitionDuration: duration,
  );
}

Widget _buildTransition(
  TransitionType type,
  Animation<double> animation,
  Animation<double> secondaryAnimation,
  Widget child,
) {
  switch (type) {
    case TransitionType.cupertino:
      return CupertinoPageTransition(
        primaryRouteAnimation: animation,
        secondaryRouteAnimation: secondaryAnimation,
        linearTransition: true,
        child: child,
      );

    case TransitionType.slideFromRight:
      return SlideTransition(
        position: animation.drive(
          Tween(
            begin: const Offset(1.0, 0.0),
            end: Offset.zero,
          ).chain(CurveTween(curve: Curves.easeInOut)),
        ),
        child: SlideTransition(
          position: secondaryAnimation.drive(
            Tween(
              begin: Offset.zero,
              end: const Offset(-1.0, 0.0),
            ).chain(CurveTween(curve: Curves.easeInOut)),
          ),
          child: child,
        ),
      );

    case TransitionType.slideFromLeft:
      return SlideTransition(
        position: animation.drive(
          Tween(
            begin: const Offset(-1.0, 0.0),
            end: Offset.zero,
          ).chain(CurveTween(curve: Curves.easeInOut)),
        ),
        child: SlideTransition(
          position: secondaryAnimation.drive(
            Tween(
              begin: Offset.zero,
              end: const Offset(1.0, 0.0),
            ).chain(CurveTween(curve: Curves.easeInOut)),
          ),
          child: child,
        ),
      );

    case TransitionType.fade:
      return FadeTransition(
        opacity: animation,
        child: FadeTransition(
          opacity: Tween<double>(
            begin: 1.0,
            end: 0.0,
          ).animate(secondaryAnimation),
          child: child,
        ),
      );

    case TransitionType.scale:
      return ScaleTransition(
        scale: animation.drive(
          Tween(
            begin: 0.8,
            end: 1.0,
          ).chain(CurveTween(curve: Curves.easeInOut)),
        ),
        child: ScaleTransition(
          scale: secondaryAnimation.drive(
            Tween(
              begin: 1.0,
              end: 0.8,
            ).chain(CurveTween(curve: Curves.easeInOut)),
          ),
          child: child,
        ),
      );
  }
}
