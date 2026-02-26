import 'package:clean_architutre_learn/core/mesurment/reponsive_size.dart';
import 'package:clean_architutre_learn/core/theme/app_color/app_theme_genartor.dart';
import 'package:flutter/cupertino.dart';

class CupertinoAnimatedProgress extends StatelessWidget {
  final double percent;

  const CupertinoAnimatedProgress({super.key, required this.percent});

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0.0, end: percent),
      duration: const Duration(milliseconds: 900),
      curve: Curves.easeOutCubic,
      builder: (context, value, _) {
        return CupertinoActivityIndicator.partiallyRevealed(
          radius: 22.rf(context),
          progress: value,
          color: context.primaryColor,
        );
      },
    );
  }
}