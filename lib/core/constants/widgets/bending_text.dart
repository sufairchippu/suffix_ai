import 'dart:math';

import 'package:clean_architutre_learn/core/theme/text/app_text.dart';
import 'package:flutter/cupertino.dart';

class BendingText extends StatelessWidget {
  final String text;
  final double radius;
  final double? startAngle;
  final double? sweepAngle;
  final bool clockwise;
  final bool inside;
  final double? letterSpacing;
  final TextStyle? textStyle;

  const BendingText({
    super.key,
    required this.text,
    required this.radius,
    this.startAngle,
    this.sweepAngle,
    this.clockwise = true,
    this.inside = false,
    this.letterSpacing,
    this.textStyle,
  });
  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _CircularTextPainter(
        text: text,
        radius: radius,
        startAngle: startAngle ?? -90,
        sweepAngle: sweepAngle ?? 360,
        clockwise: clockwise,
        inside: inside,
        letterSpacing: letterSpacing ?? 1,
        textStyle:
            textStyle ?? AppText.getStyle(context, TextStyleType.heading),
      ),
    );
  }
}

class _CircularTextPainter extends CustomPainter {
  final String text;
  final double radius;
  final double startAngle;
  final double sweepAngle;
  final bool clockwise;
  final bool inside;
  final double letterSpacing;
  final TextStyle textStyle;

  _CircularTextPainter({
    required this.text,
    required this.radius,
    required this.startAngle,
    required this.sweepAngle,
    required this.clockwise,
    required this.inside,
    required this.letterSpacing,
    required this.textStyle,
  });
  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final angleStep = (sweepAngle * pi / 180) / text.length;
    double currentAngle = startAngle * pi / 180;

    for (int i = 0; i < text.length; i++) {
      final char = text[i];

      final angle = clockwise
          ? currentAngle + i * angleStep * letterSpacing
          : currentAngle - i * angleStep * letterSpacing;

      final effectiveRadius = inside ? radius - 12 : radius;

      final position = Offset(
        center.dx + effectiveRadius * cos(angle),
        center.dy + effectiveRadius * sin(angle),
      );

      canvas.save();
      canvas.translate(position.dx, position.dy);

      canvas.rotate(
        angle +
            (clockwise
                ? (inside ? -pi / 2 : pi / 2)
                : (inside ? pi / 2 : -pi / 2)),
      );

      final textPainter = TextPainter(
        text: TextSpan(text: char, style: textStyle),
        textDirection: TextDirection.ltr,
      )..layout();

      textPainter.paint(
        canvas,
        Offset(-textPainter.width / 2, -textPainter.height / 2),
      );

      canvas.restore();
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
