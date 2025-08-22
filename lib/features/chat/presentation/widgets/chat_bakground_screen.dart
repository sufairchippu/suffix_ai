import 'dart:math';
import 'package:flutter/cupertino.dart';

class GradientMotionBackground extends StatefulWidget {
  final List<Color> colors; // Colors for the animation
  final Duration duration;

  const GradientMotionBackground({
    super.key,
    this.colors = const [
      Color(0xFF4ECDC4), // teal
      Color(0xFF1A1A2E), // dark blue
      Color(0xFF0F3460), // purple-blue
    ],
    this.duration = const Duration(seconds: 15),
  });

  @override
  State<GradientMotionBackground> createState() =>
      _GradientMotionBackgroundState();
}

class _GradientMotionBackgroundState extends State<GradientMotionBackground>
    with TickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: widget.duration)
      ..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        final t = _controller.value * 2 * pi;

        // Moving centers for gradients (gives the "flowing" effect)
        final offset1 = Alignment(sin(t * 0.5) * 0.8, cos(t * 0.6) * 0.8);
        final offset2 = Alignment(cos(t * 0.7) * 0.8, sin(t * 0.9) * 0.8);

        return Container(
          decoration: BoxDecoration(
            gradient: RadialGradient(
              center: offset1,
              radius: 1.5,
              colors: [
                widget.colors[0].withValues(alpha: 0.7),
                widget.colors[1].withValues(alpha: 0.9),
              ],
              stops: const [0.3, 1.0],
            ),
          ),
          foregroundDecoration: BoxDecoration(
            gradient: RadialGradient(
              center: offset2,
              radius: 1.5,
              colors: [
                widget.colors[2].withValues(alpha: 0.6),
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
