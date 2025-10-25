import 'dart:math';

import 'package:flutter/cupertino.dart';

import '../../../../core/theme/app_color/app_color.dart';

class GradientMotionBackground extends StatefulWidget {
  final Duration duration;
  final Color? colorr1;
  final Color? colorr2;
  final Color? colorr3;
  const GradientMotionBackground({
    super.key,
    this.duration = const Duration(seconds: 15),
    this.colorr1,
    this.colorr2,
    this.colorr3,
  });

  @override
  State<GradientMotionBackground> createState() =>
      _GradientMotionBackgroundState();
}

class _GradientMotionBackgroundState extends State<GradientMotionBackground>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: widget.duration)
      ..repeat();
    _animation = CurvedAnimation(parent: _controller, curve: Curves.linear);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // ✅ Resolve dynamic colors here (updates automatically on theme change)
    final color1 =
        widget.colorr1 ?? AppColors.dynamicColor1.resolveFrom(context);
    final color2 =
        widget.colorr2 ?? AppColors.dynamicColor2.resolveFrom(context);
    final color3 =
        widget.colorr3 ?? AppColors.dynamicColor3.resolveFrom(context);

    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        final t = _animation.value * 2 * pi;
        final offset1 = Alignment(sin(t * 0.4), cos(t * 0.5));
        final offset2 = Alignment(cos(t * 0.6), sin(t * 0.8));

        return Container(
          decoration: BoxDecoration(
            gradient: RadialGradient(
              center: offset1,
              radius: 1.5,
              colors: [
                color1.withValues(alpha: 0.7),
                color2.withValues(alpha: 0.9),
              ],
              stops: const [0.3, 1.0],
            ),
          ),
          foregroundDecoration: BoxDecoration(
            gradient: RadialGradient(
              center: offset2,
              radius: 1.5,
              colors: [
                color3.withValues(alpha: 0.6),
                CupertinoColors.black.withValues(alpha: 0.6),
              ],
              stops: const [0.4, 1.0],
            ),
          ),
        );
      },
    );
  }
}
